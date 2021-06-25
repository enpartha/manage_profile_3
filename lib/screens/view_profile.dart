import 'package:flutter/material.dart';
import 'package:manage_profile_3/screens/manage_profile.dart';
import '../providers/user_data.dart';

class ViewProfile extends StatelessWidget {
  const ViewProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _userData = UserData().userProfile;
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ManageProfilePage()),
          );
        },
        child: Icon(Icons.edit),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 60.0,
                backgroundColor: Colors.white,
                // backgroundImage: ,
              ),
              ShowProfileData(_userData.name),
              ShowProfileData(_userData.gender),
              ShowProfileData(_userData.dateOfBirth),
              ShowProfileData(_userData.hospital),
              ShowProfileData(_userData.department),
              ShowProfileData(_userData.role),
              ShowProfileData(_userData.qualification),
              ShowProfileData(_userData.registration),
              ShowProfileData(_userData.experience! + ' Years'),
            ],
          ),
        ),
      ),
    );
  }
}

class ShowProfileData extends StatelessWidget {
  final data;
  ShowProfileData(
    this.data, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 12),
      child: ListTile(
        leading: Container(
            height: double.infinity,
            child: Icon(Icons.arrow_forward_ios, size: 30)),
        title: Text(data.toString()),
        // trailing: Icon(Icons.edit),
      ),
    );
  }
}
