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
import 'package:flutter/material.dart';

class EventWidget extends StatefulWidget {
  final Event event;
  EventWidget({@required this.event});

  State<EventWidget> createState() => _EventWidgetState(event: event);
}

class _EventWidgetState extends State<EventWidget> {
  final Event event;

  _EventWidgetState({@required this.event});

  Widget build(BuildContext c) {
    return Placeholder();
  }
}
