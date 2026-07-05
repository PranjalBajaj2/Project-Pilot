import 'package:projectpilot/features/models/clients/add_client_screen.dart';

import '../Screens/forgot_password_screen.dart';
import '../Screens/login_screen.dart';
import '../Screens/register_screen.dart';
import '../Screens/splash_screen.dart';
import '../features/auth/models/client_model.dart';
import '../features/dashboard.dart';
import '../features/home/screens/main_screen.dart';
import '../features/models/clients/edit_client_screen.dart';
import 'route_names.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouteNames.splash,

  routes: [
    GoRoute(
      path: RouteNames.splash,
      builder: (context, state) => const Splashscreen(),
    ),

    GoRoute(
      path: RouteNames.login,
      builder: (context, state) => const LoginScreen(),
    ),

    GoRoute(
      path: RouteNames.register,
      builder: (context, state) => const RegisterScreen(),
    ),

    GoRoute(
      path: RouteNames.forgotPassword,
      builder: (context, state) => const ForgotPasswordScreen(),
    ),

    GoRoute(
      path: RouteNames.dashboard,
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: RouteNames.main,
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: RouteNames.addClient,
      builder: (context, state) => const AddClientScreen(),
    ),
    // GoRoute(
    //   path: '/client-details',
    //   builder: (context, state) {
    //     final client = state.extra as ClientModel;
    //     return ClientDetailsScreen(client: client);
    //   },
    // ),

    GoRoute(
      path: '/edit-client',
      builder: (context, state) {
        final client = state.extra as ClientModel;
        return EditClientScreen(client: client);
      },
    ),
  ],
);
