class Complaint {
  final String? content;
  final String? description;
  final String? serialNo;

  Complaint({this.content, this.description, this.serialNo});

  // Factory constructor to create a Complaint from JSON
  factory Complaint.fromJson(Map<String, dynamic> json) {
    return Complaint(
      content: json['content'] as String?,
      description: json['description'] as String?,
      serialNo: json['serialNo'] as String?,
    );
  }
}
