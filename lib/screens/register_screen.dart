import 'dart:convert';

import 'package:bca_project/core/api_constant.dart';
import 'package:bca_project/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //if constant variable define garnu xa vani hamla chai final keyword rakhana parxa
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwrodController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool ispasswordObsecured =
      true; //password obsecured garna ko lagi variable define garako

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwrodController.dispose();
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
                SizedBox(height: 100),
                Text(
                  "SignUP",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 50),

                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: "UserName"),
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
                  controller: _emailController,
                  decoration: InputDecoration(labelText: "Email"),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }
                    String p =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regExp = RegExp(p);
                    if (!regExp.hasMatch(value)) {
                      return "your email is not valid";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  obscureText: ispasswordObsecured,
                  controller:
                      _passwrodController, //give the detail of textfield
                  decoration: InputDecoration(
                    labelText: "Password",
                    suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          //if eye button ma click garda state change hunxa tasila setstate function rakhyako
                          ispasswordObsecured =
                              !ispasswordObsecured; //tuggle event occured
                        });
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
                    if (value.length < 8) {
                      return "Password must be grater then 8 characters.";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 60),

                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      bool isValid =
                          _formKey.currentState!
                              .validate(); //null hudina vanara !sign rakhyako/currentstate null hunna
                      if (isValid) {
                        //yasma chai yadi _formkey valid xa vanya form ma vako data haru talako string variable ma store hunxa
                        String username = _usernameController.text;
                        String email = _emailController.text;
                        String password = _passwrodController.text;

                        final registerUrl = Uri.parse(
                          "http://10.0.2.2:1337/api/auth/local/register",
                        ); //android immulator ma chai localhost ko place ma 10.0.2.2 rakhna parxa ani balla hamro form ko data api ma janxa
                        http.Response responce = await http.post(
                          registerUrl,
                          body: {
                            "username": username,
                            "password": password,
                            "email": email,
                          }, //yasma registerurl vanako positional parameter ani user name haru named parameter jun ko position la farak pardina
                        );
                        if (responce.statusCode == 200) {
                          // debugPrint("success");
                          showTopSnackBar(
                            //snack bar add garna ko lagi top_sncak_flutter package import garyo ani yo  chai message display garauna ko lagi use hunxa in short time.
                            Overlay.of(context),
                            CustomSnackBar.success(
                              message: "User Registered Successfully",
                            ),
                          );
                          // Navigator.of(context).pop();

                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) {
                          //       return LoginScreen();
                          //     },
                          //   ),
                          // );
                          Navigator.of(context).pushReplacement(
                            //push replacement la chai pahila ko screen lai stack bta replace garyara naya screen open garxa
                            MaterialPageRoute(
                              builder: (context) {
                                return LoginScreen();
                              },
                            ),
                          );
                        }
                        if (responce.statusCode == 400) {
                          final decodedData = jsonDecode(
                            responce.body,
                          ); //yasma chai data decode garako body bta jun postman ma rakhya xa body ko data if error aayo vani
                          final message =
                              decodedData["error"]["message"]; //map format ma vako data lai access garako

                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.error(message: message),
                          );
                        }
                      }
                    },
                    child: Text("SignUp"),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Do you have account ?",
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
                              return LoginScreen();
                            },
                          ),
                          (value) {
                            return false;
                          },
                        );
                      },
                      child: Text(
                        "Login",
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
