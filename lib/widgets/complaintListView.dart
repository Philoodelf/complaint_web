import 'package:complaint_web/cubit/usercubit.dart';
import 'package:complaint_web/cubit/userstate.dart';
import 'package:complaint_web/model/complaints_model.dart';
import 'package:complaint_web/responsive/responsive_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComplaintListView extends StatefulWidget {
  // final int userId;
  const ComplaintListView({super.key});

  @override
  State<ComplaintListView> createState() => _ComplaintListViewState();
}

class _ComplaintListViewState extends State<ComplaintListView> {
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().fetchComplaints(
      // userId:391
    ); // No userId = get all complaints
  }

  String? _selectedType;

  List<Map<String, String?>> complaints = [
    {
      "serial": "001",
      "details": "Printer not working",
      "status": "Open",
      "type": "Hardware",
      "priority": "High",
      "submissionDate": "2025-03-25",
      "file": "Document.pdf",
      "assignedTo": "John",
    },
    {
      "serial": "002",
      "details": "Software crash",
      "status": null, // Example of missing status
      "type": "Software",
      "priority": "Medium",
      "submissionDate": "2025-03-24",
      "file": null, // Example of missing file
      "assignedTo": "Alex",
    },
    {
      "serial": "002",
      "details": "Software crash",
      "status": null, // Example of missing status
      "type": "Software",
      "priority": "Medium",
      "submissionDate": "2025-03-24",
      "file": null, // Example of missing file
      "assignedTo": "Alex",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ResponsiveScreen(
      mobile: _buildMobileListView(),
      tablet: _buildTabletListView(),
      desktop: _buildDesktopListView(),
    );
  }

  /// **Desktop View (Full Row Headers & Horizontal Layout)**
  // Widget _buildDesktopListView() {
  //   return Column(
  //     children: [
  //       _buildHeaderRow(),
  //       Expanded(
  //         child: ListView.builder(
  //           itemCount: complaints.length,
  //           itemBuilder: (context, index) {
  //             var complaint = complaints[index];
  //             return GestureDetector(
  //               onTap: () {
  //                 _showComplaintDetails(context, {
  //                   "serial": complaint["serial"] ?? "N/A",
  //                   "details": complaint["details"] ?? "N/A",
  //                   "status": complaint["status"] ?? "N/A",
  //                   "type": complaint["type"] ?? "N/A",
  //                   "priority": complaint["priority"] ?? "N/A",
  //                   "submissionDate": complaint["submissionDate"] ?? "N/A",
  //                   "file": complaint["file"] ?? "N/A",
  //                   "assignedTo": complaint["assignedTo"] ?? "N/A",
  //                 });
  //               },
  //               child: Card(
  //                 margin: const EdgeInsets.symmetric(
  //                   vertical: 4,
  //                   horizontal: 10,
  //                 ),
  //                 elevation: 3, // Adds a shadow effect
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                     children: [
  //                       Text("Complaint ${complaint['serial']}"),
  //                       Text(" ${complaint['details']}"),
  //                       Text(" ${complaint['status'] ?? "N/A"}"),
  //                       Text(" ${complaint['type']}"),
  //                       Text(" ${complaint['priority'] ?? "N/A"}"),
  //                       Text(" ${complaint['submissionDate']}"),
  //                       Text(" ${complaint['file'] ?? "N/A"}"),
  //                       Text(" ${complaint['assignedTo'] ?? "N/A"}"),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             );
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }
  Widget _buildDesktopListView() {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is PostLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is UserLoaded) {
          final complaints = state.complaints;

          if (complaints.isEmpty) {
            return const Center(child: Text("No complaints found."));
          }

          print("🧾 Complaints Loaded: ${complaints.length}");

          return Column(
            children: [
              _buildHeaderRow(),
              Expanded(
                child: ListView.builder(
                  itemCount: complaints.length,
                  itemBuilder: (context, index) {
                    final complaint = complaints[index];

                    return GestureDetector(
                      onTap: () {
                        _showComplaintDetails(context, {
                          "serial": complaint.serialNo ?? "N/A",
                          "details": complaint.description ?? "N/A",
                          "status": complaint.statusName ?? "N/A",
                          "type": complaint.typecomplaintName ?? "N/A",
                          "priority": complaint.priority?.toString() ?? "N/A",
                          "submissionDate": complaint.date ?? "N/A",
                          "file": complaint.attachComplaint ?? "N/A",
                          "assignedTo": complaint.assignTo ?? "N/A",
                        });
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 10,
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Complaint ${complaint.serialNo ?? 'N/A'}"),
                              Text("${complaint.description ?? ''}"),
                              Text("${complaint.statusName ?? 'N/A'}"),
                              Text("${complaint.typecomplaintName ?? ''}"),
                              Text("${complaint.priority ?? 'N/A'}"),
                              Text("${complaint.date ?? 'N/A'}"),
                              Text("${complaint.attachComplaint ?? 'N/A'}"),
                              Text("${complaint.assignTo ?? 'N/A'}"),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }

        if (state is UserError) {
          return Center(child: Text("Error: ${state.message}"));
        }

        return const SizedBox(); // Default empty view for UserInitial
      },
    );
  }

  /// **Tablet View (List with Card Layout)**
  // Widget _buildTabletListView() {
  //   return Column(
  //     children: [
  //       _buildHeaderRow(), // Add the header row
  //       Expanded(
  //         child: ListView.builder(
  //           itemCount: complaints.length,
  //           itemBuilder: (context, index) {
  //             var complaint = complaints[index];
  //             return GestureDetector(
  //               onTap: () {
  //                 _showComplaintDetails(context, {
  //                   "serial": complaint["serial"] ?? "N/A",
  //                   "details": complaint["details"] ?? "N/A",
  //                   "status": complaint["status"] ?? "N/A",
  //                   "type": complaint["type"] ?? "N/A",
  //                   "priority": complaint["priority"] ?? "N/A",
  //                   "submissionDate": complaint["submissionDate"] ?? "N/A",
  //                   "file": complaint["file"] ?? "N/A",
  //                   "assignedTo": complaint["assignedTo"] ?? "N/A",
  //                 });
  //               },
  //               child: Card(
  //                 margin: const EdgeInsets.symmetric(
  //                   vertical: 8,
  //                   horizontal: 16,
  //                 ),
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(12.0),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text("Complaint ${complaint['serial']}"),
  //                       Text(" ${complaint['details']}"),
  //                       Text(" ${complaint['status'] ?? "N/A"}"),
  //                       Text(" ${complaint['type']}"),
  //                       Text(" ${complaint['priority'] ?? "N/A"}"),
  //                       Text(" ${complaint['submissionDate']}"),
  //                       Text(" ${complaint['file'] ?? "N/A"}"),
  //                       Text(" ${complaint['assignedTo'] ?? "N/A"}"),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             );
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }
  Widget _buildTabletListView() {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        var cubit = context.read<UserCubit>();

        if (state is PostLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is UserLoaded) {
          final complaints = state.complaints;

          if (complaints.isEmpty) {
            return const Center(child: Text("No complaints found."));
          }

          print("🧾 Complaints Loaded: ${complaints.length}");

          return Column(
            children: [
              _buildHeaderRow(),
              Expanded(
                child: ListView.builder(
                  itemCount: complaints.length,
                  itemBuilder: (context, index) {
                    final complaint = complaints[index];
                    return GestureDetector(
                      onTap: () {
                        _showComplaintDetails(context, {
                          "serial": complaint.serialNo ?? "N/A",
                          "details": complaint.description ?? "N/A",
                          "status": complaint.statusName ?? "N/A",
                          "type": complaint.typecomplaintName ?? "N/A",
                          "priority": complaint.priority?.toString() ?? "N/A",
                          "submissionDate": complaint.date ?? "N/A",
                          "file": complaint.attachComplaint ?? "N/A",
                          "assignedTo": complaint.assignTo ?? "N/A",
                        });
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Complaint ${complaint.serialNo ?? 'N/A'}"),
                              Text("${complaint.description ?? ''}"),
                              Text("${complaint.statusName ?? 'N/A'}"),
                              Text("${complaint.typecomplaintName ?? ''}"),
                              Text("${complaint.priority ?? 'N/A'}"),
                              Text("${complaint.date ?? 'N/A'}"),
                              Text("${complaint.attachComplaint ?? 'N/A'}"),
                              Text("${complaint.assignTo ?? 'N/A'}"),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }

        if (state is UserError) {
          return Center(child: Text("Error: ${state.message}"));
        }

        return const SizedBox();
      },
    );
  }

  /// **Mobile View (Simple ListTile Format)**
  // Widget _buildMobileListView() {
  //   return Column(
  //     children: [
  //       _buildHeaderRow(), // Add the header row
  //       Expanded(
  //         child: ListView.builder(
  //           itemCount: complaints.length,
  //           itemBuilder: (context, index) {
  //             var complaint = complaints[index];
  //             return GestureDetector(
  //               onTap: () {
  //                 _showComplaintDetails(context, {
  //                   "serial": complaint["serial"] ?? "N/A",
  //                   "details": complaint["details"] ?? "N/A",
  //                   "status": complaint["status"] ?? "N/A",
  //                   "type": complaint["type"] ?? "N/A",
  //                   "priority": complaint["priority"] ?? "N/A",
  //                   "submissionDate": complaint["submissionDate"] ?? "N/A",
  //                   "file": complaint["file"] ?? "N/A",
  //                   "assignedTo": complaint["assignedTo"] ?? "N/A",
  //                 });
  //               },
  //               child: Card(
  //                 margin: const EdgeInsets.symmetric(
  //                   vertical: 8,
  //                   horizontal: 16,
  //                 ),
  //                 child: ListTile(
  //                   title: Text(""),
  //                   subtitle: Flexible(
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text("Complaint ${complaint['serial']}"),
  //                         Text(" ${complaint['details']}"),
  //                         Text(" ${complaint['status'] ?? "N/A"}"),
  //                         Text(" ${complaint['type']}"),
  //                         Text(" ${complaint['priority'] ?? "N/A"}"),
  //                         Text(" ${complaint['submissionDate']}"),
  //                         Text(" ${complaint['file'] ?? "N/A"}"),
  //                         Text(" ${complaint['assignedTo'] ?? "N/A"}"),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             );
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildMobileListView() {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        var cubit = context.read<UserCubit>();

        if (state is PostLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is UserLoaded) {
          final complaints = state.complaints;

          if (complaints.isEmpty) {
            return const Center(child: Text("No complaints found."));
          }

          print("🧾 Complaints Loaded: ${complaints.length}");

          return Column(
            children: [
              _buildHeaderRow(),
              Expanded(
                child: ListView.builder(
                  itemCount: complaints.length,
                  itemBuilder: (context, index) {
                    final complaint = complaints[index];
                    return GestureDetector(
                      onTap: () {
                        _showComplaintDetails(context, {
                          "serial": complaint.serialNo ?? "N/A",
                          "details": complaint.description ?? "N/A",
                          "status": complaint.statusName ?? "N/A",
                          "type": complaint.typecomplaintName ?? "N/A",
                          "priority": complaint.priority?.toString() ?? "N/A",
                          "submissionDate": complaint.date ?? "N/A",
                          "file": complaint.attachComplaint ?? "N/A",
                          "assignedTo": complaint.assignTo ?? "N/A",
                        });
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Complaint ${complaint.serialNo ?? 'N/A'}"),
                              Text("${complaint.description ?? ''}"),
                              Text("${complaint.statusName ?? 'N/A'}"),
                              Text("${complaint.typecomplaintName ?? ''}"),
                              Text("${complaint.priority ?? 'N/A'}"),
                              Text("${complaint.date ?? 'N/A'}"),
                              Text("${complaint.attachComplaint ?? 'N/A'}"),
                              Text("${complaint.assignTo ?? 'N/A'}"),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }

        if (state is UserError) {
          return Center(child: Text("Error: ${state.message}"));
        }

        return const SizedBox();
      },
    );
  }

  /// **Table Headers for Desktop**
  Widget _buildHeaderRow() {
    return Container(
      color: Colors.blue.shade100,
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _headerText("Serial No."),
          _headerText("Details"),
          _headerText("Status"),
          _headerText("Type"),
          _headerText("Priority"),
          _headerText("Submission Date"),
          _headerText("File"),
          _headerText("Assigned To"),
        ],
      ),
    );
  }

  /// **Reusable Header Widget**
  Widget _headerText(String title) {
    return Expanded(
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  void _showComplaintDetails(
    BuildContext context,
    Map<String, String> complaint,
  ) {
    String? _selectedStatus;
    String? _selectedPriority;
    String? _selectedType;

    bool showActions = false;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            double screenWidth = MediaQuery.of(context).size.width;
            return Dialog(
              insetPadding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            const Text(
                              textAlign: TextAlign.center,
                              "Review and Action",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Container(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 200,
                                  width: 700,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(16),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(24),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Row with three Text widgets
                                          Row(
                                            children: const [
                                              Text("15,2025"),
                                              Padding(
                                                padding: EdgeInsets.all(12),
                                              ),
                                              Text(
                                                "N/A",
                                                style: TextStyle(
                                                  color: Colors.orange,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(12),
                                              ),
                                              Text(
                                                "N/A",
                                                style: TextStyle(
                                                  color: Colors.green,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(12),
                                              ),
                                              Text("شكوى"),
                                            ],
                                          ),

                                          const SizedBox(height: 36), // Spacer
                                          // A single Text widget
                                          const Text(
                                            "No Audio",
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                209,
                                                158,
                                                158,
                                                158,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 12), // Spacer
                                          // Text with X Icon
                                          Row(
                                            children: const [
                                              Icon(Icons.close),
                                              SizedBox(width: 8),
                                              Text(
                                                "No Attachment",
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                    209,
                                                    158,
                                                    158,
                                                    158,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          const SizedBox(height: 12), // Spacer
                                          // Row with three Text + X Icon pairs
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              Row(
                                                children: [
                                                  Icon(Icons.close, size: 16),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    "No Name",
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                        209,
                                                        158,
                                                        158,
                                                        158,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(Icons.close, size: 16),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    "No Email",
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                        209,
                                                        158,
                                                        158,
                                                        158,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(Icons.close, size: 16),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    "No Phone Number",
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                        209,
                                                        158,
                                                        158,
                                                        158,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              showActions = !showActions;
                            });
                          },
                          child:
                              showActions
                                  ? Text(
                                    'Hide Actions',
                                    style: TextStyle(color: Colors.blue),
                                  )
                                  : Text(
                                    'Show Actions',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                        ),
                        SizedBox(height: 20),
                        if (showActions)
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                screenWidth < 1000
                                    ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        _buildDropdownBox(
                                          hint: "Update Status",
                                          value: _selectedStatus,
                                          items: [
                                            'Open',
                                            'In Progress',
                                            'Closed',
                                          ],
                                          onChanged:
                                              (val) => setState(
                                                () => _selectedStatus = val,
                                              ),
                                        ),
                                        _buildDropdownBox(
                                          hint: "Set Priority",
                                          value: _selectedPriority,
                                          items: ['Low', 'Medium', 'High'],
                                          onChanged:
                                              (val) => setState(
                                                () => _selectedPriority = val,
                                              ),
                                        ),
                                        _buildDropdownBox(
                                          hint: "Update Type",
                                          value: _selectedType,
                                          items: ['Bug', 'Feedback', 'Other'],
                                          onChanged:
                                              (val) => setState(
                                                () => _selectedType = val,
                                              ),
                                        ),
                                      ],
                                    )
                                    : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        _buildDropdownBox(
                                          hint: "Update Status",
                                          value: _selectedStatus,
                                          items: [
                                            'Open',
                                            'In Progress',
                                            'Closed',
                                          ],
                                          onChanged:
                                              (val) => setState(
                                                () => _selectedStatus = val,
                                              ),
                                        ),
                                        _buildDropdownBox(
                                          hint: "Set Priority",
                                          value: _selectedPriority,
                                          items: ['Low', 'Medium', 'High'],
                                          onChanged:
                                              (val) => setState(
                                                () => _selectedPriority = val,
                                              ),
                                        ),
                                        _buildDropdownBox(
                                          hint: "Update Type",
                                          value: _selectedType,
                                          items: ['Bug', 'Feedback', 'Other'],
                                          onChanged:
                                              (val) => setState(
                                                () => _selectedType = val,
                                              ),
                                        ),
                                      ],
                                    ),

                                const SizedBox(height: 20),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Text(
                                      'Subject',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    _buildRoundedLabel(
                                      " ${complaint['status'] ?? "N/A"}",
                                    ),
                                    Text(
                                      'Content',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    _buildRoundedLabel(
                                      " ${complaint['priority'] ?? "N/A"}",
                                    ),
                                    Text(
                                      'Corrective Action',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    _buildRoundedLabel(
                                      " ${complaint['type'] ?? "N/A"}",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildRoundedLabel(String text) {
    return Container(
      width: 600,
      height: 80,
      decoration: BoxDecoration(
        color: const Color.fromARGB(33, 238, 238, 238),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey),
      ),
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          text,
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildDropdownBox({
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      width: 200,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(26, 158, 158, 158),
      ),
      child: DropdownButton<String>(
        value: value,
        hint: Text(hint),
        underline: const SizedBox(),
        isExpanded: false,
        items:
            items
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
