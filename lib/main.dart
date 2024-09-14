import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:task_login_app/Pages/Auth/LoginPage/Screens/login_page.dart';
import 'package:task_login_app/Pages/Home/home_page.dart';

import 'Core/Constant/color_app.dart';
import 'Data/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const TaskLOgin(),
  ));
}

class TaskLOgin extends StatelessWidget {
  const TaskLOgin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        title: 'Task Login',
        theme: ThemeData(
          primaryColor: ColorApp.whitePink,
          useMaterial3: true,
          scaffoldBackgroundColor: ColorApp.lightPink,
          appBarTheme: const AppBarTheme(
            backgroundColor: ColorApp.lightPink,
          ),
        ),
        home: LoginPage());
  }

  Widget _handleAuthState() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return HomePage(emailTitle: user.email ?? '');
    } else {
      return LoginPage();
    }
  }
}
