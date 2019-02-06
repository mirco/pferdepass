import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pferdepass/ui/mainscreen.dart';

import 'generated/i18n.dart';

void main() {
  runApp(MaterialApp(
    onGenerateTitle: (BuildContext context) => S.of(context).title,
    title: 'Pferdepass',
    home: MainScreen(),
    localizationsDelegates: const [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: S.delegate.supportedLocales,
  ));
}
