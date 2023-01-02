// ignore_for_file: prefer_final_fields
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sound_analysis/models/patient.dart';

import '../providers/patient_provider.dart';

class PatientFormScreen extends StatefulWidget {
  const PatientFormScreen({Key? key}) : super(key: key);
  static const routeName = '/patient-form';

  @override
  State<PatientFormScreen> createState() => _PatientFormScreenState();
}

class _PatientFormScreenState extends State<PatientFormScreen> {
  bool isSignUp = false;
  String? _selectAge;
  final _formKey = GlobalKey<FormState>();
  Map<String, String> _authData = {
    'patientName': '',
    'email': '',
    'cnic': '',
    'age': '',
    'phone': '',
    'gender': '',
  };

  void _submit() {
    final patientProvider =
        Provider.of<PatientProvider>(context, listen: false);
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState?.save();
    setState(() {
      isSignUp = true;
    });
    Patient newPatient = Patient(
        id: DateTime.now().toString(),
        patientName: _authData['patientName']!,
        email: _authData['email']!,
        cnic: _authData['cnic']!,
        age: _authData['age']!,
        gender: _authData['gender']!,
        phone: _authData['phone']!);
    try {
      patientProvider.addPatient(newPatient);
      Navigator.of(context).pop();
    } catch (error) {
      _showErrorDialog(error.toString());
    }
    setState(() {
      isSignUp = false;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  void _pickedAge() {
    showDatePicker(
      context: context,
      initialDate: DateTime(1960),
      firstDate: DateTime(1960),
      lastDate: DateTime.now(),
    ).then((age) {
      if (age == null) {
        return;
      }
      setState(() {
        _selectAge = DateFormat.yMd().format(age);
        _authData['age'] = _selectAge!;
      });
    });
  }

  Form _patientDetailFormFunction() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value == '') {
                return 'Please enter your name,';
              }
              return null;
            },
            decoration: const InputDecoration(
              label: Text('Username'),
              border: OutlineInputBorder(),
            ),
            onSaved: (value) {
              setState(() {
                _authData['patientName'] = value!;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: (value) {
              if (value!.endsWith('.com') && value.contains('@')) {
                return null;
              }
              return 'Enter valid email.';
            },
            decoration: const InputDecoration(
              label: Text('Email'),
              border: OutlineInputBorder(),
            ),
            onSaved: (value) {
              setState(() {
                _authData['email'] = value!;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: (value) {
              if (value!.length != 15 || !value.contains('-')) {
                return 'Please enter correct CNIC eg 17302-7654398-9';
              }
              return null;
            },
            decoration: const InputDecoration(
              label: Text('CNIC'),
              border: OutlineInputBorder(),
            ),
            onSaved: (value) {
              setState(() {
                _authData['cnic'] = value!;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: (value) {
              if (value == '') {
                return 'Invalid Number';
              }
              return null;
            },
            decoration: const InputDecoration(
              label: Text('Phone Number'),
              border: OutlineInputBorder(),
            ),
            onSaved: (value) {
              setState(() {
                _authData['phone'] = value!;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            height: 55,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey, width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  _authData['age'] == null
                      ? 'No age chosen yet'
                      : 'Age: ${_authData["age"]}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: _pickedAge,
                  child: const Text('Select age'),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: [
              RadioListTile(
                value: 'male',
                groupValue: _authData['gender'],
                onChanged: (value) {
                  setState(() {
                    _authData['gender'] = value.toString();
                  });
                },
                title: const Text('Male'),
              ),
              RadioListTile(
                  value: 'female',
                  groupValue: _authData['gender'],
                  onChanged: (value) {
                    setState(() {
                      _authData['gender'] = value.toString();
                    });
                  },
                  title: const Text('Female')),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          isSignUp == false
              ? ElevatedButton(
                  onPressed: _submit,
                  child: const Text('submit'),
                )
              : const CircularProgressIndicator(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Form'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              _patientDetailFormFunction(),
            ],
          ),
        ),
      ),
    );
  }
}
