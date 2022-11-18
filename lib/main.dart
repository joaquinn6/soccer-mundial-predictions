import 'package:app_mundial/views/user_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'themes.dart';
import 'package:provider/provider.dart';
import './providers/provider_events.dart';
import './providers/provider_users.dart';
import 'views/home_page.dart';
import 'views/users_points_pages.dart';
import 'views/about.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs =await SharedPreferences.getInstance();
  var userId=prefs.getString("userId")??'';
  var isLogged=userId!='';
  await Future.delayed(const Duration(seconds: 2));
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => EventsRequests()),
    ChangeNotifierProvider(create: (context) => UserRequest())
  ], child: MyApp(isLogged)));
}

class MyApp extends StatelessWidget {
  var isLogged;

  MyApp(this.isLogged, {super.key});
  
  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UserRequest>(context, listen: false);
    usersProvider.checkLogin();
    return MaterialApp(
      title: 'Soccer Predictions',
      theme: lightTheme,
      darkTheme: darkTheme,
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (BuildContext context) =>
            isLogged ? const MyHomePage() : const UserPage(),
        "/user-table": (BuildContext context) => const TableUserPage(),
        "/homepage": (BuildContext context) => const MyHomePage(),
        "/about": (BuildContext context) => const AboutPage()
      },
    );
  }
}
