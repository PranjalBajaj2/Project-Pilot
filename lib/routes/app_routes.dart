import 'package:projectpilot/features/auth/models/payment_model.dart';
import 'package:projectpilot/features/auth/models/project_model.dart';
import 'package:projectpilot/features/auth/models/user_model.dart';
import 'package:projectpilot/features/models/clients/add_client_screen.dart';
import 'package:projectpilot/features/models/payments/payment_edit_screen.dart';
import 'package:projectpilot/features/models/payments/payment_form_screen.dart';
import 'package:projectpilot/features/models/profile/change_password_screen.dart';
import 'package:projectpilot/features/models/profile/edit%20_profile_screen.dart';
import 'package:projectpilot/features/models/projects/project_edit_screen.dart';
import 'package:projectpilot/shared/profile_widgets/info_tile.dart';
import 'package:projectpilot/shared/profile_widgets/theme_selector.dart';

import '../Screens/forgot_password_screen.dart';
import '../Screens/login_screen.dart';
import '../Screens/register_screen.dart';
import '../Screens/splash_screen.dart';
import '../features/auth/models/client_model.dart';
import '../features/dashboard.dart';
import '../features/home/screens/main_screen.dart';
import '../features/models/clients/edit_client_screen.dart';
import '../features/models/projects/project_form_screen.dart';
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
    GoRoute(
      path: RouteNames.addProject,
      builder: (context, state) => const AddProjectScreen(),
    ),
    GoRoute(
      path: RouteNames.addPayment,
      builder: (context, state) => const AddPaymentScreen(),
    ),
    GoRoute(
      path: '/edit-client',
      builder: (context, state) {
        final client = state.extra as ClientModel;
        return EditClientScreen(client: client);
      },
    ),
    GoRoute(
      path: '/edit-project',
      builder: (context, state) {
        final project = state.extra as ProjectModel;
        return EditProjectScreen(project: project);
      },
    ),
    GoRoute(
      path: '/edit-payment',
      builder: (context, state) {
        final paymemt = state.extra as PaymentModel;
        return EditPaymentScreen(payment: paymemt);
      },
    ),
    GoRoute(
      path: '/edit-profile',
      builder: (context, state) {
        final profile = state.extra as UserModel;
        return EditProfileScreen(user: profile);
      },
    ),
    GoRoute(
      path: '/change-password',
      builder: (context, state) => ChangePasswordScreen(),
    ),
    GoRoute(path: '/profile', builder: (context, state) => ProfileInfo()),
    GoRoute(path: '/theme', builder: (context, state) => AppearanceScreen()),
  ],
);
