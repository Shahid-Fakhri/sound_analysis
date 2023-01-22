import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/patient_provider.dart';

class DataList extends StatelessWidget {
  final String id;

  const DataList(this.id, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allPatients = Provider.of<PatientProvider>(context).getPatient;
    final patient = allPatients.firstWhere((element) => element.id == id);
    return SizedBox(
      height: 360,
      width: double.infinity,
      child: Card(
        color: const Color(0xffE6e6e6),
        elevation: 5,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ListTile(
              title: const Text(
                'Patient Name: ',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              trailing: Text(
                patient.patientName,
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            ListTile(
              title: const Text(
                'Email: ',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              trailing: Text(
                patient.email,
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            ListTile(
              title: const Text(
                'Cnic: ',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              trailing: Text(
                patient.cnic,
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            ListTile(
              title: const Text(
                'Phone: ',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              trailing: Text(
                patient.phone,
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            ListTile(
              title: const Text(
                'Age: ',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              trailing: Text(
                patient.age,
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            ListTile(
              title: const Text(
                'Gender: ',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              trailing: Text(
                patient.gender,
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
