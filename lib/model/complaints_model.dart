class Complaint {
  final int id;
  final int? typeComplaintId;
  final String? typeComplaintName;
  final String? description;
  final String? content;
  final String? serialNo;
  final String? date;
  final String? statusName;
  final String? typecomplaintName;
  final String? priority;
  final String? attachComplaint;
  final String? assignTo;

  Complaint(
     {
    required this.id,
    this.typeComplaintId,
    this.typeComplaintName,
    this.description,
    this.content,
    this.serialNo,
    this.date,
    this.statusName,
    this.typecomplaintName,
    this.priority,
    this.attachComplaint,
    this.assignTo,
  });

 factory Complaint.fromJson(Map<String, dynamic> json) {
  return Complaint(
    id: json['id'],
    typeComplaintId: json['typecomplaintId'],
    typeComplaintName: json['typecomplaintName']?.trim(),
    description: json['description'],
    content: json['content'],
    serialNo: json['serialNo'],
    date: json['date'],
    statusName: json['statusName'],
    typecomplaintName: json['typecomplaintName'],
    priority: json['priority'],
    attachComplaint: json['attachComplaint'],
    assignTo: json['assignTo'],
  );
}

}
