import 'package:flutter/material.dart';

class DataList extends StatelessWidget {
  final List<Map<String, dynamic>> patientDetail;
  const DataList(this.patientDetail, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                patientDetail[0]['name'],
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
                patientDetail[0]['email'],
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
                patientDetail[0]['cnic'],
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
                patientDetail[0]['phone'],
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
                patientDetail[0]['age'],
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
                patientDetail[0]['gender'],
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
