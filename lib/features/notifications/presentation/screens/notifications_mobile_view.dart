import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/widgets/common/app_header_bar.dart';
import '../../../../core/widgets/common/custom_filter_bar.dart';
import '../../../../core/widgets/utility/custom_refresh_wrapper.dart';
import '../../../../core/widgets/utility/custom_shimmer.dart';
import '../../../../core/widgets/utility/empty_state.dart';
import '../../../../core/widgets/utility/error_state.dart';
import '../../data/models/notification_model.dart';
import '../controllers/notification_controller.dart';
import '../widgets/notification_tile.dart';
import 'package:salesysx/core/locale/app_localizations_x.dart';

class NotificationsMobileView extends ConsumerWidget {
  const NotificationsMobileView({super.key});

  NotificationCategory _categoryOf(NotificationType type) => switch (type) {
    NotificationType.targetRisk || NotificationType.lowSales => NotificationCategory.alert,
    NotificationType.milestone => NotificationCategory.order,
    NotificationType.target || NotificationType.dailyReminder || NotificationType.info =>
    NotificationCategory.system,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationControllerProvider);
    final controller = ref.read(notificationControllerProvider.notifier);
    final isFirstLoad = state.isNotificationsLoading && state.items.isEmpty;

    return Column(
      children: [
        AppHeaderBar(
          title: context.l10n.notificationsTitle,
          trailingLabel: context.l10n.markAllAsRead,
          backStyle: HeaderBackStyle.chevron,
          onTrailingTap: controller.markAllAsRead,
        ),
        Expanded(
          child: isFirstLoad
              ? _buildShimmer()
              : state.errorMessage != null
                  ? ErrorState(message: state.errorMessage!, onRetry: controller.refresh)
                  : CustomRefreshWrapper(
                      onRefresh: controller.refresh,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(AppSizes.md),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomFilterBar<String>(
                              filters: const ['all', 'unread'],
                              selectedFilters: {state.selectedFilter},
                              labelBuilder: (filter) => filter == 'all'
                                  ? '${context.l10n.filterAll} (${state.items.length})'
                                  : '${context.l10n.filterUnread} (${state.unreadCount})',
                              onSelected: controller.selectFilter,
                            ),
                            const SizedBox(height: AppSizes.md),
                            if (state.filteredItems.isEmpty)
                              const EmptyState(title: 'No notifications')
                            else
                              Column(
                                children: [
                                  for (final item in state.filteredItems) ...[
                                    NotificationTile(
                                      category: _categoryOf(item.type),
                                      title: item.title,
                                      description: item.message,
                                      time: DateFormatter.relative(item.createdAt),
                                      isUnread: !item.isRead,
                                      onTap: () => controller.markRead(item.id),
                                    ),
                                    if (item != state.filteredItems.last) const SizedBox(height: AppSizes.md),
                                  ],
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
        ),
      ],
    );
  }

  Widget _buildShimmer() {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.md),
      child: Column(
        children: [
          for (var i = 0; i < 4; i++) ...[
            CustomShimmer(height: 80, borderRadius: BorderRadius.circular(AppSizes.radiusMd)),
            const SizedBox(height: AppSizes.md),
          ],
        ],
      ),
    );
  }
}