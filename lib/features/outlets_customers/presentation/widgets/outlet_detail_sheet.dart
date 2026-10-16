import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:salesysx/features/common_models/sale_model.dart';
import 'package:salesysx/routes/route_names.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/app_color_scheme.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/common/custom_list_tile.dart';
import '../../../../core/widgets/common/primary_button.dart';
import '../../../../core/widgets/common/status_badge.dart';
import '../../../../core/widgets/utility/custom_shimmer.dart';
import '../../data/repositories/outlets_customers_repository.dart';
import '../states/outlets_customers_state.dart';
import 'package:salesysx/core/locale/app_localizations_x.dart';

/// Outlet detail sheet: contact info, recent sales to this outlet, and a
/// "Record Sale" shortcut that preselects the outlet. Opened via
/// `CustomBottomSheet.show` from the outlet list — no dedicated route,
/// since this is a detail augmentation of the list, not a new nav
/// destination.
class OutletDetailSheet extends ConsumerWidget {
  const OutletDetailSheet({super.key, required this.outlet});

  final OutletCustomer outlet;

  StatusBadgeType get _badgeType => switch (outlet.status) {
    OutletCustomerStatus.active => StatusBadgeType.success,
    OutletCustomerStatus.newCustomer => StatusBadgeType.info,
    OutletCustomerStatus.potential => StatusBadgeType.warning,
  };

  String _badgeText(BuildContext context) => switch (outlet.status) {
    OutletCustomerStatus.active => context.l10n.filterActive,
    OutletCustomerStatus.newCustomer => context.l10n.filterNew,
    OutletCustomerStatus.potential => context.l10n.filterPotential,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  outlet.name,
                  style: TextStyle(
                    fontSize: AppSizes.fontLg,
                    fontWeight: FontWeight.w700,
                    color: context.appColors.textPrimary,
                  ),
                ),
              ),
              StatusBadge(text: _badgeText(context), type: _badgeType, shape: StatusBadgeShape.square, compact: true),
            ],
          ),
          SizedBox(height: AppSizes.md),
          _InfoRow(label: context.l10n.ownerLabel, value: outlet.owner),
          SizedBox(height: AppSizes.xs),
          _InfoRow(label: context.l10n.areaRouteLabel, value: outlet.areaRoute),
          SizedBox(height: AppSizes.xs),
          _InfoRow(label: context.l10n.addressLabel, value: outlet.address.isEmpty ? '-' : outlet.address),
          SizedBox(height: AppSizes.xs),
          if (outlet.phone.isEmpty)
            _InfoRow(label: context.l10n.phoneLabel, value: '-')
          else
            InkWell(
              onTap: () => launchUrl(Uri(scheme: 'tel', path: outlet.phone)),
              child: _InfoRow(
                label: context.l10n.phoneLabel,
                value: outlet.phone,
                valueColor: AppColors.primary,
                trailingIcon: Icons.call_rounded,
              ),
            ),
          SizedBox(height: AppSizes.lg),
          Divider(height: 1, color: AppColors.border),
          SizedBox(height: AppSizes.md),
          Text(
            context.l10n.recentSalesTitle,
            style: TextStyle(fontSize: AppSizes.fontSm, fontWeight: FontWeight.w700, color: context.appColors.textPrimary),
          ),
          SizedBox(height: AppSizes.xs),
          FutureBuilder<List<SaleModel>>(
            future: ref.read(outletsCustomersRepositoryProvider).getSalesForOutlet(outlet.id),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSizes.sm),
                  child: CustomShimmer(height: 60, borderRadius: BorderRadius.circular(AppSizes.radiusMd)),
                );
              }
              final sales = snapshot.data!.take(5).toList();
              if (sales.isEmpty) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSizes.sm),
                  child: Text(
                    context.l10n.noRecentSalesYet,
                    style: TextStyle(color: context.appColors.textSecondary, fontSize: AppSizes.fontSm),
                  ),
                );
              }
              return Column(
                children: [
                  for (final sale in sales)
                    CustomListTile(
                      title: '${sale.productName} x ${sale.quantity}',
                      subtitle: '${sale.date.day} ${_month(sale.date.month)} ${sale.date.year}',
                      trailing: Text(
                        CurrencyFormatter.format(sale.amount),
                        style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.primary),
                      ),
                    ),
                ],
              );
            },
          ),
          SizedBox(height: AppSizes.lg),
          PrimaryButton(
            label: context.l10n.recordSaleAction,
            onPressed: () {
              Navigator.of(context).pop();
              context.push(RouteNames.new_sale_entry, extra: outlet.id);
            },
          ),
        ],
      ),
    );
  }

  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  String _month(int month) => _months[month - 1];
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value, this.valueColor, this.trailingIcon});

  final String label;
  final String value;
  final Color? valueColor;
  final IconData? trailingIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: TextStyle(color: context.appColors.textSecondary, fontSize: AppSizes.fontSm),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? context.appColors.textPrimary,
              fontSize: AppSizes.fontSm,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        if (trailingIcon != null) Icon(trailingIcon, size: AppSizes.iconSm, color: AppColors.primary),
      ],
    );
  }
}
