import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

enum EventType {
  Deworming,
  Farrier,
  Measurement,
  Saddler,
  Vaccination,
  Veterinarian,
}

abstract class Event {
  DateTime date;
  EventType get type;

  Event(this.date);

  Map<String, dynamic> toJson();
  factory Event.fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case EventType.Deworming:
        return Deworming.fromJson(json);
        break;
      case EventType.Farrier:
        return Farrier.fromJson(json);
        break;
      case EventType.Measurement:
        return Measurement.fromJson(json);
        break;
      case EventType.Vaccination:
        return Vaccination.fromJson(json);
        break;
      case EventType.Veterinarian:
        return Veterinarian.fromJson(json);
        break;
      // we don't throw here as we can't catch in generated Horse.fromJson()
      // just skip this event instead
      default:
        print("Error: Event has invalid type");
        return null;
    }
  }
}

@JsonSerializable()
class Farrier implements Event {
  DateTime date;
  final EventType type = EventType.Farrier;
  bool planned;
  var _hoofs = List<FarrierWorkDone>(4);

  Farrier(
      {this.date,
      this.planned,
      FarrierWorkDone frontLeft,
      FarrierWorkDone frontRight,
      FarrierWorkDone rearLeft,
      FarrierWorkDone rearRight})
      : _hoofs = List.from([frontLeft, frontRight, rearLeft, rearRight],
            growable: false);

  get frontLeft => _hoofs[0];
  get frontRight => _hoofs[1];
  get rearLeft => _hoofs[2];
  get rearRight => _hoofs[3];
  set frontLeft(FarrierWorkDone hoof) => _hoofs[0] = hoof;
  set frontRight(FarrierWorkDone hoof) => _hoofs[1] = hoof;
  set rearLeft(FarrierWorkDone hoof) => _hoofs[2] = hoof;
  set rearRight(FarrierWorkDone hoof) => _hoofs[3] = hoof;

  @override
  Map<String, dynamic> toJson() => _$FarrierToJson(this);
  @override
  factory Farrier.fromJson(Map<String, dynamic> json) =>
      _$FarrierFromJson(json);
}

enum FarrierWorkDone {
  clipBarehoof,
  newShoe,
  reusedShoe,
  other,
}

enum VaccinationType {
  influenza,
  tetanus,
  herpes,
  borreliosis,
  rabies,
  dermatophytosis,
  westNilFiver,
  strangles,
  equineViralArteritis,
}

@JsonSerializable()
class Vaccination implements Event {
  DateTime date;
  final EventType type = EventType.Vaccination;

  List<VaccinationType> vaccinations = [];
  List<String> vaccines = [];

  Vaccination({this.date, this.vaccinations, this.vaccines});

  @override
  Map<String, dynamic> toJson() => _$VaccinationToJson(this);
  @override
  factory Vaccination.fromJson(Map<String, dynamic> json) =>
      _$VaccinationFromJson(json);
}

enum MeasurementType {
  heightAtWithers,
  backLength,
  bodyLength,
  bodyCircumference,
}

@JsonSerializable()
class Measurement implements Event {
  DateTime date;
  EventType type = EventType.Measurement;
  final MeasurementType what;
  num value;

  Measurement({this.date, this.what, this.value});

  @override
  Map<String, dynamic> toJson() => _$MeasurementToJson(this);
  @override
  factory Measurement.fromJson(Map<String, dynamic> json) =>
      _$MeasurementFromJson(json);
}

@JsonSerializable()
class Veterinarian implements Event {
  DateTime date;
  final EventType type = EventType.Veterinarian;

  Veterinarian({this.date});

  @override
  Map<String, dynamic> toJson() => _$VeterinarianToJson(this);
  @override
  factory Veterinarian.fromJson(Map<String, dynamic> json) =>
      _$VeterinarianFromJson(json);
}

@JsonSerializable()
class Deworming implements Event {
  DateTime date;
  final EventType type = EventType.Deworming;

  Deworming({this.date});

  @override
  Map<String, dynamic> toJson() => _$DewormingToJson(this);
  @override
  factory Deworming.fromJson(Map<String, dynamic> json) =>
      _$DewormingFromJson(json);
}
