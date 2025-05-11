import 'package:complaint_web/cubit/usercubit.dart';
import 'package:complaint_web/cubit/userstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResponsiveFilterRow extends StatefulWidget {
  const ResponsiveFilterRow({super.key});

  @override
  State<ResponsiveFilterRow> createState() => _ResponsiveFilterRowState();
}

class _ResponsiveFilterRowState extends State<ResponsiveFilterRow> {
  String? selectedPriority;
  String? selectedStatus;
  String? selectedCategory;
  String? selectedAssignedTo;

  DateTime? fromDate;
  DateTime? toDate;

  List<Map<String, dynamic>> complaintStatuses = [];

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().fetchCategories(
      // typeComplaintId: selectedCategory,
    );
    context.read<UserCubit>().fetchComplaints();
  }

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        if (isFromDate) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });

      final adjustedToDate = toDate?.add(
        const Duration(hours: 23, minutes: 59, seconds: 59),
      );

      print("📅 Filtering from: $fromDate to: $adjustedToDate");

      // 🔁 Re-fetch filtered data
      context.read<UserCubit>().fetchComplaints(
        fromDate: fromDate,
        toDate: toDate,
        typeComplaintId: selectedCategory,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= 1024) {
      // Desktop Layout
      return _buildDesktopFilterRow();
    } else if (screenWidth >= 600) {
      // Tablet Layout
      return _buildTabletFilterRow();
    } else {
      // Mobile Layout
      return _buildMobileFilterRow();
    }
  }

  Widget _buildDesktopFilterRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          //const Icon(Icons.search),
          const SizedBox(width: 8),
          Expanded(child: _buildSearchField()),
          const SizedBox(width: 8),
          _buildDropdownPriority('Priority'),
          const SizedBox(width: 8),
          _buildDropdownSatatus('Status'),
          const SizedBox(width: 8),
          _buildDropdownCategory('Category'),
          const SizedBox(width: 8),
          _buildDropdownAssignTo('Assigned To'),
          const SizedBox(width: 8),
          _buildDatePickerFrom('From Date'),
          const SizedBox(width: 8),
          _buildDatePickerTo('To Date'),
        ],
      ),
    );
  }

  Widget _buildTabletFilterRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              // const Icon(Icons.search),
              const SizedBox(width: 8),
              Expanded(child: _buildSearchField()),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildDropdownPriority('Priority'),
              _buildDropdownSatatus('Status'),
              _buildDropdownCategory('Category'),
              _buildDropdownAssignTo('Assigned To'),
              _buildDatePickerFrom('From Date'),
              _buildDatePickerTo('To Date'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMobileFilterRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildSearchField(),
          const SizedBox(height: 8),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildDropdownPriority('Priority'),
                  _buildDropdownSatatus('Status'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildDropdownAssignTo('Assigned To'),
                  _buildDatePickerFrom('From Date'),
                  _buildDatePickerTo('To Date'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [_buildDropdownCategory('Category')],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: searchController,
      onChanged: (value) {
        // Call the filter method in the cubit
        // context.read<UserCubit>().filterComplaintsBySearch(value);
        _filterComplaints(value);
      },
      decoration: InputDecoration(
        hintText: 'Search...',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        prefixIcon: const Icon(Icons.search),
      ),
    );
  }

  Widget _buildDropdown(String label) {
    return DropdownButton<String>(
      hint: Text(label),
      items:
          ['Option 1', 'Option 2', 'Option 3'].map((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedPriority = newValue;
        });
      },
    );
  }

  Widget _buildDropdownPriority(String label) {
    return DropdownButton<String>(
      value: selectedPriority,
      hint: Text(label),
      onChanged: (String? newValue) {
        setState(() {
          selectedPriority = newValue;
        });
      },
      items:
          ["High", "Medium", "Low"]
              .map(
                (value) => DropdownMenuItem(value: value, child: Text(value)),
              )
              .toList(),
            // remove filter
              icon: selectedPriority != null
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    selectedPriority = null;
                  });

                 
                },
                child: Icon(Icons.clear, color: const Color.fromARGB(145, 31, 63, 220)),
              )
            : Icon(Icons.arrow_drop_down),
    );
  }

  Widget _buildDropdownSatatus(String label) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final statuses = context.read<UserCubit>().complaintStatuses;

        if (statuses.isEmpty) {
          //   return const CircularProgressIndicator(); // or SizedBox.shrink()
          return DropdownButton<String>(
            value: null,
            hint: Text("Status (N/A)"),
            items: [],
            onChanged: null, // disable interaction
          );
        }

        return DropdownButton<String>(
          value: selectedStatus,
          hint: Text(label),
          onChanged: (String? newValue) {
            setState(() {
              selectedStatus = newValue;
            });
          },
          items:
              statuses
                  .map(
                    (status) => DropdownMenuItem<String>(
                      value: status["id"].toString(),
                      child: Text(status["name"] ?? 'Unknown'),
                    ),
                  )
                  .toList(),
           // remove filter
              icon: selectedStatus != null
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    selectedStatus = null;
                  });

                  context.read<UserCubit>().fetchComplaints(
                    fromDate: fromDate,
                    toDate: toDate,
                    typeComplaintId: selectedCategory,
                  );
                },
                child: Icon(Icons.clear, color: const Color.fromARGB(145, 31, 63, 220)),
              )
            : Icon(Icons.arrow_drop_down),
        );
      },
    );
  }

  
  Widget _buildDropdownCategory(String label) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final cubit = context.read<UserCubit>();
        final List<Map<String, dynamic>> categories = cubit.categories;
        print("🔍 Selected Category: $selectedCategory");

        print("📦 Categories fetched: $categories");
        print("🧾 Categories loaded: ${categories.length}");

        // 🔒 Reset selection if ID not found
        if (selectedCategory != null &&
            !categories.any(
              (cat) => cat["id"].toString() == selectedCategory,
            )) {
          selectedCategory = null;
        }

        return DropdownButton<String>(
          value: selectedCategory,
          hint: Text(label),
          items:
              categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category["id"].toString(),
                  child: Text(category["name"].toString().trim()),
                );
              }).toList(),
          onChanged: (value) {
            setState(() {
              selectedCategory = value;
              print("✅ Selected category ID: $selectedCategory");
            });

            // Now use the Cubit method that handles Dio headers
            context.read<UserCubit>().fetchComplaints(
              fromDate: fromDate,
              toDate: toDate,
              typeComplaintId: selectedCategory,
            );
          },
          icon: selectedCategory != null
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCategory = null;
                  });

                  context.read<UserCubit>().fetchComplaints(
                    fromDate: fromDate,
                    toDate: toDate,
                    typeComplaintId: null,
                  );
                },
                child: Icon(Icons.clear, color: const Color.fromARGB(145, 31, 63, 220)),
              )
            : Icon(Icons.arrow_drop_down),
        );
      },
    );
  }



  Widget _buildDropdownAssignTo(String label) {
    return DropdownButton<String>(
      value: selectedAssignedTo,
      hint: Text(label),
      onChanged: (String? newValue) {
        setState(() {
          selectedAssignedTo = newValue;
        });
      },
      items:
          ["Alice", "Bob", "Charlie"]
              .map(
                (value) => DropdownMenuItem(value: value, child: Text(value)),
              )
              .toList(),
        // remove filter
              icon: selectedAssignedTo != null
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    selectedAssignedTo = null;
                  });

                 
                },
                child: Icon(Icons.clear, color: const Color.fromARGB(145, 31, 63, 220)),
              )
            : Icon(Icons.arrow_drop_down),
    );
  }

 
