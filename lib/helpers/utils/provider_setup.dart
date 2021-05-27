// provider_setup.dart
import 'package:graduation_project/services/api/api.dart';
import 'package:graduation_project/services/api/http_api.dart';
import 'package:graduation_project/services/auth/authentication_service.dart';
import 'package:graduation_project/services/connectivity/connectivity_service.dart';
import 'package:graduation_project/services/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

const bool USE_FAKE_IMPLEMENTATION = true;

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders,
];

List<SingleChildWidget> independentServices = [
  Provider<Api>(create: (c) => HttpApi()),
  ChangeNotifierProvider<ConnectivityService>(
      create: (context) => ConnectivityService()),
];

List<SingleChildWidget> dependentServices = [
  ProxyProvider<Api, AuthenticationService>(
      update: (context, api, authenticationService) =>
          AuthenticationService(api: api)),
  /* ProxyProvider<AuthenticationService, NotificationService>(
      update: (context, auth, notificationService) =>
          NotificationService(auth: auth)), */
];

List<SingleChildWidget> uiConsumableProviders = [
  ChangeNotifierProvider(create: (_) => ThemeProvider()),
  //ChangeNotifierProvider<AppLanguageModel>(create: (_) => AppLanguageModel()),
];
