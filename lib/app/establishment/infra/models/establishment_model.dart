import '../../domain/entities/establishment_entity.dart';

class EstablishmentModel extends EstablishmentEntity {
  EstablishmentModel(
      {required String id,
      required String name,
      required double latitude,
      required double longitude})
      : super(id: id, name: name, latitude: latitude, longitude: longitude);

  factory EstablishmentModel.empty() =>
      EstablishmentModel(id: '', name: '', latitude: 0.0, longitude: 0.0);

  EstablishmentModel copyWith(
      {String? id, String? name, double? latitude, double? longitude}) {
    return EstablishmentModel(
        id: id ?? this.id,
        name: name ?? this.name,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude);
  }

  static EstablishmentEntity fromMap(dynamic json) {
    return EstablishmentEntity(
        id: json['id'],
        name: json['name'],
        latitude: double.parse(json['latitude']),
        longitude: double.parse(json['longitude']));
  }

  static Map<String, dynamic> toMap(EstablishmentEntity establishment) {
    return {
      'id': establishment.id,
      'name': establishment.name,
      'latitude': establishment.latitude.toString(),
      'longitude': establishment.longitude.toString()
    };
  }
}
