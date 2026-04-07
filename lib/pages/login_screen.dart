import 'dart:developer';

import 'package:cab_zing/Bloc/Login/login_bloc.dart';
import 'package:cab_zing/core/constants.dart';
import 'package:cab_zing/pages/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            setState(() {
              loading = true;
            });
          }
          if (state is LoginSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AppLayout()),
            );
          }
          if (state is LoginError) {
            setState(() {
              loading = false;
            });
          }
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: isDark ? null : Colors.white,
            gradient: isDark
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.black,
                      Color(0xFF1A1A2E),
                      Color(0xFF16213E),
                      Color(0xFF0F3460),
                    ],
                  )
                : null,
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  /// 🌐 Language
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.language,
                        color: isDark ? Colors.blue : Colors.black,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "English",
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  /// 🔐 Title
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 28,
                      color: isDark ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Login to your vikn account",
                    style: TextStyle(
                      color: isDark ? Colors.grey : Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// 👤 + 🔑 Input Card
                  Container(
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.black.withOpacity(0.6)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isDark ? Colors.white12 : Colors.black12,
                      ),
                    ),
                    child: Column(
                      children: [
                        /// Username
                        TextField(
                          controller: usernameController,
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person, color: Colors.blue),
                            hintText: "Username",
                            hintStyle: TextStyle(
                              color: isDark ? Colors.grey : Colors.black45,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(16),
                          ),
                        ),

                        Divider(
                          color: isDark ? Colors.white12 : Colors.black12,
                          height: 1,
                        ),

                        /// Password
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.key, color: Colors.blue),
                            suffixIcon: Icon(
                              Icons.visibility,
                              color: Colors.blue,
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(
                              color: isDark ? Colors.grey : Colors.black45,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(16),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    "Forgotten Password?",
                    style: TextStyle(color: Colors.blue),
                  ),

                  const SizedBox(height: 25),

                  InkWell(
                    onTap: () {
                      if (usernameController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty) {
                        context.read<LoginBloc>().add(
                          LoginRequested(
                            usernameController.text,
                            passwordController.text,
                          ),
                        );
                      } else {
                        toast('Please enter the username and password');
                      }
                    },
                    child: Container(
                      width: 160,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.blue, Colors.blueAccent],
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Sign in",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 8),
                            loading
                                ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(),
                                  )
                                : Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  /// 📝 Signup
                  Column(
                    children: [
                      Text(
                        "Don’t have an Account?",
                        style: TextStyle(
                          color: isDark ? Colors.white70 : Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Sign up now!",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
