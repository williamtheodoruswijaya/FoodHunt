
import 'package:client/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:client/theme/constants.dart';
import 'package:client/components/CustomTextField.dart';
import 'package:client/components/CustomButton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  bool isLoading = false;
  bool isPasswordVisible = false;

  // future enhancements: form validation, error handling, actual authentication logic


  @override
  Widget build(BuildContext context) {
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
                )
              ]
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Log in',
                    style: GoogleFonts.notoSans(
                      color: Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Email box
                  const SizedBox(height: 24),
                  CustomTextInput(hintText: "Your email address", controller: emailcontroller, label: "Email"),
                  const SizedBox(height: 16),
                  // Password box
                  CustomTextInput(
                    hintText: "Your password", 
                    isPassword: true, 
                    controller: passwordcontroller, 
                    label: "Password",
                    obscureText: !isPasswordVisible,
                    onToggleVisibility: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Handle forgot password
                      },
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.notoSans(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  // Login button
                  Custombutton(
                    text: isLoading ? "Logging you in..." : "Log in", 
                    disabled: isLoading, 
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                      });
                      // Simulate a login delay
                      Future.delayed(const Duration(seconds: 2), () {
                        setState(() {
                          isLoading = false;
                        });
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Log in successful!'))
                        );
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  // Other Options
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey[300],
                          thickness: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Or Log in with',
                          style: GoogleFonts.notoSans(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey[300],
                          thickness: 2,
                        ),
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
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)
                        ),
                        icon: SvgPicture.asset('assets/google-icon.svg', 
                          width: 14,
                          height: 14),
                        onPressed: () {
                          // Handle Google login
                          },
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        style: IconButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.grey[300]!),
                            ),
                          minimumSize: const Size(80, 48), 
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)
                        ),
                        icon: Icon(Icons.facebook, color: Colors.blue),
                        onPressed: () {
                          // Handle Facebook login
                        },
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        style: IconButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.grey[300]!),
                            ),
                          minimumSize: const Size(80, 48), 
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)
                        ),
                        icon: Icon(Icons.apple, color: Colors.black),
                        onPressed: () {
                          // Handle Apple login
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?", style: GoogleFonts.notoSans(color: Colors.black, fontSize: 14)),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterPage()),
                          );
                        },
                        child: Text(
                          "Sign up",
                          style: GoogleFonts.inter(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600, decoration: TextDecoration.underline)
                        ),
                      ),
                    ],
                  )
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}
      