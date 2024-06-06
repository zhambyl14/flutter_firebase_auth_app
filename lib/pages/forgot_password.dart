import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> resetPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );

      // Show a more informative success message
      Utils.showSnackBar('Password reset email sent. Please check your inbox (and spam folder).');

      // Navigate back to the login screen
      Navigator.pushReplacementNamed(context, '/login');

    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase errors for better user feedback
      if (e.code == 'user-not-found') {
        Utils.showSnackBar('No user found with that email.');
      } else if (e.code == 'invalid-email') {
        Utils.showSnackBar('Please enter a valid email address.');
      } else {
        // Generic error message for other Firebase issues
        Utils.showSnackBar('Error sending password reset email: ${e.message}');
      }
    } catch (e) {
      // Catch any other unexpected errors
      Utils.showSnackBar('An error occurred: ${e.toString()}');
    }
  }

  String? emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email cannot be empty';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(email)) {
      return 'Enter a valid email';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Text('Reset Password'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(labelText: 'Email'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: emailValidator,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              icon: const Icon(Icons.email_outlined),
              label: const Text(
                'Reset Password',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  resetPassword(context);
                }
              },
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text('Back to Login'),
            ),
          ],
        ),
      ),
    ),
  );
}

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String? text) {
    if (text == null) return;

    final snackBar = SnackBar(content: Text(text));
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}