import 'package:flutter/material.dart';

class AddRecordingScreen extends StatelessWidget {
  static const routeName = '/add-recording';
  const AddRecordingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Recording'),
      ),
      body: const Center(
        child: Text('Recording'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
