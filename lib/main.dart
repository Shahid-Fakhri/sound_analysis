// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/login_signup.dart';
import 'widgets/bottom_navigation_bar.dart';
import './providers/user_provider.dart';
import './screens/patient_form_screen.dart';
import './screens/patient_screen.dart';
import './screens/home_screen.dart';
import './screens/about.dart';
import './screens/edit_patient_record_screen.dart';
import './screens/patient_detail_screen.dart';
import './recording_data/sound_recorder.dart';
// import './services/database.dart' as db;

// db.DatabaseHelper dbHelper = db.DatabaseHelper();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // dbHelper.deleteDatabase();
  print('main.......');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Sound Analysis app',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.deepPurple,
            colorScheme: const ColorScheme.light(secondary: Colors.amberAccent),
          ),
          // home: const BottomNavigationBarScreen(),
          home: auth.isAuth
              ? BottomNavigationBarScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, snapShot) =>
                      snapShot.connectionState == ConnectionState.waiting
                          ? const CircularProgressIndicator()
                          : AuthScreen(),
                ),
          routes: {
            AboutScreen.routeName: (ctx) => AboutScreen(),
            BottomNavigationBarScreen.routeName: (ctx) =>
                BottomNavigationBarScreen(),
            MyHomePage.routeName: (ctx) => const MyHomePage(),
            PatientScreen.routeName: (ctx) => const PatientScreen(),
            PatientFormScreen.routeName: (ctx) => const PatientFormScreen(),
            PatientDetailScreen.routeName: (ctx) => const PatientDetailScreen(),
            EditPatientRecordScreen.routeName: (ctx) =>
                const EditPatientRecordScreen(),
            SoundRecorderScreen.routeName: (ctx) => SoundRecorderScreen(),
          },
        ),
      ),
    );
  }
}
