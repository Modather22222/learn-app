import 'package:flutter/material.dart';
import 'package:learn_app/appwrite_service.dart';
import 'package:learn_app/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Appwrite service after Flutter bindings are ready.
  final appwriteService = AppwriteService();

  runApp(
    AppwriteProvider(appwriteService: appwriteService, child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(),
    );
  }
}
