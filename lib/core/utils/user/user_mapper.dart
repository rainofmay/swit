import 'package:swit/app/enums/online_status.dart';
import 'package:swit/features/user/data/models/user_dto.dart';
import 'package:swit/features/user/domain/entities/user.dart';

class UserMapper {
  static UserDTO toDTO(User user) {
    return UserDTO(
        uid: user.uid,
        email: user.email,
        username: user.username,
        profileUrl: user.profileUrl
    );
  }

  static User toEntity(UserDTO dto) {
    return User(
      uid: dto.uid,
      username: dto.username,
      email: dto.email,
      profileUrl: dto.profileUrl,
      onlineStatus: OnlineStatus.offline,
    );
  }
}
