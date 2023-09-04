import 'dart:convert';

import 'package:flutter/cupertino.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hffl_zapisnik/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? userName;
  String? password;
  bool loading = false;
  bool _rememberMe = false;
  // final storage = FlutterSecureStorage();

  Future<void> LoginWithEmail() async {
    final _prefs = await SharedPreferences.getInstance();
    final scaffoldContext = context;
    var url = Uri.https('hfflzapisnik.azurewebsites.net', '/Login');
    Map body = {
      'username': _userNameController.text,
      'password': _passwordController.text
    };

    http.Response response = await http.post(url, body: jsonEncode(body));
    if (response.statusCode == 200) {}
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        // Authentication successful
        // final token = jsonDecode(response.body)['token']; // Adjust this to your response structure
        // await storage.write(key: 'authToken', value: token);

        // Navigate to the next screen or perform other actions upon successful login
        await _prefs.setBool('isLoggedIn', true);
        print("probjera prefsa za login" +
            _prefs.getBool('isLoggedIn').toString());
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(
              title: 'HFFL zapisnik Admin',
              isLoggedIn: true, // Set isLoggedIn to true after successful login
            ),
          ),
        );
      } else {
        // Authentication failed
        showDialog(
          context: scaffoldContext,
          builder: (context) {
            return AlertDialog(
              title: Text('Login Failed'),
              content: Text('Invalid username or password.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Handle network errors or other exceptions
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _userNameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true, // Hides the password
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Call the login function when the button is pressed
                LoginWithEmail();
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
