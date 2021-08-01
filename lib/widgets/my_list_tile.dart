import 'package:flutter/material.dart';
import '../screens/manage_profile.dart';

class MyListTile extends StatefulWidget {
  final IconData? icon;
  final TextEditingController? controller;
  final double size;
  final String? labelText;
  final String? hint;
  final Object? object;
  final List<dynamic>? options;

  MyListTile(
      {Key? key,
      this.icon,
      this.hint,
      this.controller,
      this.labelText,
      this.object,
      this.options,
      this.size = 30})
      : super(key: key);

  @override
  _MyListTileState createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  Color _iconColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return myListTile(
      controller: widget.controller,
      hint: widget.hint,
      icon: widget.icon,
      labelText: widget.labelText,
      object: widget.object,
      options: widget.options,
      size: widget.size,
    );
  }

  myListTile({
    IconData? icon,
    TextEditingController? controller,
    double size = 30.0,
    String? labelText,
    String? hint,
    Object? object,
    List<dynamic>? options,
  }) {
    bool isTextFormField = false;
    bool isDropdownButton = false;
    if (controller != null) isTextFormField = true;
    if (options != null) isDropdownButton = true;

    return ListTile(
      leading: Container(
        height: double.infinity,
        child: Icon(
          icon,
          color: _iconColor,
          size: size,
        ),
      ),
      title: isTextFormField == true
          ? TextFormField(
              decoration: InputDecoration(
                labelText: labelText,
              ),
              controller: controller,
            )
          : isDropdownButton == true
              ? DropdownButton(
                  isExpanded: true,
                  dropdownColor: Colors.white,
                  hint: Text(hint.toString()),
                  value: ManageProfilePageState.fields[object],
                  onChanged: (val) {
                    setState(() {
                      ManageProfilePageState.fields[object] = val;
                      //print("I m here" + fields[object].toString());
                    });
                  },
                  items: options!.map((val) {
                    return DropdownMenuItem(
                      value: val,
                      child: Text(val.toString()),
                    );
                  }).toList(),
                )
              : null,
    );
  }
}
