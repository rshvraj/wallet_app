import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wallet_app/utilities/direct_login.dart';
import 'package:wallet_app/utilities/sign_in_page.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    // options: FirebaseOptions(
    //   apiKey: 'AIzaSyArmcl8RQGbVdhLXoo8yG7y5zND43CusAg',
    //   appId: '1:832400551769:web:0d56db6ce257c75e1e2648',
    //   messagingSenderId: '832400551769',
    //   projectId: 'wallet-aap',
    // ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbapp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Raleway'),
            home: FutureBuilder(
              future: _fbapp,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print('You Have an error! ${snapshot.error.toString()}');
                  return const Text('Something Went Wrong!');
                } else if (snapshot.hasData) {
                  return AnimatedSplashScreen(
                    splash: 'assets/images/logo.png',
                    pageTransitionType: PageTransitionType.bottomToTop,
                    duration: 3000,
                    nextScreen: Login(),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
            // AnimatedSplashScreen(splash: 'assets/images/logo2.gif',
            //   pageTransitionType: PageTransitionType.bottomToTop,
            //   duration: 3000,
            //   nextScreen: MyHomePage(),
            // )
            ));
  }
}
