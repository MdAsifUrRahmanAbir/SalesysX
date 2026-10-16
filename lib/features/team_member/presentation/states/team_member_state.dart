import 'package:flutter/foundation.dart';

import '../../../../core/constants/user_role.dart';
import '../../../../core/widgets/common/status_badge.dart';

@immutable
class RecentSaleActivity {
  final String outletName;
  final String detailLine;
  final String amountLabel;

  const RecentSaleActivity({
    required this.outletName,
    required this.detailLine,
    required this.amountLabel,
  });
}

class TeamMemberState {
  final bool isInitialLoading;
  final String? errorMessage;

  final String name;
  final String initials;
  final UserRole role;
  final String employeeId;
  final String email;
  final String phone;

  final double monthlyTarget;
  final double achievedAmount;
  final double todaysTarget;
  final double todaysSales;

  final bool isOnTrack;

  final List<RecentSaleActivity> recentSales;

  const TeamMemberState({
    this.isInitialLoading = false,
    this.errorMessage,
    this.name = '',
    this.initials = '',
    this.role = UserRole.salesman,
    this.employeeId = '',
    this.email = '',
    this.phone = '',
    this.monthlyTarget = 0,
    this.achievedAmount = 0,
    this.todaysTarget = 0,
    this.todaysSales = 0,
    this.isOnTrack = true,
    this.recentSales = const [],
  });

  double get remainingAmount => (monthlyTarget - achievedAmount).clamp(0, monthlyTarget);

  double get achievedPercent => monthlyTarget <= 0 ? 0 : (achievedAmount / monthlyTarget * 100).clamp(0, 100);

  double get todaysGap => (todaysTarget - todaysSales);

  StatusBadgeType get riskBadgeType => isOnTrack ? StatusBadgeType.success : StatusBadgeType.warning;

  TeamMemberState copyWith({
    bool? isInitialLoading,
    String? errorMessage,
    String? name,
    String? initials,
    UserRole? role,
    String? employeeId,
    String? email,
    String? phone,
    double? monthlyTarget,
    double? achievedAmount,
    double? todaysTarget,
    double? todaysSales,
    bool? isOnTrack,
    List<RecentSaleActivity>? recentSales,
  }) {
    return TeamMemberState(
      isInitialLoading: isInitialLoading ?? this.isInitialLoading,
      errorMessage: errorMessage,
      name: name ?? this.name,
      initials: initials ?? this.initials,
      role: role ?? this.role,
      employeeId: employeeId ?? this.employeeId,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      monthlyTarget: monthlyTarget ?? this.monthlyTarget,
      achievedAmount: achievedAmount ?? this.achievedAmount,
      todaysTarget: todaysTarget ?? this.todaysTarget,
      todaysSales: todaysSales ?? this.todaysSales,
      isOnTrack: isOnTrack ?? this.isOnTrack,
      recentSales: recentSales ?? this.recentSales,
    );
  }
}
