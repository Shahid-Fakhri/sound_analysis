// // ignore_for_file: prefer_final_fields
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../providers/user_provider.dart';
// import './home_screen.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);
//   static const routeName = '/login';
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   bool isLogin = false;
//   Map<String, String> _authData = {
//     'email': '',
//     'password': '',
//   };
//
//   @override
//   Widget build(BuildContext context) {
//     print('build running in login');
//     final authProvider = Provider.of<Auth>(
//       context,
//     );
//     void _showErrorDialog(String message) {
//       showDialog(
//         context: context,
//         builder: (ctx) => AlertDialog(
//           title: const Text('An Error Occurred!'),
//           content: Text(message),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Okay'),
//               onPressed: () {
//                 Navigator.of(ctx).pop();
//               },
//             )
//           ],
//         ),
//       );
//     }
//
//     Future<void> _submit() async {
//       if (!_formKey.currentState!.validate()) {
//         return;
//       }
//       _formKey.currentState!.save();
//       setState(() {
//         isLogin = true;
//       });
//       try {
//         await authProvider
//             .login(_authData['email']!, _authData['password']!);
//         //     .then((value) {
//         //   Navigator.of(context).pushAndRemoveUntil();
//         // });
//       } catch (error) {
//         _showErrorDialog(error.toString());
//       }
//       setState(() {
//         isLogin = false;
//       });
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               TextFormField(
//                 decoration: const InputDecoration(
//                   label: Text('Email'),
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (authProvider.isValidEmail(value!)) {
//                     return null;
//                   } else {
//                     return 'Enter valid email.';
//                   }
//                 },
//                 onSaved: (value) {
//                   setState(() {
//                     _authData['email'] = value!;
//                   });
//                 },
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   label: Text('Password'),
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value!.length >= 7 && value.isNotEmpty) {
//                     return null;
//                   } else {
//                     return 'Enter valid email.';
//                   }
//                 },
//                 onSaved: (value) {
//                   setState(() {
//                     _authData['password'] = value!;
//                   });
//                 },
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               isLogin == false
//                   ? ElevatedButton(
//                       onPressed: _submit,
//                       child: const Text('Login'),
//                     )
//                   : const Center(
//                       child: CircularProgressIndicator(),
//                     )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
