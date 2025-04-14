import 'package:complaint_web/responsive/responsive_screen.dart';
import 'package:complaint_web/widgets/complaintListView.dart';
import 'package:complaint_web/widgets/filterrow.dart';
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
        backgroundColor: const Color.fromARGB(226, 10, 71, 120),
        title: Row(
          children: [
            const Text(
              "Pharmaplast Complaint System",
              style: TextStyle(color: Colors.white),
            ),
            const Spacer(), // Pushes the title to the right
            ElevatedButton(
              onPressed: () {
                // Add your action here
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
