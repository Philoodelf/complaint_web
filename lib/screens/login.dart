import 'package:complaint_web/cubit/usercubit.dart';
import 'package:complaint_web/cubit/userstate.dart';
import 'package:complaint_web/responsive/responsive_screen.dart';
import 'package:complaint_web/screens/Dashboard.dart';
import 'package:complaint_web/widgets/mytextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   usernameController = TextEditingController();
  //   passwordController = TextEditingController();
  // }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Control Panel | لوحة التحكم",
          style: TextStyle(color: Colors.white), // White text color
        ),
        backgroundColor: const Color.fromARGB(
          226,
          10,
          71,
          120,
        ), // Blue background
        centerTitle: true, // Center the title
      ),
      body: ResponsiveScreen(
        mobile: _buildMobileLogin(),
        tablet: _buildTabletLogin(),
        desktop: _buildDesktopLogin(),
      ),
    );
  }

  Widget _buildMobileLogin() {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is SendSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Dashboard()),
          );
        } else if (state is SendFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errMessage)));
        }
      },
      builder: (context, state) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                MyTextField(
                  variable: 'Username',
                  keyboardType: TextInputType.name,
                  isPassword: false,
                  controller: usernameController,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  variable: 'Password',
                  keyboardType: TextInputType.text,
                  isPassword: true,
                  controller: passwordController,
                ),
                const SizedBox(height: 20),
                state is PostLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                      onPressed: () {
                        print("👤 Username: '${usernameController.text}'");
                        print("🔑 Password: '${passwordController.text}'");
                        context.read<UserCubit>().logIn(
                          usernameController.text,
                          passwordController.text,
                        );
                      },
                      child: const Text("Login"),
                    ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTabletLogin() {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is SendSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Dashboard()),
          );
        } else if (state is SendFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errMessage)));
        }
      },
      builder: (context, state) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                MyTextField(
                  variable: 'Username',
                  keyboardType: TextInputType.name,
                  isPassword: false,
                  controller: usernameController,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  variable: 'Password',
                  keyboardType: TextInputType.text,
                  isPassword: true,
                  controller: passwordController,
                ),
                const SizedBox(height: 20),
                state is PostLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                      onPressed: () {
                        print("👤 Username: '${usernameController.text}'");
                        print("🔑 Password: '${passwordController.text}'");
                        context.read<UserCubit>().logIn(
                          usernameController.text,
                          passwordController.text,
                        );
                      },
                      child: const Text("Login"),
                    ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDesktopLogin() {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is SendSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Dashboard()),
          );
        } else if (state is SendFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errMessage)));
        }
      },
      builder: (context, state) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 200),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 50),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      MyTextField(
                        variable: 'Username',
                        keyboardType: TextInputType.name,
                        isPassword: false,
                        controller: usernameController,
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        variable: 'Password',
                        keyboardType: TextInputType.text,
                        isPassword: true,
                        controller: passwordController,
                      ),
                      const SizedBox(height: 20),
                      state is PostLoading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                            onPressed: () {
                              print(
                                "👤 Username: '${usernameController.text}'",
                              );
                              print(
                                "🔑 Password: '${passwordController.text}'",
                              );
                              context.read<UserCubit>().logIn(
                                usernameController.text,
                                passwordController.text,
                              );
                            },
                            child: Text('LogIn'),
                          ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
