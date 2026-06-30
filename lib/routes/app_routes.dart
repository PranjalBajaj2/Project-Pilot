import '../Screens/Splash/SplashScreen.dart';
import '../Screens/login_screen.dart';
import '../Screens/register_screen.dart';
import '../features/dashboard.dart';
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

    // GoRoute(
    //   path: RouteNames.forgotPassword,
    //   builder: (context, state) => const ForgotPasswordScreen(),
    // ),

    GoRoute(
      path: RouteNames.dashboard,
      builder: (context, state) => const DashboardScreen(),
    ),
  ],
);