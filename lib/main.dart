import 'package:app_mundial/views/user_page.dart';
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
    ChangeNotifierProvider(create: (context) => UserRequest())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final preferences = Provider.of<UserRequest>(context, listen: false);
    preferences.checkLogin();
    return MaterialApp(
      title: 'Soccer Predictions',
      theme: lightTheme,
      darkTheme: darkTheme,
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (BuildContext context) =>
            preferences.isLogged ? const MyHomePage() : const UserPage(),
        "/user-table": (BuildContext context) => const TableUserPage(),
        "/homepage": (BuildContext context) => const MyHomePage()
      },
    );
  }
}
