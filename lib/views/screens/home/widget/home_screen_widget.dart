import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({super.key});

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<String> dates = [];
  List<String> medicines = []; // Empty list to simulate no medicines

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    _generateDates();
  }

  void _generateDates() {
    DateTime now = DateTime.now();
    for (int i = -3; i <= 3; i++) {
      dates.add(DateFormat('EEE, MMM d').format(now.add(Duration(days: i))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            Text('Hi, User'),
            Text('Hi, User'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: dates.map((date) => Tab(text: date)).toList(),
          ),
          Expanded(
            child: medicines.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    itemCount: medicines.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(medicines[index]),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.medication, size: 80, color: Colors.grey),
          SizedBox(height: 20),
          Text(
            'Nothing is Here',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text('Add a medicine.', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
