import '../../../../user/domain/entities/user_entity.dart';

class ParticipantDTO {
  UserEntity _user;

  get getUser => _user;

  ParticipantDTO({required UserEntity user}) : _user = user;
}
