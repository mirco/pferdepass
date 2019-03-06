import 'package:pferdepass/backend/event.dart';
import 'package:test/test.dart';

void main() {
  group('Event', () {
    List<Event> events = [];
    setUp(() {
      events.add(Farrier(date: DateTime.now()));
    });
    test('constructor test', () {});
    test('json serialization', () {});
  });
}
