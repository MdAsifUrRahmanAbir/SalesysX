import 'package:flutter/material.dart';

import '../../../../core/locale/app_localizations_x.dart';

/// Icon + label data for one bottom-nav tab. Kept as plain data (not
/// a widget) so the destination list can be built once and reused by
/// both [ShellTabBody] index lookups and the nav bar itself — add or
/// reorder a feature here and both the tab content and the nav icons
/// update together.
///
/// Same five tabs for every signed-in role (Salesman and Team Head) —
/// a Team Head has the full salesman feature set (Home/Sales/Customers/
/// Target) plus their team-only screens (Dashboard, Sales Log, Reports),
/// which live under Profile instead of competing for bottom-nav space.
class ShellNavItemData {
  final IconData icon;
  final IconData selectedIcon;
  final String label;

  const ShellNavItemData({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });
}

/// Labels are locale-dependent, so this builds the list fresh from
/// `context` rather than being a top-level `const` — the one spot in
/// the shell that genuinely needs a `BuildContext` to resolve strings.
List<ShellNavItemData> shellNavItemsOf(BuildContext context) => [
  ShellNavItemData(
    icon: Icons.home_outlined,
    selectedIcon: Icons.home_rounded,
    label: context.l10n.navHome,
  ),
  ShellNavItemData(
    icon: Icons.point_of_sale_outlined,
    selectedIcon: Icons.point_of_sale_rounded,
    label: context.l10n.navSales,
  ),
  ShellNavItemData(
    icon: Icons.storefront_outlined,
    selectedIcon: Icons.storefront_rounded,
    label: context.l10n.navCustomers,
  ),
  ShellNavItemData(
    icon: Icons.flag_outlined,
    selectedIcon: Icons.flag_rounded,
    label: context.l10n.navTarget,
  ),
  ShellNavItemData(
    icon: Icons.person_outline_rounded,
    selectedIcon: Icons.person_rounded,
    label: context.l10n.navProfile,
  ),
];
