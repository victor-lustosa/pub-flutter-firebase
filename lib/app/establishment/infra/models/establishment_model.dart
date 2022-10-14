import '../../domain/entities/establishment_entity.dart';

class EstablishmentModel extends EstablishmentEntity{
  EstablishmentModel({
    required String id,
    required String title,
    required String abbr,
    required int priority
  }) : super(
          id: id,
          title: title,
          abbr: abbr,
          priority: priority
      );

  factory EstablishmentModel.empty() => EstablishmentModel(abbr: '', id: '', priority: 0, title: '');

  EstablishmentModel copyWith({
    String? id,
    String? title,
    String? abbr,
    int? priority,
  }) {
    return EstablishmentModel(
      id: id ?? this.id,
      title: title ?? this.title,
      abbr: abbr ?? this.abbr,
      priority: priority ?? this.priority,
    );
  }
}
