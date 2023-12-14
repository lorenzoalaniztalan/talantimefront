import 'package:common_models_repository/common_models_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'user.g.dart';

/// {@template user_item}
/// A single `user`.
///
/// Contains a [id], [active], [email], [firstname], [lastname] and [roleCode].
///
/// [User]s are immutable and serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}
@immutable
@JsonSerializable()
class User extends Equatable {
  /// A regular user
  const User({
    required this.id,
    required this.active,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.roleCode,
    required this.officeCode,
    required this.creationDate,
    required this.employeeId,
  });

  /// Unique identifier
  final int id;

  /// Whether this is an active user
  final bool active;

  /// User´s email.
  ///
  /// Must be a corporate talan email
  final String email;

  /// User´s first name
  final String firstname;

  /// User´s last name
  final String lastname;

  /// User´s role: USER or ADMIN
  final String roleCode;

  /// User´s office
  final String officeCode;

  /// User´s registration date
  final DateTime creationDate;

  /// User´s employee id, either DNI or NIE
  final String employeeId;

  /// True if this user has an admin role
  bool get isAdmin => roleCode == 'ADMIN';

  @override
  List<Object> get props => [id, active, email, firstname, lastname, roleCode];

  /// Deserializes the given [JsonMap] into a [User].
  static User fromJson(JsonMap json) => _$UserFromJson(json);

  /// Converts this [User] into a [JsonMap].
  JsonMap toJson() => _$UserToJson(this);

  @override
  String toString() {
    if (lastname.isEmpty && firstname.isEmpty) return '';
    if (lastname.isEmpty) return firstname;
    if (firstname.isEmpty) return lastname;
    return '$lastname, $firstname';
  }

  /// Convenient getter for avatars, tables, etc
  String get initials {
    if (lastname.isEmpty && firstname.isEmpty) return 'U';
    if (lastname.isEmpty) return firstname[0].toUpperCase();
    if (firstname.isEmpty) return lastname[0].toUpperCase();
    return '${firstname[0]}${lastname[0]}'.toUpperCase();
  }

  /// An instance of user to use when user is not authenticated
  static final empty = User(
    id: -1,
    active: false,
    email: '',
    firstname: '',
    lastname: '',
    roleCode: 'USER',
    officeCode: 'none',
    creationDate: DateTime.fromMicrosecondsSinceEpoch(0),
    employeeId: '',
  );
}
