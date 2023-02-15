import 'package:flutter/material.dart';
import '../screens/edit_patient_record_screen.dart';
import '../services/database.dart' as db;

class PopMenu extends StatefulWidget {
  final String patientId;

  const PopMenu(this.patientId, {Key key}) : super(key: key);

  @override
  State<PopMenu> createState() => _PopMenuState();
}

class _PopMenuState extends State<PopMenu> {
  db.DatabaseHelper dbHelper = db.DatabaseHelper();
  bool isLoading = false;

  void removePatient() async {
    final res = await dbHelper.deleteRecord(widget.patientId);
    if (res != 0) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      onSelected: (value) {
        if (value == 'Delete') {
          removePatient();
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
