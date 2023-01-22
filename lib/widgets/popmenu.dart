import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/patient_provider.dart';
import '../screens/edit_patient_record_screen.dart';

class PopMenu extends StatelessWidget {
  final String id;

  const PopMenu(this.id, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deleteAndEditData =
        Provider.of<PatientProvider>(context, listen: false);
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      onSelected: (value) {
        if (value == 'Delete') {
          deleteAndEditData.deletePatient(id);
        } else {
          Navigator.of(context)
              .pushNamed(EditPatientRecordScreen.routeName, arguments: id);
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
    );
  }
}
