import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';

/// Icon + label data for one bottom-nav tab. Kept as plain data (not
/// a widget) so the destination list can be built once and reused by
/// both [ShellTabBody] index lookups and the nav bar itself — add or
/// reorder a feature here and both the tab content and the nav icons
/// update together.
///
/// Order here must stay in sync with `ShellTabBody._screens`:
/// 0 Home, 1 Sales, 2 Customers, 3 Target, 4 Profile.
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

const List<ShellNavItemData> shellNavItems = [
  ShellNavItemData(
    icon: Icons.home_outlined,
    selectedIcon: Icons.home_rounded,
    label: AppStrings.navHome,
  ),
  ShellNavItemData(
    icon: Icons.point_of_sale_outlined,
    selectedIcon: Icons.point_of_sale_rounded,
    label: AppStrings.navSales,
  ),
  ShellNavItemData(
    icon: Icons.storefront_outlined,
    selectedIcon: Icons.storefront_rounded,
    label: AppStrings.navCustomers,
  ),
  ShellNavItemData(
    icon: Icons.flag_outlined,
    selectedIcon: Icons.flag_rounded,
    label: AppStrings.navTarget,
  ),
  ShellNavItemData(
    icon: Icons.person_outline_rounded,
    selectedIcon: Icons.person_rounded,
    label: AppStrings.navProfile,
  ),
];