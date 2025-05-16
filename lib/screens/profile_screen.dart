import 'dart:convert';

import 'package:bca_project/models/login.dart';
import 'package:bca_project/screens/accountsetting_screen.dart';
import 'package:bca_project/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.user});

  final Login user;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendEmail() async {
    final String message = _messageController.text;
    final emailUrl = Uri(
      scheme: 'mailto',
      path: 'chhedalindra@gmail.com',
      queryParameters: {'subject': 'message from flutter app', 'body': message},
    );
    // debugPrint("url is $emailUrl");
    if (await canLaunchUrl(emailUrl)) {
      await launchUrl(emailUrl);
    } else {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(message: "Url is Not Present"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,

        flexibleSpace: Padding(
          padding: EdgeInsets.fromLTRB(16, 40, 16, 10),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey.shade400,
                radius: 20,
                child: Icon(Icons.account_box),
              ),
              SizedBox(width: 20),
              Text(
                widget.user.username,
                style: TextStyle(color: Colors.brown[800], fontSize: 16),
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.fiber_manual_record, color: Colors.red),
                onPressed: () {},
              ),
              SizedBox(width: 15),
              IconButton(
                icon: Icon(Icons.settings, color: Colors.brown[800], size: 30),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return AccountsettingScreen();
                      },
                    ),
                  );
                },
              ),
              SizedBox(width: 15),
              IconButton(
                icon: Icon(Icons.logout, color: Colors.red, size: 30),
                onPressed: () async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.remove("token");
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
              ),
            ],
          ),
        ),
      ),

      body: Column(
        children: [
          Expanded(child: Container()),
          Container(
            height: 120,
            padding: EdgeInsets.fromLTRB(5, 5, 5, 30),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    minLines: 3,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.messageHere,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                InkWell(
                  onTap: _sendEmail,
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.deepPurple,
                    ),
                    child: Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
