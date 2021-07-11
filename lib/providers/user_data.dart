import 'dart:convert';

import '../models/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserData with ChangeNotifier {
  Profile _userProfile = Profile();
  final url = Uri.https(
      'profile-managment-default-rtdb.firebaseio.com', '/profile.json');

  Future<void> fetchProfile() async {
    try {
      final response = await http.get(url);
      final decodedJSON = jsonDecode(response.body);

      final profileData =
          decodedJSON != null ? decodedJSON as Map<String, dynamic> : {};
      // print(decodedJSON);

      final loadedProfile = profileData.isEmpty
          ? Profile()
          : Profile(
              // userId: profileId,
              name: profileData['name'],
              gender: profileData['gender'],
              hospital: profileData['hospital'],
              department: profileData['department'],
              role: profileData['role'],
              qualification: profileData['qualification'],
              registration: profileData['registration'],
              experience: profileData['experience'],
              dateOfBirth: DateTime.parse(profileData['dateOfBirth']),
            );

      _userProfile = loadedProfile;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateProfile(userId, Profile profileData) async {
    http.patch(url,
        body: json.encode({
          'name': profileData.name,
          'gender': profileData.gender,
          'hospital': profileData.hospital,
          'department': profileData.department,
          'role': profileData.role,
          'qualification': profileData.qualification,
          'registration': profileData.registration,
          'experience': profileData.experience,
          'dateOfBirth': profileData.dateOfBirth!.toIso8601String(),
        }));

    _userProfile = profileData;
    notifyListeners();
  }

  Profile get data {
    return _userProfile;
  }
}
