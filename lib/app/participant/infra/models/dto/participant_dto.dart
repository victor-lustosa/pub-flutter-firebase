import '../../../../room/blocs/room_bloc.dart';

import '../../../../room/view-models/room_view_model.dart';
import '../../../../user/infra/models/user_model.dart';



class ParticipantDTO {
  UserModel _user;


  get getUser => _user;

  ParticipantDTO(
      {required UserModel user})
      : _user = user;
}
