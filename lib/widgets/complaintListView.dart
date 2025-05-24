import 'package:complaint_web/cubit/usercubit.dart';
import 'package:complaint_web/cubit/userstate.dart';
import 'package:complaint_web/model/complaints_model.dart';
import 'package:complaint_web/responsive/responsive_screen.dart';
import 'package:complaint_web/widgets/category_update.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComplaintListView extends StatefulWidget {
  // final int userId;
  const ComplaintListView({super.key});

  @override
  State<ComplaintListView> createState() => _ComplaintListViewState();
}

class _ComplaintListViewState extends State<ComplaintListView> {
  // @override
  // void initState() {
  //   super.initState();
  //   context.read<UserCubit>().fetchComplaints(
  //     //  userId: "d03a0db5-6208-4a27-a1be-1f9aa4c3cc26"
  //     // userId:391
  //   ); // No userId = get all complaints
  // }

  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return ResponsiveScreen(
      mobile: _buildMobileListView(),
      tablet: _buildTabletListView(),
      desktop: _buildDesktopListView(),
    );
  }

  /// **Desktop View (Full Row Headers & Horizontal Layout)**
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
                        _showComplaintDetails(context, complaint);
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
                              Text("${complaint.description ?? 'N/A'}"),
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
                        _showComplaintDetails(context, complaint);
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
                        _showComplaintDetails(context, complaint);
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
    // Map<String, String> complaint,
    Complaint complaint,
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
            //  final complaint = complaints[index];
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
                                  height: 250,
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
                                            children: [
                                              Text(complaint.date ?? "N/A"),
                                              Padding(
                                                padding: EdgeInsets.all(12),
                                              ),
                                              Text(
                                                complaint.priority ?? "N/A",
                                                style: TextStyle(
                                                  color: Colors.orange,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(12),
                                              ),
                                              Text(
                                                complaint.statusName ?? "N/A",
                                                style: TextStyle(
                                                  color: Colors.green,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(12),
                                              ),
                                              Text(
                                                complaint.typecomplaintName ??
                                                    "N/A",
                                              ),
                                            ],
                                          ),

                                          const SizedBox(height: 36), // Spacer
                                          // A single Text widget
                                          Text(
                                            complaint.voice ?? "No Audio",
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
                                            children: [
                                              Icon(Icons.close),
                                              SizedBox(width: 8),
                                              Text(
                                                complaint.attachComplaint ??
                                                    "No Attached File",
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
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons.close, size: 16),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    complaint.name ?? "No Name",
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
                                                    complaint.email ??
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
                                                    complaint.phoneNumber ??
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
                                        // _buildDropdownBox(
                                        //   hint: "Update Type",
                                        //   value: _selectedType,
                                        //   items: ['Bug', 'Feedback', 'Other'],
                                        //   onChanged:
                                        //       (val) => setState(
                                        //         () => _selectedType = val,
                                        //       ),
                                        // ),
                                        //_buildDropdownCategory('Update '),
                                        //   CategoryUpdateDropdown(
                                        //   complaint: complaint,
                                        //  categories: context.read<UserCubit>().categories,
                                        //   onUpdate: ({
                                        //     required String complaintId,
                                        //     required String newCategoryId,
                                        //   }) {
                                        //     // Trigger the update call
                                        //     context
                                        //         .read<UserCubit>()
                                        //         .updateComplaintCategory(
                                        //           complaint,
                                        //           typeComplaintId:
                                        //               newCategoryId,
                                        //         );
                                        //   },
                                        // ),
                                        _buildCategoryUpdateDropdown(
                                          complaint: complaint,
                                          categories:
                                              context
                                                  .read<UserCubit>()
                                                  .categories,
                                          onUpdate: ({
                                            required String complaintId,
                                            required String newCategoryId,
                                          }) {
                                            context
                                                .read<UserCubit>()
                                                .updateComplaintCategory(
                                                  complaint,

                                                  // id: complaintId,
                                                  typeComplaintId:
                                                      newCategoryId,
                                                );
                                          },
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
                                        // _buildDropdownBox(
                                        //   hint: "Update Type",
                                        //   value: _selectedType,
                                        //   items: ['Bug', 'Feedback', 'Other'],
                                        //   onChanged:
                                        //       (val) => setState(
                                        //         () => _selectedType = val,
                                        //       ),
                                        // ),
                                        // CategoryUpdateDropdown(
                                        //   complaint: complaint,
                                        //  categories: context.read<UserCubit>().categories,
                                        //   onUpdate: ({
                                        //     required String complaintId,
                                        //     required String newCategoryId,
                                        //   }) {
                                        //     // Trigger the update call
                                        //     context
                                        //         .read<UserCubit>()
                                        //         .updateComplaintCategory(
                                        //           complaint,
                                        //           typeComplaintId:
                                        //               newCategoryId,
                                        //         );
                                        //   },
                                        // ),
                                        _buildCategoryUpdateDropdown(
                                          complaint: complaint,
                                          categories:
                                              context
                                                  .read<UserCubit>()
                                                  .categories,
                                          onUpdate: ({
                                            required String complaintId,
                                            required String newCategoryId,
                                          }) {
                                            context
                                                .read<UserCubit>()
                                                .updateComplaintCategory(
                                                  complaint,
                                                  //  id: complaintId,
                                                  typeComplaintId:
                                                      newCategoryId,
                                                );
                                          },
                                        ),
                                      ],
                                    ),

                                const SizedBox(height: 20),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    // Text(
                                    //   'Subject',
                                    //   style: TextStyle(color: Colors.grey),
                                    // ),
                                    // _buildRoundedLabel(
                                    //   " ${complaint.statusName ?? "N/A"}",
                                    // ),
                                    // Text(
                                    //   'Content',
                                    //   style: TextStyle(color: Colors.grey),
                                    // ),
                                    // _buildRoundedLabel(
                                    //   " ${complaint.content ?? "N/A"}",
                                    // ),
                                    // Text(
                                    //   'Corrective Action',
                                    //   style: TextStyle(color: Colors.grey),
                                    // ),
                                    // _buildRoundedLabel(
                                    //   " ${complaint.correctiveAction ?? "N/A"}",
                                    // ),
                                    _buildRoundedLabel(
                                      complaint: complaint,
                                      label: 'Subject',
                                      initialValue:
                                          complaint.statusName ?? "N/A",
                                      fieldKey: 'subject',
                                      onSave: (field, newValue) {
                                        context
                                            .read<UserCubit>()
                                            .updateComplaintCategory(
                                              complaint,
                                              updatedField: field,
                                              updatedValue: newValue,
                                              typeComplaintId:
                                                  complaint.typeComplaintId
                                                      ?.toString(),
                                            );
                                      },
                                    ),

                                    _buildRoundedLabel(
                                      complaint: complaint,
                                      label: 'Content',
                                      initialValue:
                                          complaint.content ?? "N/A",
                                      fieldKey: 'content',
                                      onSave: (field, newValue) {
                                        context
                                            .read<UserCubit>()
                                            .updateComplaintCategory(
                                              complaint,
                                              updatedField: field,
                                              updatedValue: newValue,
                                              typeComplaintId:
                                                  complaint.typeComplaintId
                                                      ?.toString(),
                                            );
                                      },
                                    ),
                                    _buildRoundedLabel(
                                      complaint: complaint,
                                      label: 'Corrective Action',
                                      initialValue:
                                          complaint.correctiveAction ?? "N/A",
                                      fieldKey: 'correctiveAction',
                                      onSave: (field, newValue) {
                                        context
                                            .read<UserCubit>()
                                            .updateComplaintCategory(
                                              complaint,
                                              updatedField: field,
                                              updatedValue: newValue,
                                              typeComplaintId:
                                                  complaint.typeComplaintId
                                                      ?.toString(),
                                            );
                                      },
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
  // is working
  // Widget _buildRoundedLabel(
  //   String text) {
  //   return Container(
  //     width: 600,
  //     height: 80,
  //     decoration: BoxDecoration(
  //       color: const Color.fromARGB(33, 238, 238, 238),
  //       borderRadius: BorderRadius.circular(6),
  //       border: Border.all(color: Colors.grey),
  //     ),
  //     alignment: Alignment.topLeft,
  //     child: Padding(
  //       padding: const EdgeInsets.all(12.0),
  //       child: TextField(
  //         controller: TextEditingController.fromValue(
  //           TextEditingValue(text: text),
  //         ),
  //         textAlign: TextAlign.left,
  //         style: const TextStyle(fontSize: 14, color: Colors.grey),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildRoundedLabel({
    required Complaint complaint,
    required String label,
    required String initialValue,
    required Function(String field, String newValue) onSave,
    required String fieldKey, // e.g. 'content', 'statusName', etc.
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        final controller = TextEditingController(text: initialValue);
        String pendingValue = initialValue;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 4),
            Container(
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
                child: TextField(
                  controller: controller,
                  maxLines: null,
                  onChanged: (value) => pendingValue = value,
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                  // decoration: const InputDecoration.collapsed(
                  //   //hintText: "Enter text...",
                  // ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                if (pendingValue != initialValue) {
                  onSave(fieldKey, pendingValue);
                }
              },
              child: const Text("Save"),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
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

  Widget _buildCategoryUpdateDropdown({
    required Complaint complaint,
    required List<Map<String, dynamic>> categories,
    required Function({
      required String complaintId,
      required String newCategoryId,
    })
    onUpdate,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        String? selectedCategoryId = complaint.typeComplaintId?.toString();
        String? pendingCategoryId =
            selectedCategoryId; // For temporary selection

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              width: 220,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(26, 158, 158, 158),
              ),
              child: DropdownButton<String>(
                value: selectedCategoryId,
                isExpanded: true,
                hint: const Text("Update Type"),
                items:
                    categories.map((category) {
                      final catId = category["id"].toString();
                      final catName = category["name"].toString();
                      return DropdownMenuItem<String>(
                        value: catId,
                        child: Text(catName),
                      );
                    }).toList(),
                onChanged: (newValue) {
                  // setState(() {
                  pendingCategoryId = newValue;
                  // newValue= pendingCategoryId;
                  //});
                },
                icon: const Icon(Icons.edit),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                if (pendingCategoryId != null &&
                    pendingCategoryId != selectedCategoryId) {
                  try {
                    onUpdate(
                      complaintId: complaint.id.toString(),
                      newCategoryId: pendingCategoryId!,

                      //  newCategoryId: newValue,
                    );
                    setState(
                      // selectedCategoryId = pendingCategoryId;
                      () => selectedCategoryId = pendingCategoryId,
                    );
                  } catch (e) {
                    print("❌ Error in onUpdate: $e");
                  }
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // Widget _buildCategoryUpdateDropdown({
  //   required Complaint complaint,
  //   required List<Map<String, dynamic>> categories,
  //   required Function({
  //     required String complaintId,
  //     required String newCategoryId,
  //   })
  //   onUpdate,
  // }) {

  //   return StatefulBuilder(
  //     builder: (context, setState) {
  //       String? selectedCategoryId = complaint.typeComplaintId?.toString();

  //       print(
  //         "📦 Rendering dropdown for complaint ID: ${complaint.id}, current category: $selectedCategoryId",
  //       );
  //       print("📋 Categories loaded: ${categories.length}");

  //       return Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 12),
  //             width: 220,
  //             decoration: BoxDecoration(
  //               border: Border.all(color: Colors.grey),
  //               borderRadius: BorderRadius.circular(10),
  //               color: const Color.fromARGB(26, 158, 158, 158),
  //             ),
  //             child: DropdownButton<String>(
  //               value: selectedCategoryId,
  //               isExpanded: true,
  //               hint: const Text("Update Type"),
  //               items:
  //                   categories.map((category) {
  //                     final catId = category["id"].toString();
  //                     final catName = category["name"].toString();
  //                     print("🔹 Adding category: $catName ($catId)");
  //                     return DropdownMenuItem<String>(
  //                       value: catId,
  //                       child: Text(catName),
  //                     );
  //                   }).toList(),

  //               onChanged: (newValue) {
  //                 if (newValue != null && newValue != selectedCategoryId) {
  //                   setState(
  //                     () => selectedCategoryId = newValue,
  //                   ); // Update local state

  //                   try {
  //                     // Call the update function passed as a callback
  //                     onUpdate(
  //                       complaintId: complaint.id.toString(),
  //                       newCategoryId: newValue,
  //                     );
  //                     print(
  //                       "🚀 onUpdate called for complaint ${complaint.id} with new category $newValue",
  //                     );
  //                   } catch (e) {
  //                     print("❌ Error in onUpdate: $e");
  //                   }
  //                 }
  //               },
  //               icon: const Icon(Icons.edit),
  //             ),
  //           ),

  //         ],
  //       );
  //     },
  //   );
  // }
}
