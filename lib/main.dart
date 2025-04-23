import 'package:complaint_web/core/api/api_consumer.dart';
import 'package:complaint_web/core/api/dio_consumer.dart';
import 'package:complaint_web/cubit/usercubit.dart';
import 'package:complaint_web/responsive/responsive_screen.dart';
import 'package:complaint_web/screens/login.dart';
import 'package:complaint_web/screens/dashboard.dart'; // add your dashboard here
import 'package:complaint_web/shared_preferences/storage_token.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dio = Dio();
  final dioConsumer = DioConsumer(dio: dio);

  final token = await TokenStorage.getToken();
  if (token != null) {
    dioConsumer.setAuthToken(token);
  }

  runApp(
    BlocProvider(
      create: (context) => UserCubit(dioConsumer),
      child: MyApp(isLoggedIn: token != null),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Complaint',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: isLoggedIn ? const Dashboard() : const LoginScreen(),
    );
  }
}
