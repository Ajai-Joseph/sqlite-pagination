import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_list_scroll/src/presentation/view/splash_screen/splash_screen.dart';

void main()  {
  WidgetsFlutterBinding.ensureInitialized();
 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

