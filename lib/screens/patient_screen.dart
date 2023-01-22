import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/patient_provider.dart';
import 'patient_form_screen.dart';
import 'patient_detail_screen.dart';
import '../widgets/popmenu.dart';

class PatientScreen extends StatefulWidget {
  const PatientScreen({Key key}) : super(key: key);
  static const routeName = '/patient';

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  @override
  Widget build(BuildContext context) {
    final patientProvider = Provider.of<PatientProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 3,
          horizontal: 2,
        ),
        child: ListView.builder(
          itemCount: patientProvider.getPatient.length,
          itemBuilder: (ctx, item) => Container(
            decoration: BoxDecoration(
              color: const Color(0xffE6e6e6),
              borderRadius: BorderRadius.circular(5),
              // border: Border.all(color: Colors.black26,width: 2),
            ),
            margin: const EdgeInsets.only(bottom: 5),
            child: ListTile(
              onTap: () {
                Navigator.of(context).pushNamed(
                  PatientDetailScreen.routeName,
                  arguments: patientProvider.getPatient[item].id,
                );
              },
              title: Text(patientProvider.getPatient[item].patientName),
              trailing: PopMenu(patientProvider.getPatient[item].id),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(PatientFormScreen.routeName);
          },
          child: const Icon(Icons.add)),
    );
  }
}
