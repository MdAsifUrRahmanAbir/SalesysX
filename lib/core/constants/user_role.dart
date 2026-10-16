/// Every role stored in `users/{email}.role`. The first three are
/// admin-panel roles (this website); Team Head and Salesman are field
/// roles that only sign in to the Sales mobile app.
enum UserRole { superAdmin, admin, manager, teamHead, salesman }

extension UserRoleParsing on UserRole {
  static UserRole fromString(String? value) {
    switch ((value ?? '').trim().toUpperCase()) {
      case 'SUPER_ADMIN':
        return UserRole.superAdmin;
      case 'ADMIN':
      case 'OWNER':
        return UserRole.admin;
      case 'MANAGER':
        return UserRole.manager;
      case 'TEAM_HEAD':
        return UserRole.teamHead;
      case 'SALESMAN':
      default:
        return UserRole.salesman;
    }
  }

  String get wireValue => switch (this) {
    UserRole.superAdmin => 'SUPER_ADMIN',
    UserRole.admin => 'ADMIN',
    UserRole.manager => 'MANAGER',
    UserRole.teamHead => 'TEAM_HEAD',
    UserRole.salesman => 'SALESMAN',
  };

  String get label => switch (this) {
    UserRole.superAdmin => 'Super Admin',
    UserRole.admin => 'Admin',
    UserRole.manager => 'Manager',
    UserRole.teamHead => 'Team Head',
    UserRole.salesman => 'Salesman',
  };

  /// Roles allowed to sign in to the admin website.
  bool get isPanelRole => this == UserRole.superAdmin || this == UserRole.admin || this == UserRole.manager;

  /// Roles that use the Sales mobile app and are managed under Employees.
  bool get isFieldRole => this == UserRole.teamHead || this == UserRole.salesman;

  bool get isSuperAdmin => this == UserRole.superAdmin;
}

/// Panel roles whose permission set is configurable from Access Control.
/// Super Admin is intentionally absent — it always holds every permission
/// so it can never lock itself out.
const configurablePanelRoles = [UserRole.admin, UserRole.manager];

const panelRoles = [UserRole.superAdmin, UserRole.admin, UserRole.manager];

const fieldRoles = [UserRole.teamHead, UserRole.salesman];
