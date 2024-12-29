import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class Injection {
  static final http.Client client = http.Client();
  static final List<BlocProvider> providerList = [];
}
