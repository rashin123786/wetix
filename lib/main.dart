import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wetix/controller/provider/auth_provider.dart';
import 'package:wetix/controller/provider/bottom_control.dart';

import 'package:wetix/controller/provider/cart_services.dart';
import 'package:wetix/view/splashScreen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BottomNavControll(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthController(),
        ),
        ChangeNotifierProvider(
          create: (context) => cartController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData().copyWith(
          scaffoldBackgroundColor: Colors.white,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
