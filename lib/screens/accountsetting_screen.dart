import 'package:bca_project/screens/passwordchange_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountsettingScreen extends StatefulWidget {
  const AccountsettingScreen({super.key});

  @override
  State<AccountsettingScreen> createState() => _ChangepasswordScreenState();
}

class _ChangepasswordScreenState extends State<AccountsettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.accountSetting), elevation: 1),
      body: Card(
        color: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return PasswordchangeScreen();
                  },
                ),
              );
            },
            child: ListTile(
              leading: Icon(Icons.lock),
              title: Text(
                AppLocalizations.of(context)!.changePassword,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                AppLocalizations.of(context)!.changePasswordtext,
                style: TextStyle(fontSize: 13),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
        ),
      ),
    );
  }
}
