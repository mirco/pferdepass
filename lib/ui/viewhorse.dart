import 'package:flutter/material.dart';
import 'package:pferdepass/backend/gender.dart';
import 'package:pferdepass/backend/horse.dart';
import 'package:pferdepass/backend/tools.dart';
import 'package:pferdepass/backend/ueln.dart';
import 'package:pferdepass/generated/i18n.dart';

class ViewHorse extends StatefulWidget {
  @override
  _ViewHorseState createState() => _ViewHorseState.fromHorse(horse);

  ViewHorse.fromHorse(Horse horse) : this.horse = horse;

  final Horse horse;
}

class _ViewHorseState extends State<ViewHorse> {
  @override
  Widget build(BuildContext c) {
    var s = S.of(c);
    var widgetList = <Widget>[
      _buildTextFieldWidget(
        labelText: s.sportsname,
        content: horse.sportsName,
        callback: (String value) {
          setState(() {
            horse.sportsName = value;
          });
        },
      ),
      _buildTextFieldWidget(
          labelText: s.breedname,
          content: horse.breedName,
          callback: (String value) {
            setState(() {
              horse.breedName = value;
            });
          }),
      _buildTextFieldWidget(
          labelText: s.ueln,
          content: horse.ueln,
          callback: (String value) {
            setState(() {
              horse.ueln = Ueln.fromString(value);
            });
          }),
      _buildTextFieldWidget(
          labelText: s.dateOfBirth,
          content: formatDate(horse.dateOfBirth),
          callback: (String value) {
            setState(() {
              horse.dateOfBirth = DateTime.parse(value);
            });
          }),
      _buildDropdownButtonFieldWidget<Race>(
          labelText: s.race,
          items: raceStrings,
          value: horse.race,
          context: c,
          callback: (Race value) {
            setState(() {
              horse.race = value;
            });
          }),
      _buildDropdownButtonFieldWidget<Color>(
          labelText: s.color,
          items: colorStrings,
          value: horse.color,
          context: c,
          callback: (Color value) {
            setState(() {
              horse.color = value;
            });
          }),
      _buildDropdownButtonFieldWidget<genderType>(
          labelText: s.gender,
          items: Gender.genderStrings,
          value: horse.gender.gender,
          context: c,
          callback: (genderType value) {
            setState(() {
              horse.gender = Gender(gender: value);
            });
          }),
    ];

    return Scaffold(
      appBar: AppBar(
        title: TextField(controller: TextEditingController(text: horse.name != null ? horse.name : ''),
        onSubmitted: (String value){setState((){horse.name = value;});}),
        actions: [Icon(Icons.delete)],
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
    dynamic content = '',
    Widget onClicked,
    _HorseCallback<String> callback,
    BuildContext context,
  }) {
    content ??= '';
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
      ),
      controller: TextEditingController(
        text: () {
          assert(content != null);
          if (content is Localized) {
            assert(context != null);
            return content.toLocalizedString(context);
          } else
            return content.toString();
        }(),
      ),
      onFieldSubmitted: callback,
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
      onChanged: callback,
    );

    return r;
  }

  _ViewHorseState.fromHorse(Horse horse)
      : this.horse = horse;

  final Horse horse;
  final _formKey = GlobalKey<FormState>();
}

typedef _HorseCallback<T> = void Function(T);
