import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../Core/Constant/color_app.dart';
import '../../../Home/home_page.dart';
import '../../SignupPage/Screens/signup_page.dart';
import '../../SignupPage/Widgets/custom_text_form_feild.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginPage({super.key});

  // Function to handle user login
  Future<void> _login(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            )
            .then((value) => _navigateToHomePage(context));
      } on FirebaseAuthException catch (e) {
        _showErrorSnackBar(context, _getFirebaseAuthErrorMessage(e.code));
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

  // Function to display an error message
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

  // Function to handle error messages from FirebaseAuth
  String _getFirebaseAuthErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      case 'weak-password':
        return 'The password provided is too weak.';
      default:
        return 'An error occurred. Please try again.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.lightPink,
      appBar: buildAppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildForm(context),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: ColorApp.whitePink,
      title: const Text(
        'Sign IN',
        style: TextStyle(
          color: ColorApp.purple,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Form _buildForm(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextFormFeild(hintText: 'email', controller: emailController),
          const SizedBox(height: 15),
          CustomTextFormFeild(hintText: 'password', controller: passwordController),
          const SizedBox(height: 15),
          _buildSignInButton(context),
          _buildCreateAccountButton(context),
        ],
      ),
    );
  }

  ElevatedButton _buildSignInButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: ColorApp.whitePink),
      onPressed: () => _login(context),
      child: const Text(
        'Sign in',
        style: TextStyle(
          color: ColorApp.purple,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  ElevatedButton _buildCreateAccountButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: ColorApp.whitePink),
      onPressed: () {
        if (context.mounted) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SignupPage(),
          ));
        }
      },
      child: const Text(
        'Create Account',
        style: TextStyle(
          color: ColorApp.purple,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
