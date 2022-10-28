import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:note_making_app/screens/signup_screen.dart';
import 'package:note_making_app/widgets/round_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isVisible = true;
  bool showPassword = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 90),
              SvgPicture.asset(
                'images/login_img.svg',
                height: 250.0,
                // width: 200.0,
                allowDrawingOutsideViewBox: true,
              ),
              const SizedBox(height: 75),
              const Text(
                "Login",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          prefixIcon: Icon(Icons.mail_outline),
                        ),
                        validator: (value) {
                          if (value!.isEmpty && emailController.text == "") {
                            return "Enter e-mail";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 25),
                      TextFormField(
                        controller: passwordController,
                        obscureText: showPassword,
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          prefixIcon: const Icon(Icons.lock_open_outlined),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isVisible == true) {
                                  isVisible = showPassword = false;
                                } else {
                                  isVisible = showPassword = true;
                                }
                              });
                            },
                            child: isVisible
                                ? const Icon(Icons.visibility_off)
                                : const Icon(
                                    Icons.visibility,
                                  ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter password";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text("Forget Password"),
                    ),
                    ButtonElevated(
                        title: "Login",
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            debugPrint("Ok");
                          }
                        },
                        loading: false),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't you have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                        ),
                      );
                    },
                    child: const Text("Sign Up"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}