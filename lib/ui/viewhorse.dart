import 'package:flutter/material.dart';
import 'package:pferdepass/backend/gender.dart';
import 'package:pferdepass/backend/horse.dart';
import 'package:pferdepass/backend/horseDB.dart';
import 'package:pferdepass/backend/tools.dart';
import 'package:pferdepass/backend/ueln.dart';
import 'package:pferdepass/generated/i18n.dart';
import 'package:pferdepass/ui/dateTimePicker.dart';

class ViewHorse extends StatefulWidget {
  @override
  _ViewHorseState createState() =>
      _ViewHorseState(key: key, horse: horse, horseDb: horseDb);

  ViewHorse({this.key, @required this.horse, @required this.horseDb})
      : super(key: key);

  final Key key;
  final Horse horse;
  final HorseDb horseDb;
}

class _ViewHorseState extends State<ViewHorse> {
  _ViewHorseState({this.key, @required this.horse, @required this.horseDb}) {
    assert(horse != null);
    assert(horseDb != null);
  }

  @override
  Widget build(BuildContext c) {
    var s = S.of(c);
    var widgetList = <Widget>[
      _buildTextFieldWidget(
        labelText: s.sportsname,
        content: horse.sportsName,
        callback: (String value) => horse.sportsName = value,
      ),
      _buildTextFieldWidget(
        labelText: s.breedname,
        content: horse.breedName,
        callback: (String value) => horse.breedName = value,
      ),
      _buildTextFieldWidget(
          labelText: s.ueln,
          content: horse.ueln,
          callback: (String value) {
            try {
              horse.ueln = Ueln.fromString(value);
            } on FormatException {}
          }),
      DateTimePicker(
        selectedDate: horse.dateOfBirth,
        selectDate: (DateTime date) {
          setState(() {
            horse.dateOfBirth = date;
          });
        },
        labelText: s.dateOfBirth,
      ),
      _buildDropdownButtonFieldWidget<Race>(
        labelText: s.race,
        items: raceStrings,
        value: horse.race,
        context: c,
        callback: (Race value) => horse.race = value,
      ),
      _buildDropdownButtonFieldWidget<Color>(
        labelText: s.color,
        items: colorStrings,
        value: horse.color,
        context: c,
        callback: (Color value) => horse.color = value,
      ),
      _buildDropdownButtonFieldWidget<genderType>(
          labelText: s.gender,
          items: Gender.genderStrings,
          value: horse.gender.gender,
          context: c,
          callback: (genderType value) {
            horse.gender = Gender(gender: value);
          }),
    ];

    return Scaffold(
      appBar: AppBar(
        title: TextField(
            controller: TextEditingController(text: horse.name ?? ''),
            onSubmitted: (String value) {
              setState(() {
                horse.name = value;
              });
            }),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              horseDb.saveDb();
              Navigator.pop(c, horse);
            }),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.delete),
              tooltip: s.delete_horse,
              onPressed: () {
                horseDb.remove(horse);
                Navigator.pop(c);
              }),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: widgetList,
          ),
        ),
      ),
    );
  }

  Widget _buildTextFieldWidget<T>({
    @required String labelText,
    var content = '',
    Widget onClicked,
    _HorseCallback<String> callback,
    BuildContext context,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
      ),
      controller: TextEditingController(
        text: () {
          content ??= '';
          assert(content != null);
          if (content is Localized) {
            return content.toLocalizedString(context);
          } else
            return content.toString();
        }(),
      ),
      onFieldSubmitted: (String value) {
        setState(() {
          callback(value);
        });
      },
    );
  }

  Widget _buildDropdownButtonFieldWidget<T>(
      {@required String labelText,
      @required Map<T, LocalizedString> items,
      T value,
      _HorseCallback<T> callback,
      @required BuildContext context}) {
    List<DropdownMenuItem<T>> dropdownList = [];
    for (var i in items.keys) {
      dropdownList
          .add(DropdownMenuItem(value: i, child: Text(items[i](context))));
    }
    var r = DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(labelText: labelText),
      items: dropdownList,
      onChanged: (T value) {
        setState(() {
          callback(value);
        });
      },
    );

    return r;
  }

  final Key key;
  final Horse horse;
  final HorseDb horseDb;
  final _formKey = GlobalKey<FormState>();
}

typedef _HorseCallback<T> = T Function(T);
