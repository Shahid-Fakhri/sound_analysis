// ignore_for_file: prefer_final_fields
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryTime;
  String? _userId;
  Timer? _authTimer;
  String? userName;

  bool get isAuth {
    return _token != null;
  }

  String? get getToken {
    if (_expiryTime != null &&
        _expiryTime!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token!;
    }
    return null;
  }

  String? get userId => _userId;

  Future<void> _authenticate(
    String email,
    String password,
    String urlSegment,
  ) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyDmak3lHXWpsgVVlhp5Au1Xp25KKe0FyBw';
    try {
      final request = await http.post(
        Uri.parse(url),
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      final responseData = json.decode(request.body);
      if (responseData['error'] != null) {
        throw responseData['error']['message'];
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryTime = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData['expiresIn']),
        ),
      );
      _autoLogout();
      notifyListeners();
      final smallStorage = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryTime!.toIso8601String(),
      });
      smallStorage.setString('userData', userData);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> addUserData(Map<String, String> userData) async {
    final url =
        'https://ncia-project-travel-app-default-rtdb.firebaseio.com/userCredential.json?auth=$_token';
    try {
      await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'userName': userData['userName'],
            'email': userData['email'],
            'password': userData['password'],
          },
        ),
      );
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  bool isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  Future<bool> tryAutoLogin() async {
    final smallStorage = await SharedPreferences.getInstance();
    if (!smallStorage.containsKey('userData')) {
      return false;
    }
    final extractData = json.decode(smallStorage.getString('userData')!)
        as Map<String, dynamic>;

    final expiryDate = DateTime.parse(extractData['expiryDate'] as String);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _expiryTime = expiryDate;
    _token = extractData['token'];
    _userId = extractData['userId'];
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryTime = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
    // prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpiry = _expiryTime?.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry!), logout);
  }
}
