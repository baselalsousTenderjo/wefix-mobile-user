import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wefix/Business/AppProvider/app_provider.dart';
import 'package:wefix/Business/Bookings/bookings_apis.dart';
import 'package:wefix/Data/Constant/theme/color_constant.dart';
import 'package:wefix/Presentation/Components/custom_botton_widget.dart';
import 'package:wefix/Presentation/Components/widget_form_text.dart';
import 'package:wefix/l10n/app_localizations.dart';

class CreateUpdateTicketScreen extends StatefulWidget {
  final Map<String, dynamic>? ticketData; // If provided, it's edit mode

  const CreateUpdateTicketScreen({super.key, this.ticketData});

  @override
  State<CreateUpdateTicketScreen> createState() => _CreateUpdateTicketScreenState();
}

class _CreateUpdateTicketScreenState extends State<CreateUpdateTicketScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  // Controllers
  final TextEditingController locationDescription = TextEditingController();
  final TextEditingController locationMap = TextEditingController();
  final TextEditingController ticketDescription = TextEditingController();
  final TextEditingController serviceDescription = TextEditingController();
  final TextEditingController customerName = TextEditingController();

  // Selected values (these would come from API calls in a full implementation)
  int? selectedContractId;
  int? selectedBranchId;
  int? selectedZoneId;
  int? selectedTicketTypeId;
  int? selectedMainServiceId;
  int? selectedTeamLeaderId;
  int? selectedTechnicianId;
  DateTime? selectedDate;
  String? selectedTimeFrom;
  String? selectedTimeTo;
  bool havingFemaleEngineer = false;
  bool withMaterial = false;

  @override
  void initState() {
    super.initState();
    // If editing, populate fields
    if (widget.ticketData != null) {
      _populateFieldsFromTicketData(widget.ticketData!);
    } else {
      selectedDate = DateTime.now();
    }
  }

  void _populateFieldsFromTicketData(Map<String, dynamic> data) {
    locationDescription.text = data['locationDescription'] ?? '';
    locationMap.text = data['locationMap'] ?? '';
    ticketDescription.text = data['ticketDescription'] ?? '';
    serviceDescription.text = data['serviceDescription'] ?? '';
    customerName.text = data['customerName'] ?? '';
    selectedContractId = data['contractId'];
    selectedBranchId = data['branchId'];
    selectedZoneId = data['zoneId'];
    selectedTicketTypeId = data['ticketType']?['id'];
    selectedMainServiceId = data['mainService']?['id'];
    selectedTeamLeaderId = data['assignToTeamLeaderId'];
    selectedTechnicianId = data['technician']?['id'];
    havingFemaleEngineer = data['havingFemaleEngineer'] ?? false;
    withMaterial = data['withMaterial'] ?? false;
    if (data['ticketDate'] != null) {
      selectedDate = DateTime.parse(data['ticketDate']);
    }
    selectedTimeFrom = data['ticketTimeFrom'];
    selectedTimeTo = data['ticketTimeTo'];
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTimeFrom() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTimeFrom != null
          ? TimeOfDay(
              hour: int.parse(selectedTimeFrom!.split(':')[0]),
              minute: int.parse(selectedTimeFrom!.split(':')[1]),
            )
          : TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTimeFrom = '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}:00';
      });
    }
  }

  Future<void> _selectTimeTo() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTimeTo != null
          ? TimeOfDay(
              hour: int.parse(selectedTimeTo!.split(':')[0]),
              minute: int.parse(selectedTimeTo!.split(':')[1]),
            )
          : TimeOfDay.now().replacing(minute: TimeOfDay.now().minute + 120),
    );
    if (picked != null) {
      setState(() {
        selectedTimeTo = '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}:00';
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Validate required fields
    if (selectedContractId == null ||
        selectedBranchId == null ||
        selectedZoneId == null ||
        selectedTicketTypeId == null ||
        selectedMainServiceId == null ||
        selectedTeamLeaderId == null ||
        selectedTechnicianId == null ||
        selectedDate == null ||
        selectedTimeFrom == null ||
        selectedTimeTo == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final appProvider = Provider.of<AppProvider>(context, listen: false);
      final token = appProvider.accessToken ?? appProvider.userModel?.token ?? '';

      final ticketData = {
        'contractId': selectedContractId,
        'branchId': selectedBranchId,
        'zoneId': selectedZoneId,
        'locationMap': locationMap.text.isNotEmpty ? locationMap.text : '',
        'locationDescription': locationDescription.text,
        'ticketTypeId': selectedTicketTypeId,
        'ticketDate': DateFormat('yyyy-MM-dd').format(selectedDate!),
        'ticketTimeFrom': selectedTimeFrom,
        'ticketTimeTo': selectedTimeTo,
        'assignToTeamLeaderId': selectedTeamLeaderId,
        'assignToTechnicianId': selectedTechnicianId,
        'ticketDescription': ticketDescription.text.isNotEmpty ? ticketDescription.text : null,
        'havingFemaleEngineer': havingFemaleEngineer,
        'customerName': customerName.text.isNotEmpty ? customerName.text : null,
        'withMaterial': withMaterial,
        'mainServiceId': selectedMainServiceId,
        'serviceDescription': serviceDescription.text.isNotEmpty ? serviceDescription.text : null,
      };

      Map<String, dynamic>? result;
      if (widget.ticketData != null) {
        // Update existing ticket
        result = await BookingApi.updateTicketInMMS(
          token: token,
          ticketId: widget.ticketData!['id'],
          ticketData: ticketData,
          context: context,
        );
      } else {
        // Create new ticket
        result = await BookingApi.createTicketInMMS(
          token: token,
          ticketData: ticketData,
        );
      }

      setState(() {
        isLoading = false;
      });

      if (result != null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(widget.ticketData != null
                  ? AppLocalizations.of(context)!.ticketUpdatedSuccessfully
                  : AppLocalizations.of(context)!.ticketCreatedSuccessfully),
            ),
          );
          Navigator.pop(context, true); // Return true to indicate success
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(widget.ticketData != null
                  ? AppLocalizations.of(context)!.ticketUpdateFailed
                  : AppLocalizations.of(context)!.ticketCreateFailed),
            ),
          );
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    locationDescription.dispose();
    locationMap.dispose();
    ticketDescription.dispose();
    serviceDescription.dispose();
    customerName.dispose();
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Location Description (Required)
              WidgetTextField(
                localizations.locationDescription,
                controller: locationDescription,
                maxLines: 3,
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
              const SizedBox(height: 15),

              // Location Map (Optional)
              WidgetTextField(
                localizations.locationMap,
                controller: locationMap,
                fillColor: AppColors.greyColorback,
                haveBorder: false,
                radius: 5,
              ),
              const SizedBox(height: 15),

              // Ticket Type Dropdown (Required) - Placeholder
              DropdownButtonFormField<int>(
                value: selectedTicketTypeId,
                decoration: InputDecoration(
                  labelText: '${localizations.ticketType} *',
                  filled: true,
                  fillColor: AppColors.greyColorback,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: [
                  // TODO: Load from API
                  DropdownMenuItem(value: 1, child: Text(localizations.correctiveTickets)),
                  DropdownMenuItem(value: 2, child: Text(localizations.preventivevisits)),
                  DropdownMenuItem(value: 3, child: Text(localizations.emergencyTickets)),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedTicketTypeId = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return localizations.required;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // Main Service Dropdown (Required) - Placeholder
              DropdownButtonFormField<int>(
                value: selectedMainServiceId,
                decoration: InputDecoration(
                  labelText: '${localizations.mainService} *',
                  filled: true,
                  fillColor: AppColors.greyColorback,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: [
                  // TODO: Load from API
                  DropdownMenuItem(value: 1, child: const Text('Service 1')),
                  DropdownMenuItem(value: 2, child: const Text('Service 2')),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedMainServiceId = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return localizations.required;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // Date Selection
              InkWell(
                onTap: _selectDate,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: '${localizations.date} *',
                    filled: true,
                    fillColor: AppColors.greyColorback,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                  child: Text(
                    selectedDate != null
                        ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                        : localizations.selectDate,
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Time From
              InkWell(
                onTap: _selectTimeFrom,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: '${localizations.timeFrom} *',
                    filled: true,
                    fillColor: AppColors.greyColorback,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: const Icon(Icons.access_time),
                  ),
                  child: Text(
                    selectedTimeFrom ?? localizations.selectTime,
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Time To
              InkWell(
                onTap: _selectTimeTo,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: '${localizations.timeTo} *',
                    filled: true,
                    fillColor: AppColors.greyColorback,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: const Icon(Icons.access_time),
                  ),
                  child: Text(
                    selectedTimeTo ?? localizations.selectTime,
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Contract ID (Required) - Placeholder
              WidgetTextField(
                '${localizations.contractId} *',
                controller: TextEditingController(
                  text: selectedContractId?.toString() ?? '',
                ),
                keyboardType: TextInputType.number,
                fillColor: AppColors.greyColorback,
                haveBorder: false,
                radius: 5,
                onChanged: (value) {
                  selectedContractId = int.tryParse(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty || int.tryParse(value) == null) {
                    return localizations.required;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // Branch ID (Required) - Placeholder
              WidgetTextField(
                '${localizations.branchId} *',
                controller: TextEditingController(
                  text: selectedBranchId?.toString() ?? '',
                ),
                keyboardType: TextInputType.number,
                fillColor: AppColors.greyColorback,
                haveBorder: false,
                radius: 5,
                onChanged: (value) {
                  selectedBranchId = int.tryParse(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty || int.tryParse(value) == null) {
                    return localizations.required;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // Zone ID (Required) - Placeholder
              WidgetTextField(
                '${localizations.zoneId} *',
                controller: TextEditingController(
                  text: selectedZoneId?.toString() ?? '',
                ),
                keyboardType: TextInputType.number,
                fillColor: AppColors.greyColorback,
                haveBorder: false,
                radius: 5,
                onChanged: (value) {
                  selectedZoneId = int.tryParse(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty || int.tryParse(value) == null) {
                    return localizations.required;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // Team Leader ID (Required) - Placeholder
              WidgetTextField(
                '${localizations.teamLeaderId} *',
                controller: TextEditingController(
                  text: selectedTeamLeaderId?.toString() ?? '',
                ),
                keyboardType: TextInputType.number,
                fillColor: AppColors.greyColorback,
                haveBorder: false,
                radius: 5,
                onChanged: (value) {
                  selectedTeamLeaderId = int.tryParse(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty || int.tryParse(value) == null) {
                    return localizations.required;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // Technician ID (Required) - Placeholder
              WidgetTextField(
                '${localizations.technicianId} *',
                controller: TextEditingController(
                  text: selectedTechnicianId?.toString() ?? '',
                ),
                keyboardType: TextInputType.number,
                fillColor: AppColors.greyColorback,
                haveBorder: false,
                radius: 5,
                onChanged: (value) {
                  selectedTechnicianId = int.tryParse(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty || int.tryParse(value) == null) {
                    return localizations.required;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // Ticket Description (Optional)
              WidgetTextField(
                localizations.description,
                controller: ticketDescription,
                maxLines: 4,
                fillColor: AppColors.greyColorback,
                haveBorder: false,
                radius: 5,
              ),
              const SizedBox(height: 15),

              // Service Description (Optional)
              WidgetTextField(
                localizations.serviceDescription,
                controller: serviceDescription,
                maxLines: 4,
                fillColor: AppColors.greyColorback,
                haveBorder: false,
                radius: 5,
              ),
              const SizedBox(height: 15),

              // Customer Name (Optional)
              WidgetTextField(
                localizations.customerName,
                controller: customerName,
                fillColor: AppColors.greyColorback,
                haveBorder: false,
                radius: 5,
              ),
              const SizedBox(height: 15),

              // Having Female Engineer Checkbox
              CheckboxListTile(
                title: Text(localizations.havingFemaleEngineer),
                value: havingFemaleEngineer,
                onChanged: (value) {
                  setState(() {
                    havingFemaleEngineer = value ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),

              // With Material Checkbox
              CheckboxListTile(
                title: Text(localizations.withMaterial),
                value: withMaterial,
                onChanged: (value) {
                  setState(() {
                    withMaterial = value ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),

              const SizedBox(height: 30),

              // Submit Button
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors(context).primaryColor,
                      ),
                    )
                  : CustomBotton(
                      title: widget.ticketData != null
                          ? localizations.updateTicket
                          : localizations.createTicket,
                      onTap: _submit,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}





