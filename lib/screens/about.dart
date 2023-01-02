import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class AboutScreen extends StatefulWidget {
  static const routeName = '/about';

  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    final authPro = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: SizedBox(
                height: 200,
                width: 170,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      child: const Icon(Icons.person, size: 95),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'UserName',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(onPressed: (){
              authPro.logout();
            }, child: const Text('Logout'), ),
          ],
        ),
      ),
    );
  }
}
