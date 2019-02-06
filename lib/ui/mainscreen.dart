import 'package:flutter/material.dart';
import 'package:pferdepass/backend/horse.dart';
import 'package:pferdepass/backend/tools.dart';

import 'viewhorse.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  _MainScreenState({String title = 'Pferdepass'})
      : _horses = [],
        _title = title {
//    _horses.add(buildHorse());
  }

  @override
  Widget build(BuildContext context) {
    List<HorseCard> horseCards = [];
    for (var h in _horses) {
      horseCards.add(HorseCard.fromHorse(h));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Center(
        child: ListView(children: horseCards),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              var horse = Horse.fromName('New Horse');
              _horses.add(horse);
              return ViewHorse.fromHorse(horse);
            }),
          );
        },
        tooltip: 'add Horse',
        child: Icon(Icons.add),
      ),
    );
  }

  List<Horse> _horses;
  String _title;
}

class HorseCard extends StatefulWidget {
  @override
  _HorseCardState createState() => _HorseCardState.fromHorse(horse);

  HorseCard() : this.horse = Horse();

  HorseCard.fromHorse(this.horse);

  final Horse horse;
}

class _HorseCardState extends State<HorseCard> {
  @override
  Widget build(BuildContext context) {
    var nameList = [horse.breedName, horse.sportsName];
    nameList.remove(null);
    var additionalNames = nameList.join(', ');
    if (additionalNames.isNotEmpty)
      additionalNames = '($additionalNames)';
    else
      additionalNames = null;

    return Card(
      child: ListTile(
        leading: null,
        // TODO: Horse profile pic here
        title: Text(horse.name),
        trailing: Text(additionalNames),
        subtitle: Text(horse.description(context)),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewHorse.fromHorse(horse),
            ),
          );
        },
      ),
    );
  }

  _HorseCardState.fromHorse(Horse horse) : this.horse = horse;

  final Horse horse;
}
