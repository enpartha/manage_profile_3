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
  DateTime? dateOfBirth;
  String? userId;
  String? groupId;

  Profile({
    this.name = 'User',
    this.dateOfBirth,
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
