// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      active: json['active'] as bool,
      email: json['email'] as String,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      roleCode: json['role_code'] as String,
      officeCode: json['office_code'] as String,
      creationDate: DateFormat('E, d MMM yyyy HH:mm:ss z')
          .parse(json['creation_date'] as String),
      employeeId: json['employee_id'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'active': instance.active,
      'email': instance.email,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'role_code': instance.roleCode,
      'office_code': instance.officeCode,
      'creation_date': instance.creationDate.toUtc(),
      'employee_id': instance.employeeId,
    };
