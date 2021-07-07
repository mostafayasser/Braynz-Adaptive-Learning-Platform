import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:graduation_project/views/splashScreen.dart';

import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import 'helpers/routes/route.dart';
import 'helpers/utils/provider_setup.dart';
import 'services/preference/preference.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Preference.init();

  runApp(MyApp());
}

// This widget is the root of your application.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return OverlaySupport(
      child: MultiProvider(
          providers: providers,
          child: MaterialApp(
            routes: Routes.routes,
            theme: ThemeData(
              textTheme: GoogleFonts.nunitoSansTextTheme(),
              primaryColor: Color(0xFF3C096C),
            ),
            home: SplashView(),
            debugShowCheckedModeBanner: false,
            /* supportedLocales: [const Locale('en'), const Locale('ar')],
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ], */
          )),
    );
  }
}
