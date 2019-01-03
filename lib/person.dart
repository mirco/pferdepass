import 'package:uuid/uuid.dart';
import 'package:contacts_service/contacts_service.dart';

import 'Horse.dart';

class Person{
  Uuid id;
  String name;
  String prename;
  List<Horse> horses;
  Contact contact;
}

enum PersonType{
  unknown,
  owner,
  vet,
  hoofsmith,
  groom,
  rider,
  saddler,
}