import 'package:flutter/material.dart';

import '../../../common/constant/path_string.dart';
import '../../../common/constant/img_assets.dart';
import '../../../common/services/auth_service.dart';
import '../../widgets/snackbar_widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;
  bool isLoading = false;

  AuthService authService = AuthService();

  Future<void> signUpUser() async {
    String email = emailController.text;
    String password = passwordController.text;
    String name = nameController.text;

    if (!validate()) return;

    try {
      setState(() {
        isLoading = true;
      });
      await authService.signUp(name: name, email: email, password: password);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Account created successfully!")));

      Navigator.pushReplacementNamed(context, PathString.loginScreen);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar('Error: ${e.toString()}'),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  bool validate() {
    bool vaild = true;

    String email = emailController.text;
    String password = passwordController.text;
    String name = nameController.text;

    if (email.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(snackBar('Enter Email'));
      vaild = false;
    }
    if (name.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(snackBar('Enter Name'));
      vaild = false;
    }
    if (password.isEmpty || password.length < 6) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(snackBar('Enter length must be 6 charat long'));
      vaild = false;
    }

    return vaild;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    Assets.icon,
                    height: 100,
                  ),
                ),
                Center(
                    child: Text(
                  'Adhicine',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
                SizedBox(height: 50),
                Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(labelText: "Name"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.email),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(labelText: "Email"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.lock),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                            labelText: "Password",
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscurePassword = !obscurePassword;
                                });
                              },
                              icon: Icon(obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            )),
                        obscureText: obscurePassword,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                isLoading
                    ? CircularProgressIndicator()
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.symmetric(vertical: 15),
                          ),
                          onPressed: signUpUser,
                          child: Text(
                            "Create Account",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, PathString.loginScreen);
                      },
                      child: RichText(
                          text: TextSpan(
                              text: 'Already have account ',
                              style: TextStyle(color: Colors.black),
                              children: [
                            TextSpan(
                              text: 'Login',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ]))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
