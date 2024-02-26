import 'package:go_router/go_router.dart';

import 'package:my_challenge_app/screens/screens.dart';



final appRouter = GoRouter(
  initialLocation: '/login',
  routes:[

    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/login',
      name: LoginScreen.name,
      builder: (context, state) => const LoginScreen()
    ),
    GoRoute(
      path: '/register',
      name: RegisterScreen.name,
      builder: (context, state) => const RegisterScreen(),
    ),

  ]
);


