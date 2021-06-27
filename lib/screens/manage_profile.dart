import 'package:flutter/material.dart';
import 'package:manage_profile_3/models/profile.dart';
import 'package:manage_profile_3/providers/user_data.dart';
import 'package:provider/provider.dart';

class ManageProfilePage extends StatefulWidget {
  static const routeName = '/manage_profile';
  @override
  _ManageProfilePageState createState() => _ManageProfilePageState();
}

class _ManageProfilePageState extends State<ManageProfilePage> {
  Object? role;
  Object? gender;
  Object? qualification;

  List listItem = ['Nurse', 'Nursing Incharge', 'Supervisor'];
  List listGender = ['Male', 'Female'];
  List listQualification = ['Nursing Degree1', 'Bachelor'];

  Color _iconColor = Colors.blue;
  // final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  TextEditingController _userCtrlr = TextEditingController();
  TextEditingController _genderCtrlr = TextEditingController();
  TextEditingController _hospitalCtrlr = TextEditingController();
  TextEditingController _departmentCtrlr = TextEditingController();
  TextEditingController _roleCtrlr = TextEditingController();
  TextEditingController _designationCtrlr = TextEditingController();
  TextEditingController _qualificationCtrlr = TextEditingController();
  TextEditingController _dobCtrlr = TextEditingController();
  TextEditingController _expCtrlr = TextEditingController();

  // void dateshower() {
  //   _openDatePicker(context);
  //   _textEditingController.text = DateFormat('yyyy/MM/dd').format(date);
  // }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1947),
        lastDate: DateTime(2050));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        var date =
            "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
        _userCtrlr.text = date;
      });
    }
  }

  var _editedProfile = Profile(
    name: '',
    gender: '',
    hospital: '',
    department: '',
    role: '',
    qualification: '',
    experience: '2',
  );

  @override
  void dispose() {
    _userCtrlr.dispose();
    _genderCtrlr.dispose();
    _hospitalCtrlr.dispose();
    _departmentCtrlr.dispose();
    _roleCtrlr.dispose();
    _qualificationCtrlr.dispose();
    _designationCtrlr.dispose();
    _dobCtrlr.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  void _saveProfile() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      _editedProfile = Profile(
          name: _userCtrlr.text,
          gender: _genderCtrlr.text,
          hospital: _hospitalCtrlr.text,
          department: _departmentCtrlr.text,
          role: _roleCtrlr.text,
          qualification: _qualificationCtrlr.text,
          experience: _expCtrlr.text);
    }
    _formKey.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    var _formKey;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            onPressed: _saveProfile,
          )
        ],
        // automaticallyImplyLeading: true,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () => Navigator.popAndPushNamed(
        // ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                // SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Center(
                    child: CircleAvatar(
                      radius: 60.0,
                      backgroundColor: Colors.white,
                      // backgroundImage: AssetImage("assets/images/user2.jpg"),
                    ),
                  ),
                ),
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
                    controller: _userCtrlr,
                  ),
                  // trailing: Icon(Icons.edit),
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
                    // icon: Icon(Icons.arrow_drop_down),
                    hint: Text("Select Gender"),
                    value: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value;
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
                  // trailing: Icon(Icons.edit),
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
                  // trailing: Icon(Icons.edit),
                ),
                // SizedBox(
                //   height: 10,
                // ),
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
                    value: role,
                    onChanged: (newValue) {
                      setState(() {
                        role = newValue;
                      });
                    },
                    items: listItem.map((valueItem) {
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
                    // icon: Icon(Icons.arrow_drop_down),
                    hint: Text("Select Qualification"),
                    value: qualification,
                    onChanged: (value) {
                      setState(() {
                        qualification = value;
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
                  ),
                  // trailing: Icon(Icons.edit),
                ),
                // ListTile(
                //   leading: Container(
                //     height: double.infinity,
                //     child: Icon(
                //       Icons.work,
                //       color: _iconColor,
                //       size: 30,
                //     ),
                //   ),
                //   title: TextFormField(
                //     decoration: InputDecoration(
                //       labelText: "Years Of Experience",
                //     ),
                //     keyboardType: TextInputType.number,
                //     inputFormatters: <TextInputFormatter>[
                //       FilteringTextInputFormatter.digitsOnly
                //     ],
                //   ),
                // ),
                // SizedBox(height: 15),
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
                      Icons.calendar_today,
                      color: _iconColor,
                      size: 30,
                    ),
                  ),
                  title: GestureDetector(
                    child: TextFormField(
                      onTap: () => _selectDate(context),
                      controller: _dobCtrlr,
                      decoration: InputDecoration(
                        labelText: "Date of Birth",
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
