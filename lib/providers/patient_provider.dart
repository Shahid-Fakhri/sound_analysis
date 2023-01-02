// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '../models/patient.dart';

class PatientProvider with ChangeNotifier {
  final List<Patient> _patients = [
    Patient(
        id: '1',
        patientName: 'Sikandar khan',
        email: 'akbar@gmail.com',
        cnic: '19288-9988767-6',
        age: '3/4/1999',
        gender: 'Male',
        phone: '03013344878'),
    Patient(
        id: '2',
        patientName: 'akbar shah',
        email: 'akbar@gmail.com',
        cnic: '19288-9988767-6',
        age: '3/4/1999',
        gender: 'Male',
        phone: '03013344878'),
    Patient(
        id: '3',
        patientName: 'Waleed shah',
        email: 'akbar@gmail.com',
        cnic: '19288-9988767-6',
        age: '3/4/1999',
        gender: 'Male',
        phone: '03013344878'),
    Patient(
        id: '4',
        patientName: 'Nimra Gul',
        email: 'nimra@gmail.com',
        cnic: '17102-7766545-6',
        age: '4/12/2008',
        gender: 'Female',
        phone: '03013344878'),
  ];

  List<Patient> get getPatient {
    return [..._patients];
  }

  void addPatient(Patient newEntry) {
    try {
      _patients.insert(0,newEntry);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Patient findById(String id){
    return _patients.firstWhere((element) => element.id == id);
  }

  void deletePatient(String id){
    _patients.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void updatePatient(String id, Patient updatedPatient){
    final patientIndex = _patients.indexWhere((element) => element.id == id);
    if(patientIndex >= 0){
      _patients[patientIndex] = updatedPatient;
    }else{
      print('No patient found');
    }
    notifyListeners();
  }
  
}
