// ignore_for_file: prefer_final_fields, use_build_context_synchronously, avoid_print
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/database.dart';

class PatientFormScreen extends StatefulWidget {
  const PatientFormScreen({Key key}) : super(key: key);
  static const routeName = '/patient-form';

  @override
  State<PatientFormScreen> createState() => _PatientFormScreenState();
}

class _PatientFormScreenState extends State<PatientFormScreen> {
  DatabaseHelper dbHelper = DatabaseHelper();
  bool isSignUp = false;
  String _selectAge;
  final _formKey = GlobalKey<FormState>();
  Map<String, String> patientData = {
    'id': DateTime.now().toString(),
    'name': '',
    'email': '',
    'cnic': '',
    'age': '',
    'phone': '',
    'gender': '',
  };

  void _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState?.save();
    setState(() {
      isSignUp = true;
    });
    try {
      final id = await dbHelper.insertData(patientData);
      Navigator.of(context).pop(id);
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
        patientData['age'] = _selectAge;
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
                patientData['name'] = value;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: (value) {
              if (value.endsWith('.com') && value.contains('@')) {
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
                patientData['email'] = value;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: (value) {
              if (value.length != 15 || !value.contains('-')) {
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
                patientData['cnic'] = value;
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
                patientData['phone'] = value;
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
                  patientData['age'] == null
                      ? 'No age chosen yet'
                      : 'Age: ${patientData["age"]}',
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
                groupValue: patientData['gender'],
                onChanged: (value) {
                  setState(() {
                    patientData['gender'] = value.toString();
                  });
                },
                title: const Text('Male'),
              ),
              RadioListTile(
                  value: 'female',
                  groupValue: patientData['gender'],
                  onChanged: (value) {
                    setState(() {
                      patientData['gender'] = value.toString();
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
