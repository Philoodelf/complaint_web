import 'package:complaint_web/core/api/api_consumer.dart';
import 'package:complaint_web/core/api/dio_consumer.dart';
import 'package:complaint_web/cubit/usercubit.dart';
import 'package:complaint_web/responsive/responsive_screen.dart';
import 'package:complaint_web/screens/login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => UserCubit(DioConsumer(dio: Dio()) ),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Complaint',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(),
    );
  }
}
