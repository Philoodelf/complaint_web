class Complaint {
  final int id;
  final int? typeComplaintId;
  final String? typeComplaintName;
  final String? description;
  final String? content;
  final String? serialNo;
  final String? date;
  final String? statusName;
  final String? statusId;
  final String? typecomplaintName;
  final String? priority;
  final String? attachComplaint;
  final String? assignTo;
  final String? voice;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? correctiveAction;
  

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
    this.statusId,
    this.typecomplaintName,
    this.priority,
    this.attachComplaint,
    this.assignTo,
    this.voice,
    this.name,
    this.email,
    this.phoneNumber,
    this.correctiveAction,
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
    statusId: json['statusId']?.toString(),
    typecomplaintName: json['typecomplaintName'],
    priority: json['priority'],
    attachComplaint: json['attachComplaint'],
    assignTo: json['assignTo'],
    voice: json['voice']?.toString(),
    name: json['name']?.toString(),
    email: json['email']?.toString(),
    phoneNumber: json['phoneNumber']?.toString(),
    correctiveAction: json['correctiveAction']?.toString(),
  );
}

}
