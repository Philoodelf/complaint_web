import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String variable;
  final TextInputType keyboardType;
  final bool isPassword; // Renamed to isPassword to indicate if it's a password field

  const MyTextField({
    super.key,
    this.controller,
    required this.variable,
    required this.keyboardType,
    required this.isPassword,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _isObscured = true; // Track password visibility

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        obscureText: widget.isPassword ? _isObscured : false, // Apply toggle only if it's a password field
        decoration: InputDecoration(
      
          labelText: widget.variable,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.black),
          ),
          fillColor:  Colors.white, //Color.fromARGB(150, 238, 238, 238),
          filled: true,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(_isObscured ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _isObscured = !_isObscured; // Toggle password visibility
                    });
                  },
                )
              : null, // Show the eye icon only for password fields
        ),
      ),
    );
  }
}
