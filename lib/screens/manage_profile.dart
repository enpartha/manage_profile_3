import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manage_profile_3/models/profile.dart';
import 'package:manage_profile_3/providers/user_data.dart';
import 'package:provider/provider.dart';

class ManageProfilePage extends StatefulWidget {
  static const routeName = '/manage_profile';
  @override
  _ManageProfilePageState createState() => _ManageProfilePageState();
}

class _ManageProfilePageState extends State<ManageProfilePage> {
  String? _role;
  String? _gender;
  String? _qualification;
  DateTime? _dob;

  List listRole = ['Nurse', 'Nursing Incharge', 'Supervisor'];
  List listGender = ['Male', 'Female'];
  List listQualification = ['Nursing Degree1', 'Bachelor'];

  Color _iconColor = Colors.blue;
  final _nameCtrlr = TextEditingController();
  final _hospitalCtrlr = TextEditingController();
  final _departmentCtrlr = TextEditingController();
  final _designationCtrlr = TextEditingController();
  final _expCtrlr = TextEditingController();
  final _regCtrlr = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var _editedProfile = Profile();
  var userId;

  String _dobFormField = 'Select Date of Birth';

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  _takePhoto(BuildContext context, ImageSource source) async {
    final _pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      if (_pickedFile != null) {
        _imageFile = File(_pickedFile.path);
      } else {
        print("No image has been selected");
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  // void dateshower() {
  //   _openDatePicker(context);
  //   _textEditingController.text = DateFormat('yyyy/MM/dd').format(date);
  // }

  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _editedProfile = Provider.of<UserData>(context).data;

      _nameCtrlr.text = _editedProfile.name;
      _gender = _editedProfile.gender;
      _hospitalCtrlr.text = _editedProfile.hospital;
      _departmentCtrlr.text = _editedProfile.department;
      _role = _editedProfile.role;
      _regCtrlr.text = _editedProfile.registration;
      _qualification = _editedProfile.qualification;
      _expCtrlr.text = _editedProfile.experience;
      _dob = _editedProfile.dateOfBirth;
      _imageFile = _editedProfile.profilePhoto as File?;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _dob == null ? DateTime(2000, 9, 7, 10) : _dob!,
        firstDate: DateTime(1947),
        lastDate: DateTime(2050));
    if (picked != null && picked != _dob) {
      setState(() {
        _dob = picked;
        var date =
            "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
        _dobFormField = date;
      });
    }
  }

