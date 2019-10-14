import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jasarevic_arnela/providers/images_provider.dart';
import 'package:provider/provider.dart';
import 'images/images_list.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        builder: (context) => ImagesProvider(),
        child: MaterialApp(
          title: 'Arnela Jasarevic',
          theme: ThemeData(
            // This is the theme of application.
            primarySwatch: Colors.deepOrange,
          ),
          home: MainPage(),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            FlutterI18nDelegate(useCountryCode: false, fallbackFile: 'en'),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [const Locale('en')],
          // disable OS level text scaling
          builder: (context, child) => MediaQuery(
              child: child,
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1)),
        ),
      );
}
