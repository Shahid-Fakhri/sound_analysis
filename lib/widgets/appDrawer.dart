// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 150,
      elevation: 5,
      backgroundColor: Colors.black87,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'UserName',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<Auth>(context, listen: false).logout();
              },
              child: const Text('logout'),
            ),
          ],
        ),
      ),
    );
  }
}
