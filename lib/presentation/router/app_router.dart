import 'package:ae_task_app/data/models/event.dart';
import 'package:ae_task_app/presentation/admin/create_event.dart';
import 'package:ae_task_app/presentation/auth/login.dart';
import 'package:ae_task_app/presentation/auth/signup.dart';
import 'package:ae_task_app/presentation/events/all_events.dart';
import 'package:ae_task_app/presentation/events/event_details.dart';
import 'package:ae_task_app/presentation/home/bottom_nav_screen.dart';
import 'package:ae_task_app/presentation/map_screen.dart';
import 'package:ae_task_app/presentation/splash.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (homeContext) {
          return SplashScreen();
        });
      case '/map':
        return MaterialPageRoute(builder: (_) {
          return MapScreen();
        });
      case '/home':
        return MaterialPageRoute(builder: (_) {
          return BottomNavScreen();
        });
      case '/login':
        return MaterialPageRoute(builder: (_) {
          return LoginPage();
        });

      case '/signUp':
        return MaterialPageRoute(builder: (_) {
          return SignUpPage();
        });
      case '/newEvent':
        return MaterialPageRoute(builder: (_) {
          return CreateEventPage();
        });
      case '/allEvents':
        return MaterialPageRoute(builder: (_) {
          return AllEventsPage();
        });

      case '/eventDetails':
        return MaterialPageRoute(builder: (_) {
          return EventDetailsScreen(event: (settings.arguments as Event));
        });

      default:
        return MaterialPageRoute(builder: (_) {
          return Container();
        });
    }
  }
}
