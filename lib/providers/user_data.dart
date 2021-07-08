import 'dart:convert';

import '../models/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserData with ChangeNotifier {
  Profile _userProfile = Profile(
      name: 'Amit Sen',
      hospital: 'SSKM',
      department: 'Oncology',
      role: 'Nurse',
      dateOfBirth: DateTime(1991, 12, 25),
      gender: 'Male',
      qualification: 'Nursing Degree1',
      experience: '2',
      registration: '101');

  Future<void> updateProfile(userId, Profile profileData) async {
    final profileIndex =
        _profileItems.indexWhere((element) => element.userId == userId);

    if (profileIndex >= 0) {
      final _url = Uri.https('manage-profile-default-rtdb.firebaseio.com',
          'profileData/$userId.json');
      http.patch(_url,
          body: json.encode({
            'name': data.name,
            'gender': data.gender,
            'hospital': data.hospital,
            'department': data.department,
            'role': data.role,
            'qualification': data.qualification,
            'registration': data.registration,
            'experience': data.experience,
            'dateOfBirth': data.dateOfBirth,
          }));
      _profileItems[profileIndex] = data;
      _profileItems[profileIndex].userId = userId;
    }
    // _userProfile = profileData;
  }

  static List<Profile> _profileItems = [];

  final url =
      Uri.https('manage-profile-default-rtdb.firebaseio.com', '/profiles.json');
  Profile get data {
    return _userProfile;
  }

  Future<void> fetchUserData() async {
    try {
      final response = await http.get(url);
      final decodedJSON = jsonDecode(response.body);

      final extractedData =
          decodedJSON != null ? decodedJSON as Map<String, dynamic> : {};

      final List<Profile> loadedProfile = [];
      extractedData.forEach((profileId, profileData) {
        loadedProfile.add(Profile(
          userId: profileId,
          name: profileData['name'],
          gender: profileData['gender'],
          hospital: profileData['hospital'],
          department: profileData['department'],
          role: profileData['role'],
          qualification: profileData['qualification'],
          registration: profileData['registration'],
          experience: profileData['experience'],
          dateOfBirth: profileData['dateOfBirth'],
        ));
      });
      _profileItems = loadedProfile;
    } catch (error) {
      print(error);
    }
  }

  Future<void> addProfile(data, BuildContext context) async {
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'name': data.name,
          'gender': data.gender,
          'hospital': data.hospital,
          'department': data.department,
          'role': data.role,
          'qualification': data.qualification,
          'registration': data.registration,
          'experience': data.experience,
          'dateOfBirth': data.dateOfBirth,
        }),
      );
      final newProfile = Profile(
          name: data.name,
          gender: data.gender,
          hospital: data.hospital,
          department: data.department,
          role: data.role,
          registration: data.registration,
          qualification: data.qualification,
          experience: data.experience,
          dateOfBirth: data.dateOfBirth,
          userId: json.decode(response.body)['name']);
      _profileItems.add(newProfile);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
