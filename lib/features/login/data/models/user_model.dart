import '../../../../core/constants/user_role.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String employeeId;
  final UserRole role;
  final String? teamId;
  final String? companyId;
  final bool isActive;
  final String? photoUrl;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone = '',
    this.employeeId = '',
    this.role = UserRole.salesman,
    this.teamId,
    this.companyId,
    this.isActive = true,
    this.photoUrl,
  });

  /// Builds from a Firestore `users/{email}` document map. [id] is the
  /// doc ID (the normalized email), passed separately since it isn't a
  /// field inside the document itself.
  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      id: id,
      name: map['name'] as String? ?? '',
      email: map['email'] as String? ?? id,
      phone: map['phone'] as String? ?? '',
      employeeId: map['employeeId'] as String? ?? '',
      role: UserRoleParsing.fromString(map['role'] as String?),
      teamId: map['teamId'] as String?,
      companyId: map['companyId'] as String?,
      isActive: (map['status'] as String? ?? 'active') == 'active',
      photoUrl: map['photoUrl'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
    'name': name,
    'email': email,
    'phone': phone,
    'employeeId': employeeId,
    'role': role.wireValue,
    'teamId': teamId,
    'companyId': companyId,
    'status': isActive ? 'active' : 'inactive',
    'photoUrl': photoUrl,
  };
}