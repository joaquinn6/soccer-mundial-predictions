import 'package:flutter/material.dart';
import 'themes.dart';
import 'package:provider/provider.dart';
import './providers/provider_events.dart';
import './providers/provider_users.dart';
import 'views/home_page.dart';
import 'views/users_points_pages.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => EventsRequests()),
    ChangeNotifierProvider(create: (_) => UserRequest())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soccer Predictions',
      theme: lightTheme,
      darkTheme: darkTheme,
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (BuildContext context) => const MyHomePage(),
        "/user-table": (BuildContext context) => const TableUserPage()
      },
    );
  }
}
