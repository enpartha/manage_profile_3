import '../models/profile.dart';
import 'package:flutter/material.dart';

class UserData with ChangeNotifier {
  Profile userProfile = Profile(
    name: 'Amit Sen',
    hospital: 'SSKM',
    department: 'Oncology',
    role: 'Nurse',
    dateOfBirth: DateTime(1991, 12, 25),
    gender: 'Male',
    qualification: 'Diploma',
    experience: '2',
  );

  void updateProfile(Profile profileData) {
    userProfile = profileData;
  }
}
