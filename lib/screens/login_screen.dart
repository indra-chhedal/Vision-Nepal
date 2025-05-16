import 'dart:convert';

import 'package:bca_project/core/api_constant.dart';
import 'package:bca_project/screens/home_screen.dart';
import 'package:bca_project/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool ispasswordObsecured = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 80),
                Text(
                  AppLocalizations.of(context)!.login,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 220),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: AppLocalizations.of(context)!.username),
                  validator: (String? value) {
                    if (value == null) {
                      return "Username is required";
                    }
                    if (value.isEmpty) {
                      return "username is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  obscureText: ispasswordObsecured,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.passwrod,
                    suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          ispasswordObsecured = !ispasswordObsecured;
                        });
                        // debugPrint("success login");
                      },
                      icon: Icon(
                        ispasswordObsecured
                            ? Icons.remove_red_eye
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    }
                    if (value.length <= 8) {
                      return "password must be grater then 8 characters.";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 50),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      bool isValid = _formKey.currentState!.validate();
                      if (isValid) {
                        final loginUri = Uri.parse(
                          "http://10.0.2.2:1337/api/auth/local", //${ApiConstant.apiBaseUrl}api/auth/local this is use for port forwarding
                        );

                        http.Response response = await http.post(
                          loginUri,
                          body: {
                            "identifier": _usernameController.text,
                            "password": _passwordController.text,
                          },
                        );
                        if (response.statusCode == 200) {
                          Map<String, dynamic> responseData = jsonDecode(
                            response.body,
                          );
                          String token = responseData['jwt'];
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setString("token", token);

                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) {
                                return HomeScreen();
                              },
                            ),
                          );
                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.success(message: "Login Successful"),
                          );
                        }
                        if (response.statusCode == 400) {
                          final decodedResult = jsonDecode(response.body);
                          final message = decodedResult['error']['message'];
                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.error(message: message),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(AppLocalizations.of(context)!.login),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.noAccount,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 5),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) {
                              return RegisterScreen();
                            },
                          ),
                          (value) {
                            return false;
                          },
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.signup,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
