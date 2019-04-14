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

import 'package:Pferdepass/backend/event.dart';
import 'package:Pferdepass/backend/horseDB.dart';
import 'package:Pferdepass/generated/i18n.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';
import 'eventWidget.dart';

class EventScreen extends StatefulWidget {
  final HorseDb horseDb;
  final List<Event> events;

  EventScreen({@required this.horseDb, @required this.events});

  State<EventScreen> createState() =>
      _EventScreenState(events: events, horseDb: horseDb);
}

class _EventScreenState extends State<EventScreen> {
  final List<Event> events;
  final HorseDb horseDb;

  _EventScreenState({this.events, this.horseDb});

  Widget build(BuildContext context) {
    final s = S.of(context);
    final now = DateTime.now();
    final List<Event> futureEvents =
        events.where((event) => event.date.isAfter(now));
    final List<Event> pastEvents =
        events.where((event) => event.date.isBefore(now));

    var eventPanelList = <ExpansionPanel>[];
    if (futureEvents.isNotEmpty)
      eventPanelList.add(ExpansionPanel(
          headerBuilder: (context, isExpanded) => Text(s.future_events),
          body: ListView(
            children: futureEvents
                .map((Event event) => EventWidget(event: event))
                .toList(growable: false),
          ),
          isExpanded: true));
    if (pastEvents.isNotEmpty)
      eventPanelList.add(ExpansionPanel(
        headerBuilder: (context, isExpanded) => Text(s.past_events),
        body: ListView(
          children: pastEvents
              .map((Event event) => EventWidget(event: event))
              .toList(growable: false),
        ),
        isExpanded: futureEvents.isEmpty,
      ));
    if (eventPanelList.isEmpty)
      eventPanelList.add(ExpansionPanel(
          headerBuilder: (context, isExpanded) => Text(s.no_events),
          body: null));

    return Scaffold(
      appBar: AppBar(
        title: Text(s.events),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[],
      ),
      drawer: PferdepassDrawer(horseDb: horseDb),
      body: ExpansionPanelList(children: eventPanelList),
    );
  }
}
