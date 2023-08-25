import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai/view/test.dart';

import 'firebase_options.dart';
import 'view/base.dart';
import 'view/logoanimation.dart';
import 'view/onboarding.dart';
import 'viewmodel/bookmodels.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<MyFavoriteProvider>(
          create: (_) => MyFavoriteProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('us', 'US'),
      title: 'Kimiko',
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
            selectionColor: Color.fromARGB(88, 255, 126, 90), selectionHandleColor: Color.fromARGB(255, 255, 126, 90)),
        fontFamily: 'Worksans',
        colorScheme: const ColorScheme(
          onSurface: Color(0xFF767676),
          surface: Color(0xffEEEEEE),
          onPrimary: Colors.black,
          onSecondary: Colors.white,
          onBackground: Color(0xffFAFAFA),
          onError: Colors.white,
          brightness: Brightness.light,
          primary: Colors.white,
          secondary:  Color.fromARGB(255, 255, 126, 90),
          secondaryVariant: Color.fromARGB(255, 255, 80, 121),
          error: Colors.red,
          background: Colors.white,
        ),
        textTheme: TextTheme(
          titleLarge: const TextStyle(
            fontSize: 28.0,
          ),
          titleMedium: const TextStyle(fontSize: 24.0),
          titleSmall: const TextStyle(
            fontSize: 16.0,
          ),
          bodyLarge: TextStyle(
              fontSize: 14.0, color: Theme.of(context).colorScheme.onSurface),
          bodyMedium: const TextStyle(fontSize: 12.0),
          bodySmall: const TextStyle(
            fontSize: 10.0,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const EpubDispaly(),
      
       /* StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            if ( user == null || FirebaseAuth.instance.currentUser!.emailVerified == false) {
              return const Onboarding();
            } else {
              print(user.email);
              return const BaseScreen();
              
            }
          } else {
            return const LogoAnimation();
          }
        }),
      ) */
      routes: {'/basescreen': (context) => const BaseScreen()},
    );
  }
}
