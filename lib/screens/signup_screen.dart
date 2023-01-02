// // ignore_for_file: prefer_final_fields
//
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// // import 'package:travel_app/screens/home_screen.dart';
//
// import '../providers/user_provider.dart';
// import '../widgets/select_role.dart';
//
// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({Key? key}) : super(key: key);
//   static const routeName = '/sign-up';
//
//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   final _formKey = GlobalKey<FormState>();
//   var isSignUp = false;
//   final passwordController = TextEditingController();
//
//   Map<String, String> _authData = {
//     'userName': '',
//     'email': '',
//     'cnic': '',
//     'age': '',
//     'role': 'Passenger',
//     'password': '',
//   };
//   String? _selectAge;
//
//   @override
//   Widget build(BuildContext context) {
//     print('build running in signUp');
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
//       final auth = Provider.of<Auth>(context, listen: false);
//       if (!_formKey.currentState!.validate()) {
//         return;
//       }
//       _formKey.currentState!.save();
//       setState(() {
//         isSignUp = true;
//       });
//       try {
//         await auth
//             .signup(_authData['email']!, _authData['password']!)
//             .then((_) async {
//           // Navigator.of(context).popAndPushNamed(MyHomePage.routeName);
//           await auth.addUserData(_authData);
//         });
//       } catch (error) {
//         _showErrorDialog(error.toString());
//       }
//       setState(() {
//         isSignUp = false;
//       });
//     }
//
//     void _pickedAge() {
//       showDatePicker(
//         context: context,
//         initialDate: DateTime(1960),
//         firstDate: DateTime(1960),
//         lastDate: DateTime.now(),
//       ).then((age) {
//         if (age == null) {
//           return;
//         }
//         setState(() {
//           _selectAge = DateFormat.yMd().format(age);
//           _authData['age'] = _selectAge!;
//         });
//       });
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Sign Up'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(10),
//           child: SingleChildScrollView(
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   TextFormField(
//                     validator: (value) {
//                       if (value == '') {
//                         return 'Please enter your name,';
//                       }
//                       return null;
//                     },
//                     decoration: const InputDecoration(
//                       label: Text('Username'),
//                       border: OutlineInputBorder(),
//                     ),
//                     onSaved: (value) {
//                       setState(() {
//                         _authData['userName'] = value!;
//                       });
//                     },
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   TextFormField(
//                     validator: (value) {
//                       if (value!.endsWith('.com') && value.contains('@')) {
//                         return null;
//                       }
//                       return 'Enter valid email.';
//                     },
//                     decoration: const InputDecoration(
//                       label: Text('Email'),
//                       border: OutlineInputBorder(),
//                     ),
//                     onSaved: (value) {
//                       setState(() {
//                         _authData['email'] = value!;
//                       });
//                     },
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   TextFormField(
//                     validator: (value) {
//                       if (value!.length != 15 || !value.contains('-')) {
//                         return 'Please enter correct CNIC eg 17302-7654398-9';
//                       }
//                       return null;
//                     },
//                     decoration: const InputDecoration(
//                       label: Text('CNIC'),
//                       border: OutlineInputBorder(),
//                     ),
//                     onSaved: (value) {
//                       setState(() {
//                         _authData['cnic'] = value!;
//                       });
//                     },
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     alignment: Alignment.center,
//                     height: 55,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: Colors.amberAccent,
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(color: Colors.amber, width: 2),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Text(
//                           _authData['age'] == null
//                               ? 'No age chosen yet'
//                               : 'Age: ${_authData["age"]}',
//                           style: const TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         TextButton(
//                           onPressed: _pickedAge,
//                           child: const Text('Select age'),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   SelectRole(_authData['role']!),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   TextFormField(
//                     controller: passwordController,
//                     validator: (value) {
//                       if (value!.length < 7 || value.isEmpty) {
//                         return 'Please enter correct password';
//                       }
//                       return null;
//                     },
//                     decoration: const InputDecoration(
//                       label: Text('New Password'),
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   TextFormField(
//                     validator: (value) {
//                       if (value != passwordController.text) {
//                         return 'Password does not match.';
//                       } else if (value!.isEmpty) {
//                         return 'Please enter password';
//                       }
//                       return null;
//                     },
//                     decoration: const InputDecoration(
//                       label: Text('Confirm Password'),
//                       border: OutlineInputBorder(),
//                     ),
//                     onSaved: (value) {
//                       setState(() {
//                         _authData['password'] = value!;
//                       });
//                     },
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   isSignUp == false
//                       ? ElevatedButton(
//                           onPressed: _submit,
//                           child: const Text('submit'),
//                         )
//                       : const CircularProgressIndicator(),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
