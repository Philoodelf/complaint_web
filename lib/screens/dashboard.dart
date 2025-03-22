import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My App",
          style: TextStyle(color: Colors.white), // White text color
        ),
        backgroundColor: Colors.blue, // Blue background
        centerTitle: true, // Center the title
      ),
      body: ListView(), // Empty ListView
    );
  }
}
