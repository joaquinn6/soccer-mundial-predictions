import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectionUtil {
  Future<bool> checkInternetConnection() async {
    return await InternetConnectionChecker().hasConnection;
  }
}
