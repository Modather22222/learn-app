import 'package:flutter/material.dart';
import 'package:learn_app/appwrite_service.dart';
import 'package:learn_app/home_screen.dart';
import 'package:learn_app/login_screen.dart';

void main() {
  runApp(
    AppwriteProvider(appwriteService: AppwriteService(), child: const MyApp()),
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
      home: FutureBuilder(
        future: AppwriteProvider.of(context).checkSession(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasData && snapshot.data!) {
            return const HomeScreen();
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
