// import 'package:flutter/material.dart';
//
// class Utility{
//   Form _signUpFormFunction() {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           TextFormField(
//             validator: (value) {
//               if (value == '') {
//                 return 'Please enter your name,';
//               }
//               return null;
//             },
//             decoration: const InputDecoration(
//               label: Text('Username'),
//               border: OutlineInputBorder(),
//             ),
//             onSaved: (value) {
//               setState(() {
//                 _authDataSignUp['userName'] = value!;
//               });
//             },
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           TextFormField(
//             validator: (value) {
//               if (value!.endsWith('.com') && value.contains('@')) {
//                 return null;
//               }
//               return 'Enter valid email.';
//             },
//             decoration: const InputDecoration(
//               label: Text('Email'),
//               border: OutlineInputBorder(),
//             ),
//             onSaved: (value) {
//               setState(() {
//                 _authDataSignUp['email'] = value!;
//               });
//             },
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           TextFormField(
//             validator: (value) {
//               if (value!.length != 15 || !value.contains('-')) {
//                 return 'Please enter correct CNIC eg 17302-7654398-9';
//               }
//               return null;
//             },
//             decoration: const InputDecoration(
//               label: Text('CNIC'),
//               border: OutlineInputBorder(),
//             ),
//             onSaved: (value) {
//               setState(() {
//                 _authDataSignUp['cnic'] = value!;
//               });
//             },
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           Container(
//             alignment: Alignment.center,
//             height: 55,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: Colors.amberAccent,
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(color: Colors.amber, width: 2),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Text(
//                   _authDataSignUp['age'] == null
//                       ? 'No age chosen yet'
//                       : 'Age: ${_authDataSignUp["age"]}',
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 TextButton(
//                   onPressed: _pickedAge,
//                   child: const Text('Select age'),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           SelectRole(_authDataSignUp['role']!),
//           const SizedBox(
//             height: 10,
//           ),
//           TextFormField(
//             controller: passwordController,
//             validator: (value) {
//               if (value!.length < 7 || value.isEmpty) {
//                 return 'Please enter correct password';
//               }
//               return null;
//             },
//             decoration: const InputDecoration(
//               label: Text('New Password'),
//               border: OutlineInputBorder(),
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           TextFormField(
//             validator: (value) {
//               if (value != passwordController.text) {
//                 return 'Password does not match.';
//               } else if (value!.isEmpty) {
//                 return 'Please enter password';
//               }
//               return null;
//             },
//             decoration: const InputDecoration(
//               label: Text('Confirm Password'),
//               border: OutlineInputBorder(),
//             ),
//             onSaved: (value) {
//               setState(() {
//                 _authDataSignUp['password'] = value!;
//               });
//             },
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           isSignUp == false
//               ? ElevatedButton(
//             onPressed: _submitSignUp,
//             child: const Text('submit'),
//           )
//               : const CircularProgressIndicator(),
//         ],
//       ),
//     );
//   }




// void _pickedAge() {
//   showDatePicker(
//     context: context,
//     initialDate: DateTime(1960),
//     firstDate: DateTime(1960),
//     lastDate: DateTime.now(),
//   ).then((age) {
//     if (age == null) {
//       return;
//     }
//     setState(() {
//       _selectAge = DateFormat.yMd().format(age);
//       _authDataSignUp['age'] = _selectAge!;
//     });
//   });
// }