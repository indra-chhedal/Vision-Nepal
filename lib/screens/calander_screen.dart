import 'dart:async';

import 'package:bca_project/screens/date_translation.dart';
import 'package:bca_project/widgets/drawer_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CalanderScreen extends StatefulWidget {
  const CalanderScreen({super.key});

  @override
  State<CalanderScreen> createState() => _CalanderScreenState();
}

class _CalanderScreenState extends State<CalanderScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late Timer _timer;
  String _currentTime = '';

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _updateTime();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }

  void _updateTime() {
    final now = DateTime.now();
    setState(() {
      _currentTime = DateFormat('hh:mm:ss a').format(now);
      _focusedDay = now;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final today = DateFormat('EEEE, MMMM d, y').format(DateTime.now());

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: SafeArea(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 18 / 9,
                  child: Image.network(
                    "https://picsum.photos/200",
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  today,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  _currentTime,
                  style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                ),
                SizedBox(height: 15),
                Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: TableCalendar(
                        firstDay: DateTime.utc(2020, 1, 1),
                        lastDay: DateTime.utc(2030, 12, 31),
                        focusedDay: _focusedDay,
                        selectedDayPredicate:
                            (day) => isSameDay(_selectedDay, day),
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  child: Text(
                    "Our Services",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
                DrawerIcons(
                  icons: Icons.calendar_month,
                  title: AppLocalizations.of(context)!.dateTranslation,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return DateTranslation();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 8),
                DrawerIcons(
                  icons: Icons.sticky_note_2,
                  title: AppLocalizations.of(context)!.writeNote,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
