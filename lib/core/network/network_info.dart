// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnection internetConnection;
  NetworkInfoImpl({
    required this.internetConnection,
  });

  @override
  Future<bool> get isConnected async =>
      await internetConnection.hasInternetAccess;
}
