import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../Core/Constant/color_app.dart';
import '../../../Home/home_page.dart';
import '../Widgets/custom_text_form_feild.dart';

class SignupPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  SignupPage({super.key});

  // Function to handle user signup
  Future<void> _signup(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            )
            .then((value) => _navigateToHomePage(context));
      } on FirebaseAuthException catch (e) {
        _showErrorSnackBar(context, _getFirebaseAuthErrorMessage(e.code));
      } catch (e) {
        _showErrorSnackBar(context, 'An unexpected error occurred.');
      }
    } else {
      _showErrorSnackBar(context, 'Please enter valid information.');
    }
  }

  // Function to navigate to the HomePage
  void _navigateToHomePage(BuildContext context) {
    if (context.mounted) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomePage(emailTitle: emailController.text),
      ));
    }
  }

  // Function to display error messages
  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Poppins SemiBold',
              color: ColorApp.whitePink,
            ),
          ),
        ),
      ),
    );
  }

  // Function to handle FirebaseAuth errors
  String _getFirebaseAuthErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      default:
        return 'An error occurred. Please try again.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.lightPink,
      appBar: _buildAppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildSignupForm(context),
        ),
      ),
    );
  }

  // Build AppBar widget
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: ColorApp.whitePink,
      title: const Text(
        'Sign UP',
        style: TextStyle(
          color: ColorApp.purple,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Build Signup form widget
  Form _buildSignupForm(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextFormFeild(hintText: 'email', controller: emailController),
          const SizedBox(height: 15),
          CustomTextFormFeild(
              hintText: 'password', controller: passwordController),
          const SizedBox(height: 15),
          _buildSignupButton(context),
        ],
      ),
    );
  }

  // Build Signup button widget
  ElevatedButton _buildSignupButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: ColorApp.whitePink),
      onPressed: () => _signup(context),
      child: const Text(
        'Sign up',
        style: TextStyle(
          color: ColorApp.purple,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
