enum UserRole { admin, teamHead, salesman }

extension UserRoleParsing on UserRole {
  static UserRole fromString(String? value) {
    switch ((value ?? '').trim().toUpperCase()) {
      case 'ADMIN':
      case 'OWNER':
        return UserRole.admin;
      case 'TEAM_HEAD':
        return UserRole.teamHead;
      case 'SALESMAN':
      default:
        return UserRole.salesman;
    }
  }

  String get wireValue => switch (this) {
    UserRole.admin => 'ADMIN',
    UserRole.teamHead => 'TEAM_HEAD',
    UserRole.salesman => 'SALESMAN',
  };

  String get label => switch (this) {
    UserRole.admin => 'Admin',
    UserRole.teamHead => 'Team Head',
    UserRole.salesman => 'Salesman',
  };
}