import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pferdepass/generated/i18n.dart' as i18n;
import 'package:pferdepass/ui/mainscreen.dart';

void main() {
  runApp(myApp());
}

Widget myApp() => MaterialApp(
      onGenerateTitle: (BuildContext context) => i18n.S.of(context).title,
      home: MainScreen(),
      localizationsDelegates: const [
        i18n.S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: i18n.S.delegate.supportedLocales,
    );
