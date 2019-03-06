/* This file is part of Pferdepass.                                           */
/*                                                                            */
/* Pferdepass is free software: you can redistribute it and/or modify         */
/* it under the terms of the GNU General Public License as published by       */
/* the Free Software Foundation, either version 3 of the License, or          */
/* (at your option) any later version.                                        */
/*                                                                            */
/* Pferdepass is distributed in the hope that it will be useful,              */
/* but WITHOUT ANY WARRANTY; without even the implied warranty of             */
/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the              */
/* GNU General Public License for more details.                               */
/*                                                                            */
/* You should have received a copy of the GNU General Public License          */
/* along with Pferdepass.  If not, see <https://www.gnu.org/licenses/>.       */

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
