import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/app_color_scheme.dart';
import '../../../../core/widgets/common/custom_card.dart';

/// Small stat tile — label, bold value, and a one-line note beneath.
/// Used in a pair for "Today's Target" / "Today's Sales".
class TeamMemberDailyStatCard extends StatelessWidget {
  final String label;
  final String value;
  final String note;
  final Color valueColor;
  final Color noteColor;

  const TeamMemberDailyStatCard({
    super.key,
    required this.label,
    required this.value,
    required this.note,
    required this.valueColor,
    required this.noteColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: const EdgeInsets.all(AppSizes.md - AppSizes.xs / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: AppSizes.fontXs, color: context.appColors.textHint)),
          const SizedBox(height: AppSizes.xs),
          Text(value, style: TextStyle(fontSize: AppSizes.fontXl, fontWeight: FontWeight.w800, color: valueColor)),
          const SizedBox(height: AppSizes.xs / 2),
          Text(note, style: TextStyle(fontSize: AppSizes.fontXs, color: noteColor)),
        ],
      ),
    );
  }
}