Widget _buildDatePickerFrom(String label) {
  return ElevatedButton(
    onPressed: () => _selectDate(context, true),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    ),
    child: SizedBox(
      width: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            fromDate == null
                ? label
                : "${fromDate!.day}/${fromDate!.month}/${fromDate!.year}",
            style: const TextStyle(color: Colors.black),
          ),
          if (fromDate != null)
            GestureDetector(
              onTap: () {
                setState(() {
                  fromDate = null;
                });
                context.read<UserCubit>().fetchComplaints(
                  fromDate: null,
                  toDate: toDate,
                  typeComplaintId: selectedCategory,
                );
              },
              child: const Icon(Icons.clear, color:  Color.fromARGB(145, 31, 63, 220)),
            ),
        ],
      ),
    ),
  );
}



  Widget _buildDatePickerTo(String label) {
    return ElevatedButton(
    onPressed: () => _selectDate(context, false),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    ),
    child: SizedBox(
      width: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            toDate == null
                ? label
                : "${toDate!.day}/${toDate!.month}/${toDate!.year}",
            style: const TextStyle(color: Colors.black),
          ),
          if (toDate != null)
            GestureDetector(
              onTap: () {
                setState(() {
                  toDate = null;
                });
                context.read<UserCubit>().fetchComplaints(
                  fromDate: fromDate,
                  toDate: null,
                  typeComplaintId: selectedCategory,
                );
              },
              child: const Icon(Icons.clear, color:  Color.fromARGB(145, 31, 63, 220)),
            ),
        ],
      ),
    ),
  );
  }

  List<Map<String, dynamic>> allComplaints = []; // Full list from API
  List<Map<String, dynamic>> filteredComplaints = []; // Filtered list to show

  void _filterComplaints(String query) {
    final input = query.trim().toLowerCase();
    final results =
        allComplaints.where((complaint) {
          final content = complaint["content"]?.toLowerCase().trim() ?? '';
          final description =
              complaint["description"]?.toLowerCase().trim() ?? '';
          final serial = complaint["serialNo"]?.toLowerCase().trim() ?? '';

          // Debug: Print all complaint fields to check their content
          print("Complaint content: $content");
          print("Complaint description: $description");
          print("Complaint serialNo: $serial");

          return content.contains(input) ||
              description.contains(input) ||
              serial.contains(input);
        }).toList();

    print("🔍 Filtering complaints with query: $query");
    print("✅ ${results.length} results found.");

    setState(() {
      filteredComplaints = results;
    });
  }

  Widget _buildComplaintList() {
    return ListView.builder(
      itemCount: filteredComplaints.length,
      itemBuilder: (context, index) {
        final complaint = filteredComplaints[index];
        return ListTile(
          title: Text(complaint["content"] ?? "No content"),
          subtitle: Text(complaint["serialNo"] ?? ""),
        );
      },
    );
  }
}
