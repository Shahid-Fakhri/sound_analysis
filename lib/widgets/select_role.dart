// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';

class SelectRole extends StatelessWidget {
  String dropDownValue;

  SelectRole([this.dropDownValue = 'Male']);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      elevation: 5,
      dropdownColor: Colors.grey,
      style: const TextStyle(
        color: Colors.black,
      ),
      decoration: const InputDecoration(
        label: Text('Select Gender'),
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(),
        ),
      ),
      value: dropDownValue,
      onChanged: (newRole) {
        dropDownValue = newRole.toString();
      },
      items: ['Male', 'Female'].map((newItem) {
        return DropdownMenuItem(
          value: newItem,
          child: Text(newItem),
        );
      }).toList(),
    );
  }
}
