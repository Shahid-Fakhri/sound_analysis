// ignore_for_file: prefer_final_fields, library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/login_signup.dart';
import '../providers/user_provider.dart';

class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;
  bool isLogin = false;
  bool isHidePass = true;
  bool isHideConfirmPass = true;
  var isSignUp = false;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  Map<String, String> _authDataSignUp = {
    'userName': '',
    'email': '',
    'password': '',
  };

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submitSignUp() async {
    final auth = Provider.of<Auth>(context, listen: false);
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState?.save();
    setState(() {
      isSignUp = true;
    });
    try {
      await auth
          .signup(_authDataSignUp['email']!, _authDataSignUp['password']!)
          .then((_) async {
        await auth.addUserData(_authDataSignUp);
      });
    } catch (error) {
      _showErrorDialog(error.toString());
    }
    setState(() {
      isSignUp = false;
    });
  }

  Future<void> _submitLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      isLogin = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false)
          .login(_authData['email']!, _authData['password']!);
    } catch (error) {
      _showErrorDialog(error.toString());
    }
    setState(() {
      isLogin = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _authMode == AuthMode.Login
                  ? _loginFormFunction(context)
                  : _signUpFormFunction(),
              SizedBox(
                height: 30,
                child: Center(
                  child: TextButton(
                    onPressed: _switchAuthMode,
                    child: const Text('Login/Signup'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Form _signUpFormFunction() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value == '') {
                return 'Please enter your name,';
              }
              return null;
            },
            decoration: const InputDecoration(
              label: Text('Username'),
              border: OutlineInputBorder(),
            ),
            onSaved: (value) {
              setState(() {
                _authDataSignUp['userName'] = value!;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: (value) {
              if (Provider.of<Auth>(context, listen: false)
                  .isValidEmail(value!)) {
                return null;
              } else {
                return 'Enter valid email.';
              }
            },
            decoration: const InputDecoration(
              label: Text('Email'),
              border: OutlineInputBorder(),
            ),
            onSaved: (value) {
              setState(() {
                _authDataSignUp['email'] = value!;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: passwordController,
            validator: (value) {
              if (value!.length < 7 || value.isEmpty) {
                return 'Please enter correct password';
              }
              return null;
            },
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  isHidePass == true
                      ? Icons.remove_red_eye
                      : Icons.remove_red_eye_outlined,
                ),
                onPressed: () {
                  setState(() {
                    isHidePass == true ? isHidePass = false : isHidePass = true;
                  });
                },
              ),
              label: const Text('New Password'),
              border: const OutlineInputBorder(),
            ),
            obscureText: isHidePass == true ? true : false,
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: (value) {
              if (value != passwordController.text) {
                return 'Password does not match.';
              } else if (value!.isEmpty) {
                return 'Please enter password';
              }
              return null;
            },
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  isHideConfirmPass == true
                      ? Icons.remove_red_eye
                      : Icons.remove_red_eye_outlined,
                ),
                onPressed: () {
                  setState(() {
                    isHideConfirmPass == true
                        ? isHideConfirmPass = false
                        : isHideConfirmPass = true;
                  });
                },
              ),
              label: const Text('Confirm Password'),
              border: const OutlineInputBorder(),
            ),
            obscureText: isHideConfirmPass == true ? true : false,
            onSaved: (value) {
              setState(() {
                _authDataSignUp['password'] = value!;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          isSignUp == false
              ? ElevatedButton(
                  onPressed: _submitSignUp,
                  child: const Text('submit'),
                )
              : const CircularProgressIndicator(),
        ],
      ),
    );
  }

  Form _loginFormFunction(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              label: Text('Email'),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (Provider.of<Auth>(context, listen: false)
                  .isValidEmail(value!)) {
                return null;
              } else {
                return 'Enter valid email.';
              }
            },
            onSaved: (value) {
              setState(() {
                _authData['email'] = value!;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  isHidePass == true
                      ? Icons.remove_red_eye
                      : Icons.remove_red_eye_outlined,
                ),
                onPressed: () {
                  setState(() {
                    isHidePass == true ? isHidePass = false : isHidePass = true;
                  });
                },
              ),
              label: const Text('Password'),
              border: const OutlineInputBorder(),
            ),
            obscureText: isHidePass == true ? true : false,
            validator: (value) {
              if (value!.length >= 7 && value.isNotEmpty) {
                return null;
              } else {
                return 'Enter valid email.';
              }
            },
            onSaved: (value) {
              setState(() {
                _authData['password'] = value!;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          isLogin == false
              ? ElevatedButton(
                  onPressed: _submitLogin,
                  child: const Text('Login'),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                )
        ],
      ),
    );
  }
}
