import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wefix/Business/AppProvider/app_provider.dart';
import 'package:wefix/Business/Bookings/bookings_apis.dart';
import 'package:wefix/Data/Constant/theme/color_constant.dart';
import 'package:wefix/Presentation/B2B/ticket/components/draggable_card_bottom_sheet.dart';
import 'package:wefix/Presentation/B2B/ticket/components/dropdown_card_item.dart';
import 'package:wefix/Presentation/Components/custom_botton_widget.dart';
import 'package:wefix/Presentation/Components/widget_form_text.dart';
import 'package:wefix/Presentation/SubCategory/Components/add_attachment_widget.dart' show UploadOptionsScreen;
import 'package:wefix/Presentation/appointment/Components/google_maps_widget.dart';
import 'package:wefix/l10n/app_localizations.dart';

class CreateUpdateTicketScreenV2 extends StatefulWidget {
  final Map<String, dynamic>? ticketData;

  const CreateUpdateTicketScreenV2({super.key, this.ticketData});

  @override
  State<CreateUpdateTicketScreenV2> createState() => _CreateUpdateTicketScreenV2State();
}

class _CreateUpdateTicketScreenV2State extends State<CreateUpdateTicketScreenV2>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  // Controllers
  final TextEditingController locationDescription = TextEditingController();
  final TextEditingController serviceDescription = TextEditingController();

  // Selected items
  DropdownCardItem? selectedContract;
  DropdownCardItem? selectedBranch;
  DropdownCardItem? selectedZone;
  DropdownCardItem? selectedMainService;
  DropdownCardItem? selectedSubService;
  DropdownCardItem? selectedTeamLeader;
  DropdownCardItem? selectedTechnician;
  DropdownCardItem? selectedTicketStatus; // For editing only
  DropdownCardItem? selectedTicketType; // Selected ticket type

  // Lists (these should be fetched from APIs)
  List<DropdownCardItem> contracts = [];
  List<DropdownCardItem> branches = [];
  List<DropdownCardItem> zones = [];
  List<DropdownCardItem> mainServices = [];
  List<DropdownCardItem> subServices = [];
  List<DropdownCardItem> teamLeaders = [];
  List<DropdownCardItem> technicians = [];
  List<DropdownCardItem> ticketStatuses = [];
  List<DropdownCardItem> ticketTypes = [];

  // Location and time
  LatLng? selectedLocation; // Store location coordinates
  String? selectedTimeFrom; // e.g., "08:00:00"
  String? selectedTimeTo; // e.g., "10:00:00"
  DateTime? selectedTicketDate;

  // Generate time slots from 8:00 to 18:00 in 2-hour intervals
  List<Map<String, String>> get allTimeSlots => [
    {'from': '08:00:00', 'to': '10:00:00', 'display': '8:00 - 10:00'},
    {'from': '10:00:00', 'to': '12:00:00', 'display': '10:00 - 12:00'},
    {'from': '12:00:00', 'to': '14:00:00', 'display': '12:00 - 14:00'},
    {'from': '14:00:00', 'to': '16:00:00', 'display': '14:00 - 16:00'},
    {'from': '16:00:00', 'to': '18:00:00', 'display': '16:00 - 18:00'},
  ];

  // Get available time slots based on current time
  List<Map<String, String>> getAvailableTimeSlots() {
    final now = DateTime.now();
    final currentHour = now.hour;
    final currentMinute = now.minute;
    final currentTimeInMinutes = currentHour * 60 + currentMinute;

    return allTimeSlots.where((slot) {
      final fromTime = slot['from']!;
      final parts = fromTime.split(':');
      final slotHour = int.parse(parts[0]);
      final slotMinute = int.parse(parts[1]);
      final slotTimeInMinutes = slotHour * 60 + slotMinute;

      // If selected date is today, filter slots by current time
      // Otherwise, show all slots
      if (selectedTicketDate != null) {
        final isToday = selectedTicketDate!.year == now.year &&
            selectedTicketDate!.month == now.month &&
            selectedTicketDate!.day == now.day;
        
        if (isToday) {
          // Only show slots that start after current time
          return slotTimeInMinutes > currentTimeInMinutes;
        }
      }

      // If no date selected or date is in future, show all slots
      return true;
    }).toList();
  }

  // Attachments
  List<Map<String, String?>> uploadedFiles = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadInitialData();
    if (widget.ticketData != null) {
      _populateFieldsFromTicketData(widget.ticketData!);
    }
  }

  Future<void> _loadInitialData() async {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    final token = appProvider.accessToken ?? appProvider.userModel?.token ?? '';

    if (token.isEmpty) {
      return;
    }

    // Load all data in parallel
    final results = await Future.wait([
      BookingApi.getCompanyContracts(token: token, context: context),
      BookingApi.getCompanyBranches(token: token, context: context),
      BookingApi.getCompanyZones(token: token, context: context),
      BookingApi.getMainServices(token: token, context: context),
      BookingApi.getSubServices(token: token, context: context),
      BookingApi.getCompanyTeamLeaders(token: token, context: context),
      BookingApi.getCompanyTechnicians(token: token, context: context),
      BookingApi.getTicketTypes(token: token, context: context), // Fetch ticket types
    ]);

    if (!mounted) return;

    setState(() {
      // Contracts
      final contractsData = results[0];
      if (contractsData != null) {
        contracts = contractsData.map((item) => DropdownCardItem(
              id: item['id'] as int,
              title: item['title'] as String? ?? item['contractReference'] as String? ?? '',
              subtitle: item['subtitle'] as String? ?? item['contractTitle'] as String?,
              icon: Icons.description,
              data: item,
            )).toList();
      }

      // Branches
      final branchesData = results[1];
      if (branchesData is List<Map<String, dynamic>> && branchesData.isNotEmpty) {
        branches = branchesData.map((item) => DropdownCardItem(
              id: item['id'] as int,
              title: item['title'] as String? ?? item['branchTitle'] as String? ?? '',
              subtitle: item['subtitle'] as String?,
              icon: Icons.business,
              data: item,
            )).toList();
      }

      // Zones
      final zonesData = results[2];
      if (zonesData is List<Map<String, dynamic>> && zonesData.isNotEmpty) {
        zones = zonesData.map((item) => DropdownCardItem(
              id: item['id'] as int,
              title: item['title'] as String? ?? item['zoneTitle'] as String? ?? '',
              subtitle: item['subtitle'] as String? ?? item['zoneNumber'] as String?,
              icon: Icons.map,
              data: item,
            )).toList();
      }

      // Main Services
      final mainServicesData = results[3];
      if (mainServicesData is List<Map<String, dynamic>> && mainServicesData.isNotEmpty) {
        mainServices = mainServicesData.map((item) => DropdownCardItem(
              id: item['id'] as int,
              title: item['title'] as String? ?? item['name'] as String? ?? '',
              subtitle: item['subtitle'] as String? ?? item['nameArabic'] as String?,
              icon: Icons.build,
              data: item,
            )).toList();
      }

      // Sub Services
      final subServicesData = results[4];
      if (subServicesData is List<Map<String, dynamic>> && subServicesData.isNotEmpty) {
        subServices = subServicesData.map((item) => DropdownCardItem(
              id: item['id'] as int,
              title: item['title'] as String? ?? item['name'] as String? ?? '',
              subtitle: item['subtitle'] as String? ?? item['nameArabic'] as String?,
              icon: Icons.settings,
              data: item,
            )).toList();
      }

      // Team Leaders
      final teamLeadersData = results[5];
      if (teamLeadersData is List<Map<String, dynamic>> && teamLeadersData.isNotEmpty) {
        teamLeaders = teamLeadersData.map((item) => DropdownCardItem(
              id: item['id'] as int,
              title: item['title'] as String? ?? item['fullName'] as String? ?? '',
              subtitle: item['subtitle'] as String? ?? item['userNumber'] as String? ?? item['email'] as String?,
              icon: Icons.person_outline,
              data: item,
            )).toList();
      }

      // Technicians
      final techniciansData = results[6];
      if (techniciansData is List<Map<String, dynamic>> && techniciansData.isNotEmpty) {
        technicians = techniciansData.map((item) => DropdownCardItem(
              id: item['id'] as int,
              title: item['title'] as String? ?? item['fullName'] as String? ?? '',
              subtitle: item['subtitle'] as String? ?? item['userNumber'] as String? ?? item['email'] as String?,
              icon: Icons.engineering,
              data: item,
            )).toList();
      }

      // Ticket Types
      final ticketTypesData = results[7];
      log('Ticket Types Data: $ticketTypesData');
      if (ticketTypesData != null) {
        final ticketTypesList = List<Map<String, dynamic>>.from(ticketTypesData as List);
        if (ticketTypesList.isNotEmpty) {
          ticketTypes = ticketTypesList.map((item) => DropdownCardItem(
                id: item['id'] as int,
                title: item['title'] as String? ?? item['name'] as String? ?? '',
                subtitle: item['subtitle'] as String? ?? item['nameArabic'] as String?,
                icon: Icons.category,
                data: item,
              )).toList();
          
          log('Ticket Types mapped: ${ticketTypes.length} items');
          
          // Find "Corrective" ticket type (case-insensitive) or use first one
          try {
            selectedTicketType = ticketTypes.firstWhere(
              (type) => type.title.toLowerCase().contains('corrective'),
            );
            log('Auto-selected Corrective ticket type: ${selectedTicketType?.title}');
          } catch (e) {
            // If "Corrective" not found, use first ticket type
            if (ticketTypes.isNotEmpty) {
              selectedTicketType = ticketTypes.first;
              log('Auto-selected first ticket type: ${selectedTicketType?.title}');
            }
          }
        } else {
          log('Ticket Types Data is empty list');
        }
      } else {
        log('Ticket Types Data is null');
      }

      // Auto-select first items
      if (contracts.isNotEmpty) selectedContract = contracts.first;
      if (branches.isNotEmpty) selectedBranch = branches.first;
      if (zones.isNotEmpty) selectedZone = zones.first;
      if (mainServices.isNotEmpty) {
        selectedMainService = mainServices.first;
        // Load sub services for the first main service
        _loadSubServices(mainServices.first.id);
      }
      if (subServices.isNotEmpty) selectedSubService = subServices.first;
      
      // Auto-select team leader and technician based on current user role
      final currentUserRoleId = appProvider.userModel?.customer.roleId;
      if (currentUserRoleId == 20 && teamLeaders.isNotEmpty) { // Team Leader (roleId = 20)
        // If current user is team leader, try to auto-select themselves
        final currentUserId = appProvider.userModel?.customer.id;
        try {
          selectedTeamLeader = teamLeaders.firstWhere(
            (leader) => leader.id == currentUserId,
          );
        } catch (e) {
          // If current user not found in team leaders list, select first one
          selectedTeamLeader = teamLeaders.first;
        }
      } else if (teamLeaders.isNotEmpty) {
        selectedTeamLeader = teamLeaders.first;
      }
      
      if (technicians.isNotEmpty) {
        selectedTechnician = technicians.first;
      }

            // Set default date
            selectedTicketDate = DateTime.now();
            // Set default time from available slots based on current time
            final now = DateTime.now();
            final currentTimeInMinutes = now.hour * 60 + now.minute;
            final sixteenHundredInMinutes = 16 * 60; // 16:00 = 960 minutes
            
            final availableSlots = getAvailableTimeSlots();
            if (availableSlots.isNotEmpty) {
              // Select the first available slot (which will be the next slot after current time)
              selectedTimeFrom = availableSlots.first['from'];
              selectedTimeTo = availableSlots.first['to'];
            } else if (currentTimeInMinutes >= sixteenHundredInMinutes) {
              // If current time exceeds 16:00 and no slots are available, default to the latest slot (16:00-18:00)
              final lastSlot = allTimeSlots.last;
              selectedTimeFrom = lastSlot['from'];
              selectedTimeTo = lastSlot['to'];
            }
    });
  }

  void _populateFieldsFromTicketData(Map<String, dynamic> data) {
    locationDescription.text = data['locationDescription'] ?? '';
    serviceDescription.text = data['serviceDescription'] ?? '';
    // TODO: Map other fields when APIs are available
  }

  Future<void> _loadSubServices(int mainServiceId) async {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    final token = appProvider.accessToken ?? appProvider.userModel?.token ?? '';

    if (token.isEmpty) {
      return;
    }

    final subServicesData = await BookingApi.getSubServices(
      token: token,
      parentServiceId: mainServiceId,
      context: context,
    );

    if (!mounted) return;

    setState(() {
      if (subServicesData != null) {
        subServices = subServicesData.map((item) => DropdownCardItem(
              id: item['id'] as int,
              title: item['title'] as String? ?? item['name'] as String? ?? '',
              subtitle: item['subtitle'] as String? ?? item['nameArabic'] as String?,
              icon: Icons.settings,
              data: item,
            )).toList();
        // Auto-select first sub service if available
        if (subServices.isNotEmpty) {
          selectedSubService = subServices.first;
        }
      }
    });
  }

  void _showDropdownBottomSheet({
    required String title,
    required List<DropdownCardItem> items,
    required DropdownCardItem? selectedItem,
    required Function(DropdownCardItem) onSelected,
  }) {
    DraggableCardBottomSheet.show(
      context: context,
      title: title,
      items: items,
      selectedItem: selectedItem,
      onItemSelected: onSelected,
    );
  }

  void _goToNextTab() {
    if (_tabController.index < _tabController.length - 1) {
      _tabController.animateTo(_tabController.index + 1);
    }
  }

  void _goToPreviousTab() {
    if (_tabController.index > 0) {
      _tabController.animateTo(_tabController.index - 1);
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Validate required fields
    if (selectedContract == null ||
        selectedBranch == null ||
        selectedZone == null ||
        selectedMainService == null ||
        locationDescription.text.isEmpty ||
        selectedLocation == null ||
        selectedTeamLeader == null ||
        selectedTechnician == null ||
        selectedTimeFrom == null ||
        selectedTimeTo == null ||
        selectedTicketType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.required)),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final appProvider = Provider.of<AppProvider>(context, listen: false);
      final token = appProvider.accessToken ?? appProvider.userModel?.token ?? '';

      // Extract file paths from uploaded files
      final List<String> attachmentPaths = [];
      for (var file in uploadedFiles) {
        if (file['image'] != null && file['image']!.isNotEmpty) {
          attachmentPaths.add(file['image']!);
        }
        if (file['file'] != null && file['file']!.isNotEmpty) {
          attachmentPaths.add(file['file']!);
        }
        if (file['audio'] != null && file['audio']!.isNotEmpty) {
          attachmentPaths.add(file['audio']!);
        }
      }

      // Format location map as "latitude,longitude"
      final locationMapStr = '${selectedLocation!.latitude},${selectedLocation!.longitude}';
      
      // Use selected time strings directly (already in HH:mm:ss format)
      final timeFromStr = selectedTimeFrom!;
      final timeToStr = selectedTimeTo!;
      
      // Format date
      final ticketDateStr = selectedTicketDate != null
          ? DateFormat('yyyy-MM-dd').format(selectedTicketDate!)
          : DateFormat('yyyy-MM-dd').format(DateTime.now());

      // Remove subServiceId if it's null (backend doesn't accept undefined fields)
      final ticketData = <String, dynamic>{
        'contractId': selectedContract!.id,
        'branchId': selectedBranch!.id,
        'zoneId': selectedZone!.id,
        'locationDescription': locationDescription.text.trim(),
        'locationMap': locationMapStr, // Required: latitude,longitude format
        'ticketTypeId': selectedTicketType!.id,
        'ticketDate': ticketDateStr,
        'ticketTimeFrom': timeFromStr,
        'ticketTimeTo': timeToStr,
        'assignToTeamLeaderId': selectedTeamLeader!.id,
        'assignToTechnicianId': selectedTechnician!.id,
        'ticketDescription': locationDescription.text.trim(),
        'havingFemaleEngineer': false,
        'withMaterial': false,
        'mainServiceId': selectedMainService!.id,
        if (selectedSubService != null) 'subServiceId': selectedSubService!.id,
        if (serviceDescription.text.trim().isNotEmpty) 'serviceDescription': serviceDescription.text.trim(),
        // Note: fileIds will be sent separately after uploading files
        // Note: customerName, tools can be added later
      };

      // Add ticket status if editing (only admins and team leaders can change it)
      if (widget.ticketData != null && selectedTicketStatus != null) {
        ticketData['ticketStatusId'] = selectedTicketStatus!.id;
      }

      // Step 1: Create or update the ticket first
      Map<String, dynamic>? result;
      if (widget.ticketData != null) {
        result = await BookingApi.updateTicketInMMS(
          token: token,
          ticketId: widget.ticketData!['id'],
          ticketData: ticketData,
          context: context,
        );
      } else {
        result = await BookingApi.createTicketInMMS(
          token: token,
          ticketData: ticketData,
          context: context,
        );
      }

      // Step 2: If ticket created successfully and there are attachments, upload them with the ticket ID
      if (result != null && attachmentPaths.isNotEmpty) {
        final ticketId = result['id'] as int;
        
        // Upload files with the ticket ID so they're linked immediately
        final uploadedFileIds = await BookingApi.uploadFilesToMMS(
          token: token,
          filePaths: attachmentPaths,
          context: context,
          ticketId: ticketId, // Pass ticket ID for immediate linking
        );
        
        if (uploadedFileIds == null || uploadedFileIds.isEmpty) {
          // Files upload failed, but ticket was created
          log('Ticket created but file upload failed');
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(widget.ticketData != null
                    ? 'Ticket updated but attachments failed to upload'
                    : 'Ticket created but attachments failed to upload'),
              ),
            );
          }
        }
      }

      setState(() {
        isLoading = false;
      });

      if (result != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.ticketData != null
                ? AppLocalizations.of(context)!.ticketUpdatedSuccessfully
                : AppLocalizations.of(context)!.ticketCreatedSuccessfully),
          ),
        );
        Navigator.pop(context, true);
      } else if (mounted) {
        // Log the error for debugging
        log('Ticket creation/update failed - check backend response');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.ticketData != null
                ? AppLocalizations.of(context)!.ticketUpdateFailed
                : AppLocalizations.of(context)!.ticketCreateFailed),
          ),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        log('_submit error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${AppLocalizations.of(context)!.ticketCreateFailed}: $e'),
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    locationDescription.dispose();
    serviceDescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.ticketData != null ? localizations.editTicket : localizations.createTicket),
        elevation: 0,
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            color: AppColors(context).primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: AppColors(context).primaryColor,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(text: localizations.basicInfo),
            Tab(text: localizations.serviceDetails),
            Tab(text: localizations.ticketSummary),
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildTab1(localizations),
                  _buildTab2(localizations),
                  _buildTab3Summary(localizations),
                ],
              ),
            ),
            // Navigation buttons
            AnimatedBuilder(
              animation: _tabController,
              builder: (context, child) {
                final isLastTab = _tabController.index == 2; // Tab 3 (summary) is index 2
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, -3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      if (_tabController.index > 0)
                        Expanded(
                          child: CustomBotton(
                            title: localizations.previous,
                            onTap: _goToPreviousTab,
                          ),
                        ),
                      if (_tabController.index > 0) const SizedBox(width: 16),
                      Expanded(
                        child: CustomBotton(
                          title: isLastTab
                              ? (widget.ticketData != null
                                  ? localizations.updateTicket
                                  : localizations.createTicket)
                              : localizations.next,
                          onTap: isLastTab
                              ? _submit
                              : _goToNextTab,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab1(AppLocalizations localizations) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Contract Reference Dropdown
          _buildDropdownCard(
            title: '${localizations.contractId} *',
            selectedItem: selectedContract,
            items: contracts,
            onTap: () => _showDropdownBottomSheet(
              title: localizations.contractId,
              items: contracts,
              selectedItem: selectedContract,
              onSelected: (item) {
                setState(() {
                  selectedContract = item;
                });
              },
            ),
          ),
          const SizedBox(height: 16),

          // Branch Dropdown
          _buildDropdownCard(
            title: '${localizations.branchId} *',
            selectedItem: selectedBranch,
            items: branches,
            onTap: () => _showDropdownBottomSheet(
              title: localizations.branchId,
              items: branches,
              selectedItem: selectedBranch,
              onSelected: (item) {
                setState(() {
                  selectedBranch = item;
                });
              },
            ),
          ),
          const SizedBox(height: 16),

          // Zone Dropdown
          _buildDropdownCard(
            title: '${localizations.zoneId} *',
            selectedItem: selectedZone,
            items: zones,
            onTap: () => _showDropdownBottomSheet(
              title: localizations.zoneId,
              items: zones,
              selectedItem: selectedZone,
              onSelected: (item) {
                setState(() {
                  selectedZone = item;
                });
              },
            ),
          ),
          const SizedBox(height: 16),

          // Ticket Type Dropdown
          _buildDropdownCard(
            title: '${localizations.ticketType} *',
            selectedItem: selectedTicketType,
            items: ticketTypes,
            onTap: () => _showDropdownBottomSheet(
              title: localizations.ticketType,
              items: ticketTypes,
              selectedItem: selectedTicketType,
              onSelected: (item) {
                setState(() {
                  selectedTicketType = item;
                });
              },
            ),
          ),
          const SizedBox(height: 16),

          // Location Map Picker
          _buildLocationMapPicker(localizations),
          const SizedBox(height: 16),

          // Date Picker
          _buildDatePicker(localizations),
          const SizedBox(height: 16),

          // Time Slot Dropdown (combined time from and time to)
          _buildTimeSlotDropdown(localizations),
          const SizedBox(height: 16),

          // Team Leader Dropdown
          _buildDropdownCard(
            title: '${localizations.teamLeaderId} *',
            selectedItem: selectedTeamLeader,
            items: teamLeaders,
            onTap: () => _showDropdownBottomSheet(
              title: localizations.teamLeaderId,
              items: teamLeaders,
              selectedItem: selectedTeamLeader,
              onSelected: (item) {
                setState(() {
                  selectedTeamLeader = item;
                });
              },
            ),
          ),
          const SizedBox(height: 16),

          // Technician Dropdown
          _buildDropdownCard(
            title: '${localizations.technicianId} *',
            selectedItem: selectedTechnician,
            items: technicians,
            onTap: () => _showDropdownBottomSheet(
              title: localizations.technicianId,
              items: technicians,
              selectedItem: selectedTechnician,
              onSelected: (item) {
                setState(() {
                  selectedTechnician = item;
                });
              },
            ),
          ),
          const SizedBox(height: 16),

          // Ticket Status Dropdown (only for editing)
          if (widget.ticketData != null && ticketStatuses.isNotEmpty) ...[
            _buildDropdownCard(
              title: 'Ticket Status *',
              selectedItem: selectedTicketStatus,
              items: ticketStatuses,
              onTap: () => _showDropdownBottomSheet(
                title: 'Ticket Status',
                items: ticketStatuses,
                selectedItem: selectedTicketStatus,
                onSelected: (item) {
                  setState(() {
                    selectedTicketStatus = item;
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Description Field
          WidgetTextField(
            localizations.locationDescription,
            controller: locationDescription,
            maxLines: 4,
            fillColor: AppColors.greyColorback,
            haveBorder: false,
            radius: 5,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return localizations.required;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTab2(AppLocalizations localizations) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main Service Dropdown
          _buildDropdownCard(
            title: '${localizations.mainService} *',
            selectedItem: selectedMainService,
            items: mainServices,
            onTap: () => _showDropdownBottomSheet(
              title: localizations.mainService,
              items: mainServices,
              selectedItem: selectedMainService,
              onSelected: (item) async {
                setState(() {
                  selectedMainService = item;
                  selectedSubService = null; // Reset sub service when main service changes
                });
                // Load sub services based on selected main service
                await _loadSubServices(item.id);
              },
            ),
          ),
          const SizedBox(height: 16),

          // Sub Service Dropdown
          _buildDropdownCard(
            title: '${localizations.subService} *',
            selectedItem: selectedSubService,
            items: subServices,
            onTap: () => _showDropdownBottomSheet(
              title: localizations.subService,
              items: subServices,
              selectedItem: selectedSubService,
              onSelected: (item) {
                setState(() {
                  selectedSubService = item;
                });
              },
            ),
          ),
          const SizedBox(height: 16),

          // Attachments
          _buildAttachmentsSection(localizations),
          const SizedBox(height: 16),

          // Service Description
          WidgetTextField(
            localizations.serviceDescription,
            controller: serviceDescription,
            maxLines: 4,
            fillColor: AppColors.greyColorback,
            haveBorder: false,
            radius: 5,
          ),
        ],
      ),
    );
  }

  Widget _buildTab3Summary(AppLocalizations localizations) {
    // Get display text for time slot
    String getTimeSlotDisplay() {
      if (selectedTimeFrom != null && selectedTimeTo != null) {
        try {
          final slot = allTimeSlots.firstWhere(
            (slot) => slot['from'] == selectedTimeFrom && slot['to'] == selectedTimeTo,
          );
          return slot['display'] ?? '${selectedTimeFrom} - ${selectedTimeTo}';
        } catch (e) {
          return '${selectedTimeFrom} - ${selectedTimeTo}';
        }
      }
      return '-';
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Contract Reference
          _buildSummaryRow(
            label: localizations.contractId,
            value: selectedContract?.title ?? '-',
            icon: Icons.description,
          ),
          const SizedBox(height: 16),

          // Branch
          _buildSummaryRow(
            label: localizations.branchId,
            value: selectedBranch?.title ?? '-',
            icon: Icons.business,
          ),
          const SizedBox(height: 16),

          // Zone
          _buildSummaryRow(
            label: localizations.zoneId,
            value: selectedZone?.title ?? '-',
            icon: Icons.map,
          ),
          const SizedBox(height: 16),

          // Location Description
          _buildSummaryRow(
            label: localizations.locationDescription,
            value: locationDescription.text.isNotEmpty ? locationDescription.text : '-',
            icon: Icons.location_on,
          ),
          const SizedBox(height: 16),

          // Date
          _buildSummaryRow(
            label: localizations.date,
            value: selectedTicketDate != null
                ? DateFormat('yyyy-MM-dd').format(selectedTicketDate!)
                : '-',
            icon: Icons.calendar_today,
          ),
          const SizedBox(height: 16),

          // Time Slot
          _buildSummaryRow(
            label: '${localizations.timeFrom} - ${localizations.timeTo}',
            value: getTimeSlotDisplay(),
            icon: Icons.access_time,
          ),
          const SizedBox(height: 16),

          // Team Leader
          _buildSummaryRow(
            label: localizations.teamLeaderId,
            value: selectedTeamLeader?.title ?? '-',
            icon: Icons.person_outline,
          ),
          const SizedBox(height: 16),

          // Technician
          _buildSummaryRow(
            label: localizations.technicianId,
            value: selectedTechnician?.title ?? '-',
            icon: Icons.engineering,
          ),
          const SizedBox(height: 16),

          // Ticket Type
          _buildSummaryRow(
            label: localizations.ticketType,
            value: selectedTicketType?.title ?? '-',
            icon: Icons.category,
          ),
          const SizedBox(height: 16),

          // Ticket Status (only for editing)
          if (widget.ticketData != null && selectedTicketStatus != null) ...[
            _buildSummaryRow(
              label: localizations.ticketStatus,
              value: selectedTicketStatus?.title ?? '-',
              icon: Icons.info_outline,
            ),
            const SizedBox(height: 16),
          ],

          // Main Service
          _buildSummaryRow(
            label: localizations.mainService,
            value: selectedMainService?.title ?? '-',
            icon: Icons.build,
          ),
          const SizedBox(height: 16),

          // Sub Service
          if (selectedSubService != null) ...[
            _buildSummaryRow(
              label: localizations.subService,
              value: selectedSubService?.title ?? '-',
              icon: Icons.settings,
            ),
            const SizedBox(height: 16),
          ],

          // Service Description
          if (serviceDescription.text.isNotEmpty) ...[
            _buildSummaryRow(
              label: localizations.serviceDescription,
              value: serviceDescription.text,
              icon: Icons.description,
            ),
            const SizedBox(height: 16),
          ],

          // Location Map (coordinates)
          if (selectedLocation != null) ...[
            _buildSummaryRow(
              label: localizations.locationMap,
              value: '${selectedLocation!.latitude.toStringAsFixed(6)}, ${selectedLocation!.longitude.toStringAsFixed(6)}',
              icon: Icons.map,
            ),
            const SizedBox(height: 16),
          ],

          // Attachments count
          if (uploadedFiles.isNotEmpty)
            _buildSummaryRow(
              label: localizations.attachment,
              value: '${uploadedFiles.length} file(s)',
              icon: Icons.attach_file,
            ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.greyColorback,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: AppColors(context).primaryColor,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationMapPicker(AppLocalizations localizations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${localizations.locationMap} *',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () {
            _showLocationMapBottomSheet(localizations);
          },
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              color: AppColors.greyColorback,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: selectedLocation != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: WidgewtGoogleMaps(
                      lat: selectedLocation!.latitude,
                      loang: selectedLocation!.longitude,
                      isFromCheckOut: true,
                      height: 200,
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.map,
                          size: 48,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          localizations.selectDate,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  void _showLocationMapBottomSheet(AppLocalizations localizations) {
    LatLng? tempLocation = selectedLocation;
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      localizations.locationMap,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const Divider(),
              // Map
              Expanded(
                child: StatefulBuilder(
                  builder: (context, setModalState) {
                    return Stack(
                      children: [
                        WidgewtGoogleMaps(
                          lat: tempLocation?.latitude,
                          loang: tempLocation?.longitude,
                          isFromCheckOut: false,
                        ),
                        // Confirm button at bottom
                        Positioned(
                          bottom: 16,
                          left: 16,
                          right: 16,
                          child: CustomBotton(
                            title: 'Confirm Location',
                            onTap: () {
                              // Get location from AppProvider
                              final appProvider = Provider.of<AppProvider>(context, listen: false);
                              if (appProvider.position != null) {
                                final location = LatLng(
                                  appProvider.position!.latitude,
                                  appProvider.position!.longitude,
                                );
                                Navigator.pop(context);
                                setState(() {
                                  selectedLocation = location;
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Please select a location on the map')),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDatePicker(AppLocalizations localizations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${localizations.date} *',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: selectedTicketDate ?? DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );

            if (date != null && mounted) {
              setState(() {
                selectedTicketDate = date;
                // Reset time selection and get available slots for new date
                final now = DateTime.now();
                final currentTimeInMinutes = now.hour * 60 + now.minute;
                final sixteenHundredInMinutes = 16 * 60; // 16:00 = 960 minutes
                
                // Check if selected date is today
                final isToday = date.year == now.year &&
                    date.month == now.month &&
                    date.day == now.day;
                
                final availableSlots = getAvailableTimeSlots();
                if (availableSlots.isNotEmpty) {
                  selectedTimeFrom = availableSlots.first['from'];
                  selectedTimeTo = availableSlots.first['to'];
                } else if (isToday && currentTimeInMinutes >= sixteenHundredInMinutes) {
                  // If current time exceeds 16:00 and no slots are available, default to the latest slot (16:00-18:00)
                  final lastSlot = allTimeSlots.last;
                  selectedTimeFrom = lastSlot['from'];
                  selectedTimeTo = lastSlot['to'];
                } else {
                  selectedTimeFrom = null;
                  selectedTimeTo = null;
                }
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.greyColorback,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: AppColors(context).primaryColor,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    selectedTicketDate != null
                        ? DateFormat('yyyy-MM-dd').format(selectedTicketDate!)
                        : localizations.selectDate,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: selectedTicketDate != null ? Colors.black87 : Colors.grey,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey[600],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSlotDropdown(AppLocalizations localizations) {
    // Get display text for selected time slot
    String getDisplayText() {
      if (selectedTimeFrom != null && selectedTimeTo != null) {
        try {
          final slot = allTimeSlots.firstWhere(
            (slot) => slot['from'] == selectedTimeFrom && slot['to'] == selectedTimeTo,
          );
          return slot['display'] ?? '${selectedTimeFrom} - ${selectedTimeTo}';
        } catch (e) {
          return '${selectedTimeFrom} - ${selectedTimeTo}';
        }
      }
      return localizations.selectTime;
    }

    final availableSlots = getAvailableTimeSlots();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${localizations.timeFrom} - ${localizations.timeTo} *',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () {
            if (availableSlots.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No available time slots for selected date')),
              );
              return;
            }

            // Convert available time slots to DropdownCardItem list
            final items = availableSlots.map((slot) {
              final displayText = slot['display']!;
              final from = slot['from']!;
              final to = slot['to']!;
              
              return DropdownCardItem(
                id: availableSlots.indexOf(slot),
                title: displayText,
                icon: Icons.access_time,
                data: {'from': from, 'to': to},
              );
            }).toList();

            DropdownCardItem? currentSelected;
            if (selectedTimeFrom != null && selectedTimeTo != null) {
              try {
                currentSelected = items.firstWhere(
                  (item) => item.data!['from'] == selectedTimeFrom && item.data!['to'] == selectedTimeTo,
                );
              } catch (e) {
                currentSelected = items.isNotEmpty ? items.first : null;
              }
            }

            DraggableCardBottomSheet.show(
              context: context,
              title: '${localizations.timeFrom} - ${localizations.timeTo}',
              items: items,
              selectedItem: currentSelected,
              onItemSelected: (item) {
                final from = item.data!['from'] as String;
                final to = item.data!['to'] as String;
                setState(() {
                  selectedTimeFrom = from;
                  selectedTimeTo = to;
                });
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.greyColorback,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.access_time,
                  color: AppColors(context).primaryColor,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    getDisplayText(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: selectedTimeFrom != null && selectedTimeTo != null
                          ? Colors.black87
                          : Colors.grey,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey[600],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownCard({
    required String title,
    required DropdownCardItem? selectedItem,
    required List<DropdownCardItem> items,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.greyColorback,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            if (selectedItem?.icon != null) ...[
              Icon(
                selectedItem!.icon,
                color: AppColors(context).primaryColor,
                size: 24,
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    selectedItem?.title ?? 'Select',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: selectedItem != null ? Colors.black87 : Colors.grey,
                    ),
                  ),
                  if (selectedItem?.subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      selectedItem!.subtitle!,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.grey[600],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttachmentsSection(AppLocalizations localizations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${localizations.attachment} (${localizations.optional})',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UploadOptionsScreen(
                  data: {
                    'uploadedFiles': uploadedFiles,
                    'fromTicketCreation': true, // Flag to indicate this is from ticket creation
                  },
                ),
              ),
            ).then((result) {
              // Handle returned uploaded files from attachment screen
              if (result != null && result is Map<String, dynamic>) {
                final returnedFiles = result['uploadedFiles'] as List<Map<String, String?>>?;
                if (returnedFiles != null) {
                  setState(() {
                    uploadedFiles = returnedFiles;
                  });
                }
                // Ensure we stay on Tab 2 (Service Details) after returning
                if (_tabController.index != 1) {
                  _tabController.animateTo(1);
                }
              }
            });
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.greyColorback,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.attach_file,
                  color: AppColors(context).primaryColor,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    uploadedFiles.isEmpty
                        ? localizations.addAttachment
                        : '${uploadedFiles.length} file(s) attached',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey[600],
                ),
              ],
            ),
          ),
        ),
        // Display uploaded files count
        if (uploadedFiles.isNotEmpty) ...[
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: uploadedFiles.asMap().entries.map((entry) {
              final index = entry.key;
              final file = entry.value;
              return Chip(
                label: Text(
                  file['filename'] ?? 
                  file['image']?.split('/').last ?? 
                  file['audio']?.split('/').last ?? 
                  'File ${index + 1}',
                ),
                onDeleted: () {
                  setState(() {
                    uploadedFiles.removeAt(index);
                  });
                },
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}
