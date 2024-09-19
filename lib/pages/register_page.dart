import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:chat_app/components/square_tile.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  // text editing controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // tap to go to login page
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

// functons
  // signUp method
  void signUp(BuildContext context) async {
    // get auth service
    final auth = AuthService();

    // password match -> create user
    if (_passwordController.text == _confirmPasswordController.text) {
      // try
      try {
        await auth.signUpWithEmailPassword(
          _emailController.text.trim(), // Trim to avoid whitespace errors
          _passwordController.text.trim(),
        );
      }
      // catch any errors and display in a dialog
      catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Login Failed'),
            content: Text(e.toString()), // Show the error message
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context), // Close the dialog
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
    // password don't match -> tell user to fix
    else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Passwords don't match!"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 150),
          
                // logo
                Icon(
                  Icons.message,
                  color: Theme.of(context).colorScheme.primary,
                  size: 80,
                ),
          
                const SizedBox(height: 50),
          
                // welcome back message
                Text(
                  "Let's create an account for you",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 16,
                  ),
                ),
          
                const SizedBox(height: 25),
          
                // email textfield
                MyTextfield(
                  controller: _emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
          
                const SizedBox(height: 10),
          
                // password textfield
                MyTextfield(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
          
                const SizedBox(height: 10),
          
                // confirm password textfield
                MyTextfield(
                  controller: _confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),
          
                const SizedBox(height: 25),
          
                // sign up button
                MyButton(
                  onTap: () => signUp(context),
                  text: "Sign Up",
                ),
          
                const SizedBox(height: 25),
          
                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Or continue with",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.inversePrimary),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
          
                const SizedBox(height: 25),
          
                // Google sign in button
                SquareTile(
                  onTap: () => AuthService().signInWithGoogle(),
                  imagePath: 'lib/images/Google.png',
                ),
          
                const SizedBox(height: 25),
          
                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style:
                          TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: onTap,
                      child: const Text(
                        "Login Now",
                        style: TextStyle(
                          color: Colors.blue,
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
    );
  }
}
