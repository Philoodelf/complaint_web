class UserState {}
final class UserInitial extends UserState{}

final class SendFailure extends UserState {
  final String errMessage;

  SendFailure({required this.errMessage});
}

final class SendSuccess extends UserState {}
final class PostLoading extends UserState {}

final class CategoriesLoaded extends UserState { 
  final List<Map<String, dynamic>> categories;
  CategoriesLoaded(this.categories);
}