
import 'package:client/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:client/theme/constants.dart';
import 'package:client/components/CustomTextField.dart';
import 'package:client/components/CustomButton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';



class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final usernamecontroller = TextEditingController();
  bool acceptTerms = false;
  bool isLoading = false;
  bool isPasswordVisible = false;

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // future enhancements: form validation, error handling, actual authentication logic
  // Future<void> registerUser(BuildContext context) async {
  //   if (emailController.text.isEmpty || passwordController.text.isEmpty || usernameController.text.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Please fill in all required fields')),
  //     );
  //     return;
  //   }
  //   // Terms & Privacy Policy Validation
  //   if (!_acceptTerms){
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("You must accept the Terms & Privacy Policy"))
  //     );
  //     return;
  //   }
    
  //   try {
  //     setState(() {
  //       isLoading = true;
  //     });
  //     await _auth.createUserWithEmailAndPassword(
  //       email: emailController.text.trim(),
  //       password: passwordController.text.trim(),
  //     );

  //     await _firestore.collection('users').doc(emailController.text.trim()).set({
  //       'profile': {
  //         'email': emailController.text.trim(),
  //         'username': usernameController.text.trim(),
  //       },
  //     });

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Account created successfully')),
  //     );

  //     Navigator.pushReplacementNamed(context, '/login'); // Go back to login
  //   } on FirebaseAuthException catch (e) {
  //     String error = switch (e.code) {
  //       'email-already-in-use' => 'The email is already in use.',
  //       'invalid-email' => 'Invalid email address.',
  //       'weak-password' => 'Password is too weak.',
  //       _ => 'Something went wrong. Try again.',
  //     };

  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('An unexpected error occurred.')),
  //     );
  //   } finally {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

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
                    'Create Account',
                    style: GoogleFonts.notoSans(
                      color: Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Username box
                  CustomTextInput(hintText: "Your username", controller: usernamecontroller, label: "Username"),
                  const SizedBox(height: 24),
                  // Email box
                  CustomTextInput(hintText: "Your email address", controller: emailcontroller, label: "Email"),
                  const SizedBox(height: 16),
                  // Password box
                  CustomTextInput(
                    hintText: "must be at least 8 characters", 
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
                  Row(
                    children: [
                      Checkbox(
                        value: acceptTerms,
                        onChanged: (value){
                          setState(() {
                            acceptTerms = value ?? false;
                          });
                        },
                        fillColor: WidgetStateProperty.all(primary),
                        side: BorderSide(color: primary),
                        shape: CircleBorder(
                          side: BorderSide(color: primary),
                        ),
                        
                        checkColor: Colors.white,
                      ),
                      const Expanded(
                        child: Text("I accept the terms and privacy policy"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  // Register button
                  Custombutton(
                    text: isLoading ? "Loading..." : "Create Account", 
                    disabled: isLoading, 
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                      });
                      // Simulate a register delay
                      Future.delayed(const Duration(seconds: 2), () {
                        setState(() {
                          isLoading = false;
                        });
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Register successful!'))
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
                          'Or Register with',
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
                      Text("Already have an account?", style: GoogleFonts.notoSans(color: Colors.black, fontSize: 14)),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          );
                        },
                        child: Text(
                          "Log in",
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
      