import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projectpilot/features/auth/providers/client_provider.dart';
import 'package:projectpilot/features/auth/providers/payment_provider.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'features/auth/providers/profile_provider.dart';
import 'features/auth/providers/project_provider.dart';
import 'firebase_options.dart';
import 'routes/app_routes.dart';
import 'features/auth/providers/auth_provider.dart';

void main() async {
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) {
            final provider = ClientProvider();
            provider.listenClients();
            return provider;
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            final provider = ProjectProvider();
            provider.listenProjects();
            return provider;
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            final provider = PaymentProvider();
            provider.listenPayments();
            return provider;
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            final provider = ProfileProvider();
            provider.loadProfile();
            return provider;
          }
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'ProjectPilot',
        theme: AppTheme.lightTheme,
        routerConfig: appRouter,
      ),
    );
  }
}