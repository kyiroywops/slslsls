import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travelcheck/screens/screens/InicialHomeScreen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
       GoRoute(
      path: '/',
      pageBuilder: (context, state) {
        return CustomTransitionPage<void>(
          key: state.pageKey,
          child: const InicialHomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },  
    ),
   


  ]




);
