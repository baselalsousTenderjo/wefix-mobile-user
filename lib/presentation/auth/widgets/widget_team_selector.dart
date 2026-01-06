import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/app_text.dart';
import '../../../core/providers/language_provider/l10n_provider.dart';
import '../../../core/unit/app_color.dart';
import '../../../core/unit/app_text_style.dart';
import '../controller/auth_provider.dart';

class WidgetTeamSelector extends StatelessWidget {
  const WidgetTeamSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            // Get translations with fallback
            final b2bLabel = AppText(context).b2bTeam.isEmpty 
                ? 'B2B Team' 
                : AppText(context).b2bTeam;
            final weFixLabel = AppText(context).weFixTeam.isEmpty 
                ? 'WeFix Team' 
                : AppText(context).weFixTeam;
        
            return ValueListenableBuilder<String>(
              valueListenable: authProvider.selectedTeam,
              builder: (context, selectedTeam, child) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColor.grey.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildTeamTab(
                          context: context,
                          team: 'B2B Team',
                          label: b2bLabel,
                          isSelected: selectedTeam == 'B2B Team',
                          onTap: () => authProvider.switchTeam('B2B Team'),
                        ),
                      ),
                      Expanded(
                        child: _buildTeamTab(
                          context: context,
                          team: 'WeFix Team',
                          label: weFixLabel,
                          isSelected: selectedTeam == 'WeFix Team',
                          onTap: () => authProvider.switchTeam('WeFix Team'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildTeamTab({
    required BuildContext context,
    required String team,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: AppTextStyle.style14B.copyWith(
            color: isSelected ? AppColor.white : AppColor.grey,
          ),
        ),
      ),
    );
  }
}

