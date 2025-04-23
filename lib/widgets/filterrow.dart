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

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().fetchCategories(); // Call your cubit method here
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
                children: [
                  _buildDropdownCategory('Category'),
                ],
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
    );
  }

  Widget _buildDropdownSatatus(String label) {
    return DropdownButton<String>(
      value: selectedStatus,
      hint: Text(label),
      onChanged: (String? newValue) {
        setState(() {
          selectedStatus = newValue;
        });
      },
      items:
          ["Open", "In Progress", "Closed"]
              .map(
                (value) => DropdownMenuItem(value: value, child: Text(value)),
              )
              .toList(),
    );
  }

  Widget _buildDropdownCategory(String label) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final cubit = context.read<UserCubit>();
        final List<Map<String, dynamic>> categories = cubit.categories;

        print("📦 Categories fetched: $categories");
        print("🧾 Categories loaded: ${categories.length}");

        // 🔒 Safety: If selectedCategory is no longer in the list, clear it
        if (selectedCategory != null &&
            !categories.any(
              (cat) => cat["id"].toString() == selectedCategory,
            )) {
          selectedCategory = null;
        }

        return DropdownButton<String>(
          value: selectedCategory,
          hint: Text(label),
          //isExpanded: true, // ✅ Improves layout on small screens
          items:
              categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category["id"].toString(),
                  child: Text(
                    category["name"].toString().trim(),
                  ), // clean newline
                );
              }).toList(),
          onChanged: (value) {
            setState(() {
              selectedCategory = value;
              print("✅ Selected category ID: $selectedCategory");
            });
          },
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
    );
  }

  Widget _buildDatePickerFrom(String label) {
    return ElevatedButton(
      onPressed: () async {
        _selectDate(context, true);
        // Show Date Picker Dialog
      },
      child: Text(
        fromDate == null
            ? label
            : "${fromDate!.day}/${fromDate!.month}/${fromDate!.year}",
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _buildDatePickerTo(String label) {
    return ElevatedButton(
      onPressed: () async {
        _selectDate(context, false);
        // Show Date Picker Dialog
      },
      child: Text(
        toDate == null
            ? label
            : "${toDate!.day}/${toDate!.month}/${toDate!.year}",
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
