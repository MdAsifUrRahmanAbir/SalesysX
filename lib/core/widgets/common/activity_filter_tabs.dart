import 'package:flutter/material.dart';
import '../../../../core/widgets/utility/custom_filter_bar.dart';
import 'package:salesysx/core/locale/app_localizations_x.dart';

/// Today / This Week / This Month filter for the activity feed.
class ActivityFilterTabs extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;

  const ActivityFilterTabs({super.key, required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return CustomFilterBar<String>(
      filters: const ['today', 'week', 'month'],
      selectedFilters: {selected},
      labelBuilder: (f) => switch (f) {
        'today' => context.l10n.filterToday,
        'week' => context.l10n.filterThisWeek,
        _ => context.l10n.filterThisMonth,
      },
      onSelected: onChanged,
    );
  }
}