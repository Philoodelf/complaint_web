import 'package:complaint_web/model/complaints_model.dart';
import 'package:flutter/material.dart';

class CategoryUpdateDropdown extends StatefulWidget {
  final Complaint complaint;
  final List<Map<String, dynamic>> categories;
  final Function({
    required String complaintId,
    required String newCategoryId,
  }) onUpdate;

  const CategoryUpdateDropdown({
    Key? key,
    required this.complaint,
    required this.categories,
    required this.onUpdate,
  }) : super(key: key);

  @override
  _CategoryUpdateDropdownState createState() => _CategoryUpdateDropdownState();
}

class _CategoryUpdateDropdownState extends State<CategoryUpdateDropdown> {
  late String? selectedCategoryId;

  @override
  void initState() {
    super.initState();
    selectedCategoryId = widget.complaint.typeComplaintId?.toString();
  }

  @override
  Widget build(BuildContext context) {
    print(
        "📦 Building dropdown for complaint ${widget.complaint.id} with current category: $selectedCategoryId");
    print("📋 Categories loaded: ${widget.categories.length}");

    return Container(
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
        icon: const Icon(Icons.edit),
        items: widget.categories.map((category) {
          final catId = category["id"].toString();
          final catName = category["name"].toString();
          print("🔹 Adding category: $catName ($catId)");
          return DropdownMenuItem<String>(
            value: catId,
            child: Text(catName),
          );
        }).toList(),
        onChanged: (newValue) {
          if (newValue != null && newValue != selectedCategoryId) {
            setState(() {
              selectedCategoryId = newValue;
            });

            try {
              widget.onUpdate(
                complaintId: widget.complaint.id.toString(),
                newCategoryId: newValue,
              );
              print(
                  "🚀 onUpdate called for complaint ${widget.complaint.id} with new category $newValue");
            } catch (e) {
              print("❌ Error in onUpdate: $e");
            }
          }
        },
      ),
    );
  }
}
