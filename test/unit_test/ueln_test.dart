import 'package:pferdepass/backend/ueln.dart';
import 'package:test/test.dart';

const ueln_de = 'DE 456789012345';
const ueln_deu = 'DEU456789012345';
const ueln_num = '276456789012345';
const ueln_short = 'DE456789012345';
const ueln_diff = 'DEU567890123456';

void main() {
  group('Ueln', () {
    Ueln u1, u2, u3, u4, u5, u6;
    setUp(() {
      u1 = Ueln(ueln_deu);
      u2 = Ueln.fromString(ueln_de);
      u3 = Ueln.fromString(ueln_deu);
      u4 = Ueln.fromString(ueln_num);
      u5 = Ueln.fromString(ueln_short);
      u6 = Ueln.fromString(ueln_diff);
    });
    test('constructor test', () {
      expect(u1, allOf(u2, u3, u4, u5));
      expect(u1.toString(), ueln_deu);
    });
    test('operator test', () {
      expect(u1, u2);
      expect(u1, isNot(u6));
      expect(u1.hashCode, u1.ueln.hashCode);
    });
    test('string conversion', () {
      expect(u1.toString(), ueln_deu);
    });
  });
}
