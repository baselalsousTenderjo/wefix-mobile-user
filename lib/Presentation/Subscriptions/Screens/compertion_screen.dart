import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wefix/Business/LanguageProvider/l10n_provider.dart';
import 'package:wefix/Data/Constant/theme/color_constant.dart';
import 'package:wefix/Data/appText/appText.dart';
import 'package:wefix/Data/model/packages_model.dart';
import 'package:wefix/Presentation/Components/language_icon.dart';

class ComparisonScreen extends StatelessWidget {
  final List<PackagePackage> plans;

  const ComparisonScreen({super.key, required this.plans});

  @override
  Widget build(BuildContext context) {
    LanguageProvider languageProvider =
        Provider.of<LanguageProvider>(context, listen: true);

    final comparisonFields = [
      {
        'key': 'numberOfUrgentVisits',
        'label':
            languageProvider.lang == 'ar' ? 'الزيارات الطارئة' : 'Urgent Visits'
      },
      {
        'key': 'numberOfRegularVisit',
        'label': languageProvider.lang == 'ar'
            ? 'الزيارات العادية'
            : 'Regular Visits'
      },
      {
        'key': 'numberOnDemandVisit',
        'label': languageProvider.lang == 'ar'
            ? 'زيارات عند الطلب'
            : 'On-Demand Visits'
      },
      {
        'key': 'numberOfFemalUse',
        'label': languageProvider.lang == 'ar'
            ? 'الخدمة النسائية'
            : 'Female Services'
      },
      {
        'key': 'consultation',
        'label': languageProvider.lang == 'ar' ? 'الاستشارات' : 'Consultation'
      },
      {
        'key': 'interiorDesign',
        'label':
            languageProvider.lang == 'ar' ? 'الاستشارات' : 'Interior Design'
      },
      {
        'key': 'discount',
        'label': languageProvider.lang == 'ar' ? 'الخصم' : 'Discount (%)'
      },
      {
        'key': 'totalvisit',
        'label':
            languageProvider.lang == 'ar' ? 'إجمالي الزيارات' : 'Total Visits'
      },
    ];

    final primaryColor = AppColors(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        actions: [const LanguageButton()],
        title: Text("${AppText(context).comparePlans}"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF5F7FA),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: plans
                    .map((plan) => Expanded(
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  plan.title ?? "",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "${plan.price.toString()} ${AppText(context).jODMonth}",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      AppText(context).feature,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      plans[0].title ?? "",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      plans[1].title ?? "",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 1),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.separated(
                  itemCount: comparisonFields.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (_, index) {
                    final item = comparisonFields[index];
                    final label = item['label']!;
                    final key = item['key']!;
                    final val1 = getNumericValue(plans[0], key);
                    final val2 = getNumericValue(plans[1], key);

                    return Row(
                      children: [
                        Expanded(
                          child: Text(
                            label,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              val1.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: val1 > val2
                                    ? Colors.green
                                    : (val1 < val2
                                        ? Colors.red
                                        : Colors.grey[800]),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              val2.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: val2 > val1
                                    ? Colors.green
                                    : (val2 < val1
                                        ? Colors.red
                                        : Colors.grey[800]),
                              ),
                            ),
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

  int getNumericValue(PackagePackage plan, String key) {
    try {
      final value = plan.toJson()[key];
      return value is int ? value : int.tryParse(value.toString()) ?? 0;
    } catch (e) {
      return 0;
    }
  }

  String getRawStringValue(PackagePackage plan, String key) {
    try {
      final value = plan.toJson()[key];
      return value?.toString() ?? '';
    } catch (_) {
      return '';
    }
  }

  int extractNumber(String text) {
    final match = RegExp(r'\d+').firstMatch(text);
    return match != null ? int.parse(match.group(0)!) : 0;
  }
}
