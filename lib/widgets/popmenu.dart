import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/patient_provider.dart';
import '../screens/edit_patient_record_screen.dart';

class PopMenu extends StatefulWidget {
  final String patientId;

  const PopMenu(this.patientId, {Key key}) : super(key: key);

  @override
  State<PopMenu> createState() => _PopMenuState();
}

class _PopMenuState extends State<PopMenu> {
  bool isLoading = false;

  void removePatient(BuildContext context) async {
    await Provider.of<DatabaseHelper>(context, listen: false)
        .deleteRecord(widget.patientId);
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      onSelected: (value) {
        if (value == 'Delete') {
          removePatient(context);
        } else {
          Navigator.of(context).pushNamed(EditPatientRecordScreen.routeName,
              arguments: widget.patientId);
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
