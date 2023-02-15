// ignore_for_file: prefer_final_fields, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import '../providers/patient_provider.dart';
import '../services/database.dart';

class EditPatientRecordScreen extends StatefulWidget {
  static const routeName = '/edit-record';

  const EditPatientRecordScreen({Key key}) : super(key: key);

  @override
  State<EditPatientRecordScreen> createState() =>
      _EditPatientRecordScreenState();
}

class _EditPatientRecordScreenState extends State<EditPatientRecordScreen> {
  DatabaseHelper dbHelper = DatabaseHelper();
  final _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> data;
  bool _isInit = true;
  bool _isLoading = false;
  String isSelectAge;
  Map<String, String> _editPatient = {
    'id': '',
    'name': '',
    'email': '',
    'cnic': '',
    'age': '',
    'gender': '',
    'phone': '',
  };

  void getPatient(String id) async {
    data = await dbHelper.fetchData(id);
    if (data != null) {
      setState(() {
        _editPatient['id'] = data[0]['id'];
        _editPatient['name'] = data[0]['name'];
        _editPatient['email'] = data[0]['email'];
        _editPatient['phone'] = data[0]['phone'];
        _editPatient['age'] = data[0]['age'];
        _editPatient['gender'] = data[0]['gender'];
        _editPatient['cnic'] = data[0]['cnic'];
      });
    }
  }

  void updateRecord(Map<String, String> record) async {
    if (record['id'] == null) {
      await dbHelper.insertData(record);
    }
    await dbHelper.updateRecord(record);
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final id = ModalRoute.of(context).settings.arguments as String;
      getPatient(id);
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _saveForm() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();

    setState(() {
      _isLoading = true;
    });
    if (data[0]['id'] != null) {
      updateRecord(_editPatient);
    } else {
      try {
        updateRecord(_editPatient);
      } catch (error) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('An error occurred!'),
            content: const Text('Something went wrong.'),
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
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  void _pickedAge() async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(1960),
      firstDate: DateTime(1960),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && (pickedDate.toString() != data[0]['age'])) {
      setState(() {
        isSelectAge = DateFormat.yMd().format(pickedDate);
        _editPatient['age'] = isSelectAge;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Record'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Container(
        child: _isLoading || data == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: _editPatientDetailFormFunction(),
                ),
              ),
      ),
    );
  }

  Form _editPatientDetailFormFunction() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            initialValue: data[0]['name'],
            validator: (value) {
              if (value == '') {
                return 'Please enter your name,';
              }
              return null;
            },
            decoration: const InputDecoration(
              label: Text('Patient Name'),
              border: OutlineInputBorder(),
            ),
            onSaved: (value) {
              _editPatient = {
                'id': _editPatient['id'],
                'name': value,
                'email': _editPatient['email'],
                'cnic': _editPatient['cnic'],
                'age': _editPatient['age'],
                'gender': _editPatient['gender'],
                'phone': _editPatient['phone'],
              };
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            initialValue: data[0]['email'],
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
              _editPatient = {
                'id': _editPatient['id'],
                'name': _editPatient['name'],
                'email': value,
                'cnic': _editPatient['cnic'],
                'age': _editPatient['age'],
                'gender': _editPatient['gender'],
                'phone': _editPatient['phone'],
              };
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            initialValue: data[0]['cnic'],
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
              _editPatient = {
                'id': _editPatient['id'],
                'name': _editPatient['name'],
                'email': _editPatient['email'],
                'cnic': value,
                'age': _editPatient['age'],
                'gender': _editPatient['gender'],
                'phone': _editPatient['phone'],
              };
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            initialValue: data[0]['phone'],
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
              _editPatient = {
                'id': _editPatient['id'],
                'name': _editPatient['name'],
                'email': _editPatient['email'],
                'cnic': _editPatient['cnic'],
                'age': _editPatient['age'],
                'gender': _editPatient['gender'],
                'phone': value,
              };
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
                  'Age: ${_editPatient["age"]}',
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
                groupValue: data[0]['gender'],
                onChanged: (value) {
                  setState(() {
                    _editPatient = {
                      'id': _editPatient['id'],
                      'name': _editPatient['name'],
                      'email': _editPatient['email'],
                      'cnic': _editPatient['cnic'],
                      'age': _editPatient['age'],
                      'gender': value.toString(),
                      'phone': _editPatient['phone'],
                    };
                  });
                },
                title: const Text('Male'),
              ),
              RadioListTile(
                  value: 'female',
                  groupValue: data[0]['gender'],
                  onChanged: (value) {
                    setState(() {
                      _editPatient = {
                        'id': _editPatient['id'],
                        'name': _editPatient['name'],
                        'email': _editPatient['email'],
                        'cnic': _editPatient['cnic'],
                        'age': _editPatient['age'],
                        'gender': value.toString(),
                        'phone': _editPatient['phone'],
                      };
                    });
                  },
                  title: const Text('Female')),
            ],
          ),
        ],
      ),
    );
  }
}
