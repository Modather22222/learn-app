import 'package:appwrite/appwrite.dart';
import 'package:flutter/widgets.dart';

class AppwriteService {
  static const String endpoint = 'https://fra.cloud.appwrite.io/v1';
  static const String projectId = '68ea56c00025f5e9e6f6';

  late final Client client;
  late final Account account;

  AppwriteService() {
    client = Client()
      ..setEndpoint(endpoint)
      ..setProject(projectId);
    account = Account(client);
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await account.create(
        userId: ID.unique(),
        name: name,
        email: email,
        password: password,
      );
    } on AppwriteException {
      rethrow;
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      await account.createEmailPasswordSession(
        email: email,
        password: password,
      );
    } on AppwriteException {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await account.deleteSession(sessionId: 'current');
    } on AppwriteException {
      rethrow;
    }
  }

  Future<bool> checkSession() async {
    try {
      await account.get();
      return true;
    } on AppwriteException {
      return false;
    }
  }
}

class AppwriteProvider extends InheritedWidget {
  final AppwriteService appwriteService;

  const AppwriteProvider({
    super.key,
    required this.appwriteService,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  static AppwriteService of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<AppwriteProvider>()!
        .appwriteService;
  }
}
