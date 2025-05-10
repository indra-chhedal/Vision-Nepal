import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white10,
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
                "Indra Chhedal",
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
                onPressed: () {},
              ),
              SizedBox(width: 15),
              IconButton(
                icon: Icon(Icons.logout, color: Colors.red, size: 30),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),

      body: Column(
        children: [
          Expanded(child: Container()),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Your Message Here",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
