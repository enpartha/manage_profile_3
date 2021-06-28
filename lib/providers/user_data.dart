import '../models/profile.dart';
import 'package:flutter/material.dart';

class UserData with ChangeNotifier {
  Profile _userProfile = Profile(
    name: 'Amit Sen',
    hospital: 'SSKM',
    department: 'Oncology',
    role: 'Nurse',
    dateOfBirth: DateTime(1991, 12, 25),
    gender: 'Male',
    qualification: 'Diploma',
    experience: '2',
  );

  Profile get data {
    return _userProfile;
  }

  void updateProfile(Profile profileData) {
    _userProfile = profileData;
    notifyListeners();
  }
}