  Future<void> _saveProfile() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    _editedProfile = Profile(
        // profilePhoto: _imageFile ,
        name: _nameCtrlr.text,
        gender: _gender,
        hospital: _hospitalCtrlr.text,
        department: _departmentCtrlr.text,
        role: _role,
        qualification: _qualification,
        registration: _regCtrlr.text,
        experience: _expCtrlr.text,
        dateOfBirth: _dob);
    print('saved');
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<UserData>(context, listen: false)
          .updateProfile(userId, _editedProfile);
    } catch (error) {
      print(error.toString());
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occured'),
          content: Text('Something went wrong'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text('Okay'))
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _nameCtrlr.dispose();
    _hospitalCtrlr.dispose();
    _departmentCtrlr.dispose();
    _designationCtrlr.dispose();
    _expCtrlr.dispose();
    _regCtrlr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _dobFormField = _dob == null
        ? _dobFormField
        : "${_dob!.toLocal().day}/${_dob!.toLocal().month}/${_dob!.toLocal().year}";

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            onPressed: _saveProfile,
          )
        ],
      ),
      body: SafeArea(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: Stack(
                            children: [
                              Container(
                                child: CircleAvatar(
                                    radius: 60.0,
                                    // backgroundColor: Colors.white,
                                    backgroundImage: _imageFile == null
                                        ? AssetImage("assets/images/OIP.jpg")
                                        : FileImage(_imageFile!)
                                            as ImageProvider),
                              ),
                              Positioned(
                                top: 70,
                                left: 66,
                                child: FloatingActionButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                              "Choose an Option",
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      _takePhoto(context,
                                                          ImageSource.camera);
                                                      Navigator.pop(context);
                                                    },
                                                    splashColor:
                                                        Colors.blue[50],
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.camera,
                                                          color: Colors.black,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(12.0),
                                                          child: Text(
                                                            "Camera",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      _takePhoto(context,
                                                          ImageSource.gallery);
                                                      Navigator.pop(context);
                                                    },
                                                    splashColor:
                                                        Colors.blue[50],
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.image,
                                                          color: Colors.black,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(12.0),
                                                          child: Text(
                                                            "Gallery",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  mini: true,
                                  child: Icon(Icons.add_a_photo),
                                ),
                              )
                            ],
                          )),
                      ListTile(
                        leading: Container(
                          height: double.infinity,
                          child: Icon(
                            Icons.account_circle,
                            color: _iconColor,
                            size: 30,
                          ),
                        ),
                        title: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Name",
                          ),
                          controller: _nameCtrlr,
                        ),
                      ),
                      ListTile(
                        leading: Container(
                          height: double.infinity,
                          child: Icon(
                            Icons.emoji_people_outlined,
                            color: _iconColor,
                            size: 40,
                          ),
                        ),
                        title: DropdownButton(
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          hint: Text("Select Gender"),
                          value: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value.toString();
                            });
                          },
                          items: listGender.map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),

                      ListTile(
                        leading: Container(
                          height: double.infinity,
                          child: Icon(
                            Icons.local_hospital,
                            color: _iconColor,
                            size: 30,
                          ),
                        ),
                        title: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Hospital Name",
                          ),
                          controller: _hospitalCtrlr,
                        ),
                      ),
                      ListTile(
                        leading: Container(
                          height: double.infinity,
                          child: Icon(
                            Icons.account_tree,
                            color: _iconColor,
                            size: 30,
                          ),
                        ),
                        title: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Department Name",
                          ),
                          controller: _departmentCtrlr,
                        ),
                      ),

                      ListTile(
                        leading: Container(
                          height: double.infinity,
                          child: Icon(
                            Icons.supervisor_account,
                            color: _iconColor,
                            size: 40,
                          ),
                        ),
                        title: DropdownButton(
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          // icon: Icon(Icons.arrow_drop_down),
                          hint: Text("Role/Designation"),
                          value: _role,
                          onChanged: (value) {
                            setState(() {
                              _role = value.toString();
                            });
                          },
                          items: listRole.map((valueItem) {
                            return DropdownMenuItem(
                              value: valueItem,
                              child: Text(valueItem),
                            );
                          }).toList(),
                        ),
                      ),
                      ListTile(
                        leading: Container(
                          height: double.infinity,
                          child: Icon(
                            Icons.supervisor_account,
                            color: _iconColor,
                            size: 40,
                          ),
                        ),
                        title: DropdownButton(
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          hint: Text("Select Qualification"),
                          value: _qualification,
                          onChanged: (value) {
                            setState(() {
                              _qualification = value.toString();
                            });
                          },
                          items: listQualification.map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      ListTile(
                        leading: Container(
                          height: double.infinity,
                          child: Icon(
                            Icons.collections_bookmark,
                            color: _iconColor,
                            size: 30,
                          ),
                        ),
                        title: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Registration Number",
                          ),
                          controller: _regCtrlr,
                        ),
                      ),

                      ListTile(
                        leading: Icon(
                          Icons.verified_user,
                          color: _iconColor,
                          size: 30,
                        ),
                        title: Container(
                          margin: EdgeInsets.only(right: 230),
                          padding: EdgeInsets.all(8),
                          width: 70,
                          // height: 45,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [BoxShadow(color: Colors.black)],
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Text(
                            " userId",
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),

                      // SizedBox(
                      //   height: 10,
                      // ),
                      ListTile(
                        leading: Container(
                          height: double.infinity,
                          child: Icon(
                            Icons.work,
                            color: _iconColor,
                            size: 30,
                          ),
                        ),
                        title: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Year Of Experience",
                          ),
                          controller: _expCtrlr,
                        ),
                      ),
                      ListTile(
                        leading: Container(
                          height: double.infinity,
                          child: Icon(
                            Icons.calendar_today,
                            color: _iconColor,
                            size: 30,
                          ),
                        ),
                        title: GestureDetector(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: Text(_dobFormField),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
