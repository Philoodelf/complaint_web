import 'package:complaint_web/cubit/usercubit.dart';
import 'package:complaint_web/cubit/userstate.dart';
import 'package:complaint_web/model/complaints_model.dart';
import 'package:complaint_web/responsive/responsive_screen.dart';
import 'package:complaint_web/screens/login.dart';
import 'package:complaint_web/shared_preferences/storage_token.dart';
import 'package:complaint_web/widgets/complaintListView.dart';
import 'package:complaint_web/widgets/filterrow.dart';
import 'package:complaint_web/widgets/pagination.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

import 'package:flutter_bloc/flutter_bloc.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late int noOfItems;
  int selectedNoOfItems = 20;
  int currentPage = 1; // Track the current page
  int totalPages =
      1; // Track the total number of pages (could be dynamically updated)
  List<Complaint> complaints = []; // Store the fetched complaints

  // @override
  // void initState() {
  //   super.initState();
  //   fetchComplaints(pageNo: currentPage);  // Fetch initial complaints
  // }

  // Future<void> fetchComplaints({int pageNo = 1}) async {
  //   await context.read<UserCubit>().fetchComplaints(pageNo: pageNo);
  //   setState(() {
  //     complaints = context.read<UserCubit>().state.complaints;
  //     totalPages = context.read<UserCubit>().state.totalPages;  // Update total pages
  //   });
  // }

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
              icon: const Icon(Icons.refresh, color: Colors.blue),
              tooltip: 'Reset Filters',
              onPressed: () {
                html.window.location.reload(); // 🔁 Refresh the page
              },
            ),
            const SizedBox(width: 12),
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
  }

  Widget _buildMobileDashboard() {
    return Column(
      children: [
        ResponsiveFilterRow(),
        Expanded(child: ComplaintListView()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Items per page dropdown
              Row(
                children: [
                  const Text("Items per page: "),
                  const SizedBox(width: 8),
                  DropdownButton<int>(
                    value: selectedNoOfItems,
                    items:
                        [10, 20, 50, 100].map((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(value.toString()),
                          );
                        }).toList(),
                    onChanged: (int? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedNoOfItems = newValue;
                          currentPage = 1;
                        });

                        context.read<UserCubit>().fetchComplaints(
                          pageNo: currentPage,
                          noOfItems: selectedNoOfItems,
                        );
                      }
                    },
                  ),
                ],
              ),

              // Pagination
              Pagination(
                fromDate: null,
                toDate: null,
                selectedCategoryId: null,
                searchQuery: null,
                noOfItems: selectedNoOfItems,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabletDashboard() {
    return Column(
      children: [
        ResponsiveFilterRow(),
        Expanded(child: ComplaintListView()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Items per page dropdown
              Row(
                children: [
                  const Text("Items per page: "),
                  const SizedBox(width: 8),
                  DropdownButton<int>(
                    value: selectedNoOfItems,
                    items:
                        [10, 20, 50, 100].map((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(value.toString()),
                          );
                        }).toList(),
                    onChanged: (int? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedNoOfItems = newValue;
                          currentPage = 1;
                        });

                        context.read<UserCubit>().fetchComplaints(
                          pageNo: currentPage,
                          noOfItems: selectedNoOfItems,
                        );
                      }
                    },
                  ),
                ],
              ),

              // Pagination
              Pagination(
                fromDate: null,
                toDate: null,
                selectedCategoryId: null,
                searchQuery: null,
                noOfItems: selectedNoOfItems,
              ),
            ],
          ),
        ),
      ],
    );
  }

  //is working
  //   Widget _buildMobileDashboard() {
  //   return Column(
  //     children: [
  //       ResponsiveFilterRow(),
  //       Expanded(child: ComplaintListView()),
  //       Pagination(),
  //     ],
  //   );
  // }

  //is working
  //   Widget _buildTabletDashboard() {

  //   return Column(
  //     children: [
  //       ResponsiveFilterRow(),
  //       Expanded(child: ComplaintListView()),
  //       Pagination(),
  //     ],
  //   );
  // }
  Widget _buildDesktopDashboard() {
    return Column(
      children: [
        ResponsiveFilterRow(),
        Expanded(child: ComplaintListView()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Text("Items per page: "),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 80, 
                    height: 40,
                    child: DropdownButton<int>(
                      isExpanded: true, 
                      value: selectedNoOfItems,
                      items:
                          [10, 20, 50, 100].map((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                      onChanged: (int? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedNoOfItems = newValue;
                            currentPage = 1; // reset to first page
                          });

                          context.read<UserCubit>().fetchComplaints(
                            pageNo: currentPage,
                            noOfItems: selectedNoOfItems,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),

              
              Pagination(
                fromDate: null,
                toDate: null,
                selectedCategoryId: null,
                searchQuery: null,
                noOfItems: selectedNoOfItems,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
// Widget _buildDashboardLayout(UserLoaded state) {
//     return Column(
//       children: [
//         const ResponsiveFilterRow(),
//         Expanded(child: ComplaintListView(Complaints: state.complaints)),
//         Pagination(
//           totalPages: state.totalPages,
//           onPageChanged: (pageNo) {
//             context.read<UserCubit>().fetchComplaints(
//               pageNo: pageNo,
//               noOfItems: 20,
//               typeComplaintId: state.selectedCategory,
//             );
//           },
//         ),
//       ],
//     );
//   }





//  Widget _buildDesktopDashboard() {
//     return Column(
//       children: [
//         ResponsiveFilterRow(),
//         Expanded(child: ComplaintListView()),
//         Pagination(
//           totalPages: totalPages,
//           onPageChanged: (int page) {
//             setState(() {
//               currentPage = page;
//             });
//             fetchComplaints(pageNo: page);  // Fetch complaints for the selected page
//           },
//         ),
//       ],
//     );
//   }




// is working

// Widget _buildDesktopDashboard() {
//   return Column(
//     children: [
//       ResponsiveFilterRow(),
//       Expanded(child: ComplaintListView()),
//       Pagination(
//         //noOfItems: noOfItems,
//   //       fromDate: fromDate,
//   // toDate: toDate,
//   // selectedCategoryId: selectedCategory,
//   // searchQuery: searchController.text,
//   )
//     ],
//   );
// }



