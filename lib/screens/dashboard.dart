import 'package:complaint_web/responsive/responsive_screen.dart';
import 'package:complaint_web/screens/login.dart';
import 'package:complaint_web/shared_preferences/storage_token.dart';
import 'package:complaint_web/widgets/complaintListView.dart';
import 'package:complaint_web/widgets/filterrow.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

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
        backgroundColor: const Color.fromARGB(226, 10, 71, 120),
        title: Row(
          children: [
            const Text(
              "Pharmaplast Complaint System",
              style: TextStyle(color: Colors.white),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.refresh,color: Colors.blue,),
              tooltip: 'Reset Filters',
              onPressed: () {
                html.window.location.reload(); // 🔁 Refresh the page
              },
            ),
            const SizedBox(width:12 ),
            ElevatedButton(
              onPressed: () async {
                await TokenStorage.clearToken();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: Text('Log Out'),
            ),
          ],
        ),
      ),

      body: ResponsiveScreen(
        mobile: _buildMobileDashboard(),
        tablet: _buildTabletDashboard(),
        desktop: _buildDesktopDashboard(),
      ),
    );
  } // Empty ListView
}

Widget _buildMobileDashboard() {
  return Column(
    children: [ResponsiveFilterRow(), Expanded(child: ComplaintListView())],
  );
}

Widget _buildTabletDashboard() {
  return Column(
    children: [ResponsiveFilterRow(), Expanded(child: ComplaintListView())],
  );
}

Widget _buildDesktopDashboard() {
  return Column(
    children: [ResponsiveFilterRow(), Expanded(child: ComplaintListView())],
  );
}
