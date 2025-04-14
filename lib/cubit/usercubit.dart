import 'package:complaint_web/core/api/api_consumer.dart';
import 'package:complaint_web/core/api/endpoints.dart';
import 'package:complaint_web/cubit/userstate.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  final ApiConsumer api;
  UserCubit(this.api) : super(UserInitial());
  GlobalKey<FormState> sendItFormKey = GlobalKey();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Future<void> logIn(String userName, String password) async {
  //   // if (api == null) {
  //   //   print("❌ Error: ApiConsumer is null!");
  //   //   return;
  //   // }
  //   try {
  //     emit(PostLoading());
  //     Map<String, dynamic> loginData = {
  //       "userName": userName,
  //       "password": password,
  //     };

  //     Response? response = await api.post(Endpoints.login, data: loginData);
  //     if (response != null && response.statusCode == 200 && response.data['token'] != null) {
  //       print("✅ Login successfully!");
  //       emit(SendSuccess());

  //       String token = response.data["token"];
  //       //if (token != null) {
  //         api.setAuthToken(token);
  //      // }

  //       await Future.delayed(const Duration(seconds: 2));
  //       emit(UserInitial());
  //     } else {
  //       print("⚠️ Login failed: ${response?.statusMessage}");
      
  //       emit(
  //         SendFailure(errMessage:  response?.data["message"] ?? "Invalid username or password"),
  //         //response?.statusMessage ?? "Unknown error"),
  //       );
  //     }
  //   } on Exception catch (e) {
  //     print("❌ Error posting complaint: $e");
  //     //emit(SendFailure(errMessage: ));
  //   }
  // }

  Future<void> logIn(String userName, String password) async {
  try {
    emit(PostLoading());

    Map<String, dynamic> loginData = {
      "userName": userName,
      "password": password,
    };

    Response? response = await api.post(Endpoints.login, data: loginData);
    print("📦 Response: ${response?.data}");

    if (response != null &&
        response.statusCode == 200 &&
        response.data['result'] == true &&
        response.data['token'] != null) {

      print("✅ Login successfully!");
      emit(SendSuccess());

      String token = response.data["token"];
      api.setAuthToken(token);

      await Future.delayed(const Duration(seconds: 2));
      emit(UserInitial());

    } else {
      String errorMsg = "Invalid username or password";

      if (response?.data['errors'] != null && response!.data['errors'].isNotEmpty) {
        errorMsg = response.data['errors'][0];  // Arabic error from backend
      }

      print("⚠️ Login failed: $errorMsg");
      emit(SendFailure(errMessage: errorMsg));
    }
  } on Exception catch (e) {
    print("❌ Error posting complaint: $e");
    emit(SendFailure(errMessage: "An error occurred: $e"));
  }
}

}
