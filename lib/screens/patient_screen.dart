import 'package:flutter/material.dart';

import 'patient_form_screen.dart';
import 'patient_detail_screen.dart';
import '../services/database.dart';
import './edit_patient_record_screen.dart';

class PatientScreen extends StatefulWidget {
  const PatientScreen({Key key}) : super(key: key);
  static const routeName = '/patient';

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  DatabaseHelper dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> patientsName = [];
  bool isLoading = false;

  @override
  void initState() {
    getPatient();
    super.initState();
  }

  void removePatient(BuildContext context, String id) async {
    int res = await dbHelper.deleteRecord(id);
    if (res != 0) {
      getPatient();
    }
  }

  void getPatient() async {
    setState(() {
      isLoading = true;
    });
    patientsName = await dbHelper.fetchPatient();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.symmetric(
                vertical: 3,
                horizontal: 2,
              ),
              child: ListView.builder(
                itemCount: patientsName.length,
                itemBuilder: (ctx, patient) => Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffE6e6e6),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  margin: const EdgeInsets.only(bottom: 5),
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        PatientDetailScreen.routeName,
                        arguments: patientsName[patient]['id'],
                      );
                    },
                    title: Text(patientsName[patient]['name']),
                    trailing: PopupMenuButton(
                      icon: const Icon(Icons.more_vert),
                      onSelected: (value) {
                        if (value == 'Delete') {
                          removePatient(context, patientsName[patient]['id']);
                        } else {
                          Navigator.of(context).pushNamed(
                              EditPatientRecordScreen.routeName,
                              arguments: patientsName[patient]['id']);
                        }
                      },
                      itemBuilder: (_) => const [
                        PopupMenuItem(
                          value: 'Delete',
                          child: Text('Delete'),
                        ),
                        PopupMenuItem(
                          value: 'Edit',
                          child: Text('Edit'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.of(context)
                .pushNamed(PatientFormScreen.routeName);
            if (result != 0) {
              getPatient();
            }
          },
          child: const Icon(Icons.add)),
    );
  }
}
