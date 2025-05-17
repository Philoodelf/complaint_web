import 'package:complaint_web/model/complaints_model.dart';
import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  const UserState();
  @override
  List<Object?> get props => [];
}

final class UserInitial extends UserState {}

// user loaded complains
class UserLoaded extends UserState {
  final List<Complaint> complaints;
  final int totalPages;
  final int pageNo;
  final int noOfItems;
  final int totalItems;

  const UserLoaded(
    this.complaints,
    this.totalPages,
    this.pageNo,
    this.noOfItems, this.totalItems,
  );

  @override
  List<Object?> get props => [complaints];
}

// user error complains
class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object?> get props => [message];
}

// category

final class SendSuccess extends UserState {}

final class PostLoading extends UserState {}

final class CategoriesLoaded extends UserState {
  final List<Map<String, dynamic>> categories;
  CategoriesLoaded(this.categories);
}

final class SendFailure extends UserState {
  final String errMessage;

  SendFailure({required this.errMessage});
}

// complaints status
final class StatusLoaded extends UserState {}

// pagination
final class UserLoadedPage extends UserState {
  final List<Complaint> complaints;
  final int totalPages;

  const UserLoadedPage({required this.complaints, required this.totalPages});
}



//update category succeed 
final class UpdateSuccess extends UserState {}

// search
// final class UserSearch extends UserState{
//   final List<Map<String, dynamic>> complaints;

//   UserSearch( this.complaints);
// }
// final class UserSearch extends UserState {
//   final List<Complaint> complaints;
//   final int totalPages;
//   final int pageNo;
//   final int noOfItems;
//   final int totalItems;

//   const UserSearch(
//     this.complaints,
//     this.totalPages,
//     this.pageNo,
//     this.noOfItems,
//     this.totalItems,
//   );

//   @override
//   List<Object?> get props => [complaints, totalPages, pageNo, noOfItems, totalItems];
// }

