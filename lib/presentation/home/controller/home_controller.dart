import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../../core/context/global.dart';
import '../../../core/extension/gap.dart';
import '../../../core/providers/app_text.dart';
import '../../../core/unit/app_color.dart';
import '../../../core/widget/widget_daialog.dart';
import '../domain/home_enum.dart';
import '../domain/model/home_model.dart';
import '../domain/usecase/home_usecase.dart';

class HomeController extends ChangeNotifier with WidgetsBindingObserver {
  final HomeUsecase homeUsecase;

  ValueNotifier<HomeStatus> homeStatue = ValueNotifier(HomeStatus.init);
  List<Map<String, dynamic>> filterTypes = [];
  String? totalTickets = '0';
  HomeModel? currentHomeData;

  HomeController({required this.homeUsecase});

  // Function to check User Role Access
  // Token management handles authentication, so we just proceed to get home data
  // If there are auth issues, the API will return 401 and token management will handle it
  Future<void> checkAccess() async {
    // Skip access validation - let token management handle authentication
    // Just proceed to get home data
    getHomeData();
  }
  

  // Function to get the home data
  // Token management handles authentication, so we just fetch data
  // If there are auth issues, the API will return 401 and token management will handle it
  Future<void> getHomeData() async {
    try {
      homeStatue.value = HomeStatus.loading;
      final result = await homeUsecase.getHomeData();
      result.fold(
        (l) {
          homeStatue.value = HomeStatus.failuer;
          // Don't show dialog - let token management handle 401 errors
          // For other errors, just log them silently
          final errorMsg = l.message.toLowerCase();
          if (errorMsg.contains('401') || errorMsg.contains('unauthorized')) {
            // Token management will handle this - don't show dialog
            log('Authentication error in getHomeData: ${l.message}');
          } else {
            // Log other errors but don't show dialog
            log('Error in getHomeData: ${l.message}');
          }
          notifyListeners();
        },
        (r) {
          if (r.data != null) {
            currentHomeData = r.data!;
            setFilter(r.data!);
            homeStatue.value = HomeStatus.success;
          } else {
            // Handle empty data case
            homeStatue.value = HomeStatus.success;
            currentHomeData = HomeModel(
              tickets: [],
              ticketsTomorrow: [],
              emergency: [],
              technician: null,
            );
            setFilter(currentHomeData!);
          }
          notifyListeners();
        },
      );
    } catch (e) {
      homeStatue.value = HomeStatus.failuer;
      log('Server Error in section Get Home Data : $e');
      notifyListeners();
    }
  }

  void setFilter(HomeModel home) {
    filterTypes = [
      {'title': AppText(GlobalContext.context, isFunction: true).today, 'isSelected': true, 'count': '', 'data': []},
      {'title': AppText(GlobalContext.context, isFunction: true).tomorrow, 'isSelected': false, 'count': '', 'data': []},
      {'title': '${AppText(GlobalContext.context, isFunction: true).emergency} 🚨', 'isSelected': false, 'count': '', 'data': []},
    ];
    filterTypes[0]['data'] = home.tickets ?? [];
    filterTypes[0]['count'] = (home.tickets?.length ?? 0).toString();
    filterTypes[1]['data'] = home.ticketsTomorrow ?? [];
    filterTypes[1]['count'] = (home.ticketsTomorrow?.length ?? 0).toString();
    filterTypes[2]['data'] = home.emergency ?? [];
    filterTypes[2]['count'] = (home.emergency?.length ?? 0).toString();
    totalTickets =
        '${(home.tickets?.where((value) => value.status?.toLowerCase() == 'pending').toList().length ?? 0) + (home.ticketsTomorrow?.where((value) => value.status?.toLowerCase() == 'pending').toList().length ?? 0) + (home.emergency?.where((value) => value.status?.toLowerCase() == 'pending').toList().length ?? 0)}';
    // Rating/reviews removed - no longer needed
    notifyListeners();
  }

  // Function to change the selected filter type
  void changeType(int index, BuildContext context) {
    for (var element in filterTypes) {
      element['isSelected'] = false;
    }
    filterTypes[index]['isSelected'] = true;

    notifyListeners();
  }

  void showStatusColorDialog(BuildContext context) {
    SmartDialog.show(
      builder:
          (context) => WidgetDilog(
            isSupport: true,
            title: AppText(context).statusColorsMeaning,
            message: '',
            contents: [
              _buildStatusRow(AppText(context).pending, AppColor.primaryColor600, AppText(context).awaitinginitiationrequest),
              _buildStatusRow(AppText(context).inProgress, AppColor.blue, AppText(context).requestiscurrentlyunderway),
              _buildStatusRow(AppText(context).canceled, AppColor.red, AppText(context).thisrequestwascanceled),
              _buildStatusRow(AppText(context).completed, AppColor.green, AppText(context).thisrequestwascompletedsuccessfully),
            ],
            cancelText: AppText(context).back,
            onCancel: () {
              SmartDialog.dismiss();
            },
          ),
    );
  }

  Widget _buildStatusRow(String label, Color color, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          10.gap,
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black),
                children: [TextSpan(text: '$label: ', style: const TextStyle(fontWeight: FontWeight.bold)), TextSpan(text: description)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
