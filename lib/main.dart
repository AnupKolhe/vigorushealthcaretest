import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vigorushealthcaretest/common/constant/path_string.dart';
import 'package:vigorushealthcaretest/views/screens/addmedicine/medicince_screen.dart';
import 'package:vigorushealthcaretest/views/screens/home/home_screen.dart';

import 'common/theme/theme.dart';
import 'common/theme/util.dart';
import 'firebase_options.dart';
import 'views/screens/auth/login_screen.dart';
import 'views/screens/auth/signup_screen.dart';
import 'views/screens/home/widget/user_profile_screen.dart';
import 'views/screens/reports/report_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Roboto", "Montserrat");

    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      title: 'Flutter Demo',

      debugShowCheckedModeBanner: false,
      darkTheme: theme.dark(),
      theme: theme.light(),
      initialRoute:
          PathString.homeScreen, // initialRoute: AppString.loginScreen,
      routes: {
        PathString.loginScreen: (context) => LoginScreen(),
        PathString.signupScreen: (context) => SignUp(),
        PathString.homeScreen: (context) => HomeScreen(),
        PathString.reportScreen: (context) => ReportScreen(),
        PathString.medicinceScreen: (context) => MedicinceScreen(),
        PathString.userProfileScreen: (context) => UserProfileScreen(),
      },
    );
  }
}
