import 'package:pferdepass/backend/gender.dart';
import 'package:test/test.dart';

void main() {
  group('Gender', () {
    Gender g1, g2, g3, g4;
    setUp(() {
      g1 = stallion;
      g2 = mare;
      g3 = gelding;
      g4 = Gender(gender: genderType.gelding, dateOfCastration: DateTime.now());
    });
    test('costructor test', () {
      expect(g1.gender, genderType.stallion);
      expect(g1.dateOfCastration, isNull);
      expect(g2.gender, genderType.mare);
      expect(g2.dateOfCastration, isNull);
      expect(g3.gender, genderType.gelding);
      expect(g3.dateOfCastration, isNull);
      expect(g4.gender, genderType.gelding);
      expect(
          g4.dateOfCastration,
          allOf(isNotNull, TypeMatcher<DateTime>(),
              predicate((DateTime t) => t.isBefore(DateTime.now()))));
      expect(
          () =>
              Gender(gender: genderType.mare, dateOfCastration: DateTime.now()),
          throwsFormatException);
      expect(
          () => Gender(
              gender: genderType.stallion, dateOfCastration: DateTime.now()),
          throwsFormatException);
    });
  });
}
