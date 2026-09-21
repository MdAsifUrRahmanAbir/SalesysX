import 'package:flutter/foundation.dart';

enum PerformanceStatus { good, atRisk }

@immutable
class TeamMemberPerformance {
  final String name;
  final String initials;
  final String role;
  final bool isOnline;
  final double target;
  final double achieved;
  final double todaySale;
  final int achievedPercent;
  final PerformanceStatus status;

  const TeamMemberPerformance({
    required this.name,
    required this.initials,
    required this.role,
    required this.isOnline,
    required this.target,
    required this.achieved,
    required this.todaySale,
    required this.achievedPercent,
    required this.status,
  });
}

@immutable
class TeamOverviewState {
  final bool isLoading;
  final String? errorMessage;

  final String teamName;
  final double totalTarget;
  final double totalAchieved;

  final int totalMembers;
  final int onlineCount;

  final List<TeamMemberPerformance> members;

  const TeamOverviewState({
    this.isLoading = false,
    this.errorMessage,
    this.teamName = '',
    this.totalTarget = 0,
    this.totalAchieved = 0,
    this.totalMembers = 0,
    this.onlineCount = 0,
    this.members = const [],
  });

  double get totalAchievedPercent =>
      totalTarget <= 0 ? 0 : (totalAchieved / totalTarget).clamp(0, 1);

  TeamOverviewState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? teamName,
    double? totalTarget,
    double? totalAchieved,
    int? totalMembers,
    int? onlineCount,
    List<TeamMemberPerformance>? members,
  }) {
    return TeamOverviewState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      teamName: teamName ?? this.teamName,
      totalTarget: totalTarget ?? this.totalTarget,
      totalAchieved: totalAchieved ?? this.totalAchieved,
      totalMembers: totalMembers ?? this.totalMembers,
      onlineCount: onlineCount ?? this.onlineCount,
      members: members ?? this.members,
    );
  }
}