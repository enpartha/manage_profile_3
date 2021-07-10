import 'package:flutter/material.dart';
import 'package:manage_profile_3/screens/manage_profile.dart';
import 'package:provider/provider.dart';
import '../providers/user_data.dart';

// ignore: must_be_immutable
class ViewProfile extends StatelessWidget {
  var _isInit = true;

  // ViewProfile({Key? key}) : super(key: key);
  static const routeName = '/view_profile';

  void _loadPage(context) {
    if (_isInit) {
      Provider.of<UserData>(context, listen: false).fetchProfile();
      _isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    _loadPage(context);
    final _userData = Provider.of<UserData>(context).data;
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(ManageProfilePage.routeName);
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
              ShowProfileData(_userData.experience.toString() + ' Years'),
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
