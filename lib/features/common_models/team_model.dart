class TeamModel {
  final String id;
  final String name;
  final String teamHeadEmail;
  final String companyId;
  final List<String> memberEmails;

  const TeamModel({
    required this.id,
    required this.name,
    required this.teamHeadEmail,
    required this.companyId,
    required this.memberEmails,
  });

  factory TeamModel.fromMap(Map<String, dynamic> map) {
    return TeamModel(
      id: map['id'] as String,
      name: map['name'] as String? ?? '',
      teamHeadEmail: map['teamHeadEmail'] as String? ?? '',
      companyId: map['companyId'] as String? ?? '',
      memberEmails: (map['memberEmails'] as List<dynamic>?)?.cast<String>() ?? const [],
    );
  }
}
