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

  const UserLoaded(this.complaints);

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
