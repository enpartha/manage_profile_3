import 'package:flutter/foundation.dart';

class Profile with ChangeNotifier {
  String? profilePhoto;
  String name;
  String? gender;
  String? hospital;
  String? department;
  String? role;
  String? qualification;
  String? experience;
  String? registration;
  DateTime dateOfBirth = DateTime(1990);
  String? userId;
  String? groupId;

  Profile({
    this.name = 'User',
    required this.dateOfBirth,
    this.department,
    this.experience,
    this.gender,
    this.hospital,
    this.profilePhoto,
    this.qualification,
    this.registration,
    this.role,
    this.userId,
  });
}
