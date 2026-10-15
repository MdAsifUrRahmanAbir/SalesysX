import 'package:flutter/foundation.dart';

@immutable
class ProfileState {
  final bool isLoading;
  final String? errorMessage;

  final String name;
  final String avatarInitials;
  final String employeeId;
  final String roleLabel;
  final bool isTeamHead;
  final String team;
  final String division;

  final double monthlyAchieved; // stored in full currency units
  final double monthlyTarget;
  final String monthlyAchievedShortLabel; // '৳3.40L'
  final String monthlyTargetShortLabel; // '৳5L'

  final int activeOutletCount;
  final int salesTodayCompleted;
  final String middleStatLabel;
  final String middleStatSubtitle;

  const ProfileState({
    this.isLoading = false,
    this.errorMessage,
    this.name = '',
    this.avatarInitials = '',
    this.employeeId = '',
    this.roleLabel = '',
    this.isTeamHead = false,
    this.team = '',
    this.division = '',
    this.monthlyAchieved = 0,
    this.monthlyTarget = 0,
    this.monthlyAchievedShortLabel = '',
    this.monthlyTargetShortLabel = '',
    this.activeOutletCount = 0,
    this.salesTodayCompleted = 0,
    this.middleStatLabel = '',
    this.middleStatSubtitle = '',
  });

  ProfileState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? name,
    String? avatarInitials,
    String? employeeId,
    String? roleLabel,
    bool? isTeamHead,
    String? team,
    String? division,
    double? monthlyAchieved,
    double? monthlyTarget,
    String? monthlyAchievedShortLabel,
    String? monthlyTargetShortLabel,
    int? activeOutletCount,
    int? salesTodayCompleted,
    String? middleStatLabel,
    String? middleStatSubtitle,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      name: name ?? this.name,
      avatarInitials: avatarInitials ?? this.avatarInitials,
      employeeId: employeeId ?? this.employeeId,
      roleLabel: roleLabel ?? this.roleLabel,
      isTeamHead: isTeamHead ?? this.isTeamHead,
      team: team ?? this.team,
      division: division ?? this.division,
      monthlyAchieved: monthlyAchieved ?? this.monthlyAchieved,
      monthlyTarget: monthlyTarget ?? this.monthlyTarget,
      monthlyAchievedShortLabel:
      monthlyAchievedShortLabel ?? this.monthlyAchievedShortLabel,
      monthlyTargetShortLabel:
      monthlyTargetShortLabel ?? this.monthlyTargetShortLabel,
      activeOutletCount: activeOutletCount ?? this.activeOutletCount,
      salesTodayCompleted: salesTodayCompleted ?? this.salesTodayCompleted,
      middleStatLabel: middleStatLabel ?? this.middleStatLabel,
      middleStatSubtitle: middleStatSubtitle ?? this.middleStatSubtitle,
    );
  }
}