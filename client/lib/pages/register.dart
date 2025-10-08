import 'package:client/pages/home_page.dart';
import 'package:client/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:client/theme/constants.dart';
import 'package:client/components/CustomTextField.dart';
import 'package:client/components/CustomButton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:client/features/auth/providers/auth_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final nameController = TextEditingController();
  bool acceptTerms = false;
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final isLoading = authProvider.isLoading;

    return Scaffold(
      backgroundColor: bgLogin,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Create Account',
                    style: GoogleFonts.notoSans(
                      color: Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  CustomTextInput(
                    hintText: "Your full name",
                    controller: nameController,
                    label: "Full Name",
                  ),
                  const SizedBox(height: 24),
                  CustomTextInput(
                    hintText: "Your username",
                    controller: usernameController,
                    label: "Username",
                  ),
                  const SizedBox(height: 24),
                  CustomTextInput(
                    hintText: "Your email address",
                    controller: emailController,
                    label: "Email",
                  ),
                  const SizedBox(height: 16),
                  CustomTextInput(
                    hintText: "must be at least 8 characters",
                    isPassword: true,
                    controller: passwordController,
                    label: "Password",
                    obscureText: !isPasswordVisible,
                    onToggleVisibility: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Checkbox(
                        value: acceptTerms,
                        onChanged: (value) {
                          setState(() {
                            acceptTerms = value ?? false;
                          });
                        },
                        fillColor: WidgetStateProperty.all(primary),
                        side: BorderSide(color: primary),
                        shape: CircleBorder(side: BorderSide(color: primary)),
                        checkColor: Colors.white,
                      ),
                      const Expanded(
                        child: Text("I accept the terms and privacy policy"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Custombutton(
                    text: isLoading ? "Loading..." : "Create Account",
                    disabled: isLoading,
                    onPressed: () async {
                      if (!acceptTerms) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "You must accept the Terms & Privacy Policy",
                            ),
                          ),
                        );
                        return;
                      }

                      await authProvider.register(
                        username: usernameController.text.trim(),
                        name: nameController.text.trim(),
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );

                      if (authProvider.error == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Register successful!')),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(authProvider.error!)),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(color: Colors.grey[300], thickness: 2),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Or Register with',
                          style: GoogleFonts.notoSans(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(color: Colors.grey[300], thickness: 2),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        style: IconButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.grey[300]!),
                          ),
                          minimumSize: const Size(80, 48),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        icon: SvgPicture.asset(
                          'assets/google-icon.svg',
                          width: 14,
                          height: 14,
                        ),
                        onPressed: () {},
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        style: IconButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.grey[300]!),
                          ),
                          minimumSize: const Size(80, 48),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        icon: Icon(Icons.facebook, color: Colors.blue),
                        onPressed: () {},
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        style: IconButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.grey[300]!),
                          ),
                          minimumSize: const Size(80, 48),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        icon: Icon(Icons.apple, color: Colors.black),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: GoogleFonts.notoSans(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Log in",
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
