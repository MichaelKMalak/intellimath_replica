import 'package:flutter/material.dart';
import 'package:intellimath_replica/presentation/features/main_page/main_page.dart';
import 'package:provider/provider.dart';

import 'application/providers/_providers.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: getProviders(),
      child: MaterialApp(
        title: 'Intellimath',
        theme: ThemeData.dark().copyWith(
          canvasColor: Colors.black,
          scaffoldBackgroundColor: Colors.black,
        ),
        home: const MainPage(),
        supportedLocales: const [Locale('en')],
        localizationsDelegates: getLocalizationsDelegates(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  List<LocalizationsDelegate<dynamic>> getLocalizationsDelegates() {
    return const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ];
  }
}
