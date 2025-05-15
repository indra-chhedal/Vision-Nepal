import 'dart:convert';

import 'package:bca_project/models/login.dart';
import 'package:bca_project/screens/news_screen.dart';
import 'package:bca_project/screens/profile_screen.dart';
import 'package:bca_project/screens/videos_screen.dart';
import 'package:bca_project/widgets/dark_mode.dart';
import 'package:bca_project/widgets/drawer_icons.dart';
import 'package:bca_project/widgets/social_icons.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  Login? user;

  final List<Widget> _screens = [
    Center(child: Text("hello")),
    VideosScreen(),
    NewsScreen(),
  ];

  @override
  void initState() {
    userWelcome();
    super.initState();
  }

  void userWelcome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token == null) {
      return;
    }

    var url = Uri.parse("http://10.0.2.2:1337/api/users/me");
    http.Response response = await http.get(
      url,
      headers: {'Authorization': "Bearer $token"},
    );
    Map<String, dynamic> decodedResult = jsonDecode(response.body);
    Login data = Login.fromMap(decodedResult);
    
    setState(() {
      user = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        width: 350,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 60, 10, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.brown[100],
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("images/account.jpeg"),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Vision Nepal",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "visionnepal05@gmail.com",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, size: 20),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Card(
                elevation: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DrawerIcons(
                      icons: Icons.video_collection,
                      title: "Watch Video",
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return VideosScreen();
                            },
                          ),
                        );
                      },
                    ),
                    Divider(height: 1, thickness: 1, color: Colors.grey[300]),
                    DrawerIcons(
                      icons: Icons.newspaper_sharp,
                      title: "News Article",
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return NewsScreen();
                            },
                          ),
                        );
                      },
                    ),
                    Divider(height: 1, thickness: 1, color: Colors.grey[300]),
                    DrawerIcons(
                      icons: Icons.message,
                      title: "Send Message",
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return ProfileScreen(user: user!);
                            },
                          ),
                        );
                      },
                    ),
                    Divider(height: 1, thickness: 1, color: Colors.grey[300]),
                    DrawerIcons(
                      icons: Icons.calendar_month,
                      title: "Nepali Calendar",
                      onTap: () {},
                    ),
                    Divider(height: 1, thickness: 1, color: Colors.grey[300]),
                    DrawerIcons(
                      icons: Icons.calendar_today,
                      title: "Date Translation",
                      onTap: () {},
                    ),
                    Divider(height: 1, thickness: 1, color: Colors.grey[300]),
                    DrawerIcons(
                      icons: Icons.sticky_note_2,
                      title: "Write Note",
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),

              DarkMode(),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 5,
                children: [
                  SocialIcons(
                    icons: Icons.facebook,
                    color: const Color.fromARGB(255, 48, 152, 237),
                    onTap: () {},
                  ),
                  SocialIcons(
                    icons: Icons.video_collection_outlined,
                    color: Colors.red,
                    onTap: () {},
                  ),
                  SocialIcons(
                    icons: Icons.tiktok,
                    color: Colors.black,
                    onTap: () {},
                  ),
                  SocialIcons(
                    icons: Icons.web_stories,
                    color: Colors.pinkAccent,
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text("Vision Nepal"),

        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      body: _screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.black,
        elevation: 2,

        currentIndex: currentIndex,
        onTap: (index) {
          if (index == 3 && user != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return ProfileScreen(user: user!);
                },
              ),
            );
          } else {
            setState(() {
              currentIndex = index;
            });
          }
        },

        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_collection),
            label: 'Video',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: 'News'),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
