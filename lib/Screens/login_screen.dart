import 'package:farmfusion/Routes/routes_name.dart';
import 'package:farmfusion/Widgets/adminNavbar.dart';
import 'package:farmfusion/Widgets/navbar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Widgets/registration_widget/customTextFeild.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _isLoading = false.obs;

  final _auth = FirebaseAuth.instance;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      _isLoading.value = true;

      try {
        final newUser = await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        if (newUser != null) {
          final uid = newUser.user!.uid;

          // Fetch user's role from Firebase Realtime Database
          final dbRef = FirebaseDatabase.instance.ref().child("Users").child("role");
          final event = await dbRef.once();
          final Map<dynamic, dynamic> roles = event.snapshot.value as Map<dynamic, dynamic>;

          if (roles.containsValue(uid)) {
            String? role;
            roles.forEach((key, value) {
              if (value == uid) {
                role = key;
              }
            });

            if (role == "Admin") {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => adminNavbar()),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Navbar()),
              );
            }
          } else {
            Get.snackbar('ERROR', 'Role not found for this user.');
          }
        }
      } on FirebaseAuthException catch (e) {
        Get.snackbar('LOGIN FAILED!', 'Enter valid email and password',
            backgroundColor: Colors.white, colorText: Colors.red.shade500);
      } finally {
        _isLoading.value = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'LOG IN',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        label: 'Email',
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      CustomTextField(
                        label: 'Password',
                        controller: _passwordController,
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Get.toNamed(RoutesName.forgetPasswordScreen.toString());
                              },
                              child: Text('Forget Password'),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16),
                      Obx(() => _isLoading.value
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                        onPressed: _login,
                        child: Text(
                          'Log In',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          textStyle: TextStyle(fontSize: 18),
                        ),
                      ),
                      ),

                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have any account?"),
                          TextButton(
                            onPressed: () {
                              Get.toNamed(RoutesName.registrationScreen.toString());
                            },
                            child: Text('Register here.'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
