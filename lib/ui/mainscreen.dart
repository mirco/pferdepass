import 'package:flutter/material.dart';
import 'package:pferdepass/backend/horse.dart';
import 'package:pferdepass/backend/tools.dart';

import 'viewhorse.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  _MainScreenState({this.key, this.title = 'Pferdepass', this.horses}){
    if(horses == null)
      this.horses = [];
    horses.add(buildHorse()); // for testing
  }

  @override
  Widget build(BuildContext context) {
    List<HorseCard> horseCards = [];
    for (var h in horses) {
      horseCards.add(HorseCard.fromHorse(h));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
              horses.add(horse);
              return ViewHorse(key: key, horse: horse);
            }),
          );
        },
        tooltip: 'add Horse',
        child: Icon(Icons.add),
      ),
    );
  }

  final Key key;
  List<Horse> horses;
  String title;
}

class HorseCard extends StatefulWidget {
  @override
  _HorseCardState createState() => _HorseCardState(key: key, horse: horse);

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
              builder: (context) => ViewHorse(key: key, horse: horse),
            ),
          );
        },
      ),
    );
  }

  _HorseCardState({this.key, this.horse});

  final Key key;
  final Horse horse;
}
