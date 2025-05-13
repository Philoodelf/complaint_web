import 'package:complaint_web/model/complaints_model.dart';

class PaginatedComplaintResponse {
  final List<Complaint> complaints;
  final int pageNo;
  final int totalPages;
  final int noOfItems;
  final int totalItems;

  PaginatedComplaintResponse({
    required this.complaints,
    required this.pageNo,
    required this.totalPages,
    required this.noOfItems,
    required this.totalItems,
  });

  factory PaginatedComplaintResponse.fromJson(Map<String, dynamic> json) {
    final List<Complaint> complaints = (json['data'] as List<dynamic>)
        .map((item) => Complaint.fromJson(item))
        .toList();

    return PaginatedComplaintResponse(
      complaints: complaints,
      pageNo: json['pageNo'] ?? 1,
      totalPages: json['totalPages'] ?? 1,
      noOfItems: json['noOfItems'] ?? complaints.length,
      totalItems: json['totalItems'] ?? complaints.length,
    );
  }
}

