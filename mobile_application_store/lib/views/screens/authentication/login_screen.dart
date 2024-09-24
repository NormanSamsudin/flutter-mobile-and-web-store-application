import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_application_store/controllers/auth_controller.dart';
import 'package:mobile_application_store/views/screens/authentication/register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = new AuthController();
  late String email;
  late String password;
  bool isLoading = false;

  loginUser() async {
    setState(() {
      isLoading = true;
    });
    await _authController
        .signInUsers(context: context, email: email, password: password)
        .whenComplete(() {
      _formKey.currentState!.reset();
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.97),
        body: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login Your Account',
                    style: GoogleFonts.getFont(
                      'Lato',
                      color: const Color(0xFF0d120E),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.2,
                      fontSize: 23,
                    ),
                  ),
                  Text(
                    'To explore the world exclusives',
                    style: GoogleFonts.getFont(
                      'Lato',
                      color: const Color(0xFF0d120E),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.2,
                      fontSize: 14,
                    ),
                  ),
                  Image.asset(
                    'assets/images/Illustration.png',
                    width: 200,
                    height: 200,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Email',
                      style: GoogleFonts.getFont(
                        color: const Color(0xFF0d120E),
                        'Nunito Sans',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email is required';
                      } else if (!RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                          .hasMatch(value)) {
                        return 'Invalid email format';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9)),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        labelText: 'Enter your email',
                        labelStyle: GoogleFonts.getFont('Nunito Sans',
                            fontSize: 14, letterSpacing: 0.1),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(
                            'assets/icons/email.png',
                            width: 20,
                            height: 20,
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Password',
                      style: GoogleFonts.getFont(
                        color: const Color(0xFF0d120E),
                        'Nunito Sans',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password is required';
                      } else if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9)),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        labelText: 'Enter your password',
                        labelStyle: GoogleFonts.getFont('Nunito Sans',
                            fontSize: 14, letterSpacing: 0.1),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(
                            'assets/icons/password.png',
                            width: 20,
                            height: 20,
                          ),
                        ),
                        suffixIcon: const Icon(Icons.visibility)),
                  ),
                  SizedBox(
                    height: 120,
                  ),
                  InkWell(
                    child: Container(
                      width: 319,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          gradient: LinearGradient(
                              colors: [Color(0xFF102DE1), Color(0xCC0D6EFF)])),
                      child: Center(
                        child: isLoading
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Sign in',
                                style: GoogleFonts.getFont(
                                    color: Colors.white,
                                    'Lato',
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.2,
                                    fontSize: 17),
                              ),
                      ),
                    ),
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        loginUser();
                        debugPrint("Sign in");
                      } else {
                        debugPrint('failed');
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Need an account',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),
                      ),
                      InkWell(
                        child: Text(
                          ' Sign up',
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF103DE5),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return RegisterScreen();
                            }),
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
