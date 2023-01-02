// ignore_for_file: prefer_final_fields, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:sound_analysis/models/patient.dart';

import '../providers/patient_provider.dart';

class EditPatientRecordScreen extends StatefulWidget {
  static const routeName = '/edit-record';

  const EditPatientRecordScreen({Key? key}) : super(key: key);

  @override
  State<EditPatientRecordScreen> createState() =>
      _EditPatientRecordScreenState();
}

class _EditPatientRecordScreenState extends State<EditPatientRecordScreen> {
  final _formKey = GlobalKey<FormState>();
  var _editPatient = Patient(
    id: '',
    patientName: '',
    email: '',
    cnic: '',
    age: '',
    gender: '',
    phone: '',
  );
  var _initialValues = {
    'patientName': '',
    'email': '',
    'cnic': '',
    'age': '',
    'gender': '',
    'phone': '',
  };
  bool _isInit = true;
  bool _isLoading = false;
  String? isSelectAge;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)?.settings.arguments as String;
      _editPatient = Provider.of<PatientProvider>(context, listen: false)
          .findById(productId);
      _initialValues = {
        'patientName': _editPatient.patientName,
        'email': _editPatient.email,
        'cnic': _editPatient.cnic,
        'age': _editPatient.age,
        'gender': _editPatient.gender,
        'phone': _editPatient.phone,
      };
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _saveForm() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    if (_editPatient.id != null) {
      Provider.of<PatientProvider>(context, listen: false)
          .updatePatient(_editPatient.id, _editPatient);
    } else {
      try {
        Provider.of<PatientProvider>(context, listen: false)
            .addPatient(_editPatient);
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
        isSelectAge = DateFormat.yMd().format(age);
        _initialValues['age'] = isSelectAge!;
      });
    });
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
        child: _isLoading
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
            initialValue: _initialValues['patientName'],
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
              _editPatient = Patient(
                id: _editPatient.id,
                patientName: value!,
                email: _editPatient.email,
                cnic: _editPatient.cnic,
                age: _editPatient.age,
                gender: _editPatient.gender,
                phone: _editPatient.phone,
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            initialValue: _initialValues['email'],
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
              _editPatient = Patient(
                id: _editPatient.id,
                patientName: _editPatient.patientName,
                email: value!,
                cnic: _editPatient.cnic,
                age: _editPatient.age,
                gender: _editPatient.gender,
                phone: _editPatient.phone,
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            initialValue: _initialValues['cnic'],
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
              _editPatient = Patient(
                id: _editPatient.id,
                patientName: _editPatient.patientName,
                email: _editPatient.email,
                cnic: value!,
                age: _editPatient.age,
                gender: _editPatient.gender,
                phone: _editPatient.phone,
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            initialValue: _initialValues['phone'],
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
              _editPatient = Patient(
                id: _editPatient.id,
                patientName: _editPatient.patientName,
                email: _editPatient.email,
                cnic: _editPatient.cnic,
                age: _editPatient.age,
                gender: _editPatient.gender,
                phone: value!,
              );
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
                  'Age: ${_initialValues["age"]}',
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
                value: 'Male',
                groupValue: _initialValues['gender'],
                onChanged: (value) {
                  setState(() {
                    _editPatient = Patient(
                      id: _editPatient.id,
                      patientName: _editPatient.patientName,
                      email: _editPatient.email,
                      cnic: _editPatient.cnic,
                      age: _editPatient.age,
                      gender: value.toString(),
                      phone: _editPatient.phone,
                    );
                  });
                },
                title: const Text('Male'),
              ),
              RadioListTile(
                  value: 'Female',
                  groupValue: _initialValues['gender'],
                  onChanged: (value) {
                    setState(() {
                      _editPatient = Patient(
                        id: _editPatient.id,
                        patientName: _editPatient.patientName,
                        email: _editPatient.email,
                        cnic: _editPatient.cnic,
                        age: _editPatient.age,
                        gender: value.toString(),
                        phone: _editPatient.phone,
                      );
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
