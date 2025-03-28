import 'package:flutter/material.dart';
import 'package:vigorushealthcaretest/views/screens/reports/report_screen.dart';

import '../addmedicine/medicince_screen.dart';
import 'widget/home_screen_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    _screens = [HomeScreenWidget(), MedicinceScreen(), ReportScreen()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[selectedIndex],
      floatingActionButton: SizedBox(
        height: 100,
        width: 100,
        child: FloatingActionButton(
          shape: CircleBorder(),
          onPressed: () {
            setState(() {
              selectedIndex = 1; // Navigate to Add Medicine screen
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 30,
            ),
            IconButton(
              icon: Icon(
                Icons.home_outlined,
                size: 35,
              ),
              onPressed: () {
                setState(() {
                  selectedIndex = 0; // Navigate to Home screen
                });
              },
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(
                Icons.schedule_outlined,
                size: 35,
              ),
              onPressed: () {
                setState(() {
                  selectedIndex = 2; // Navigate to Report screen
                });
              },
            ),
            SizedBox(
              width: 30,
            ),
          ],
        ),
      ),
    );
  }
}
