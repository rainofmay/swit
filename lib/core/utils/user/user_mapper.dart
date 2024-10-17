import 'package:swit/app/enums/online_status.dart';
import 'package:swit/features/user/data/models/user_dto.dart';
import 'package:swit/features/user/domain/entities/user.dart';

class UserMapper {
  static UserDTO toDTO(User user) {
    return UserDTO(
        uid: user.uid,
        email: user.email,
        username: user.username,
        introduction: user.introduction,
        profileUrl: user.profileUrl,
        followerCount: user.followerCount,
        followingCount: user.followingCount,
    );
  }

  static User toEntity(UserDTO dto) {
    return User(
      uid: dto.uid,
      username: dto.username,
      introduction: dto.introduction,
      email: dto.email,
      profileUrl: dto.profileUrl,
      onlineStatus: OnlineStatus.offline,
      followerCount: dto.followerCount ?? 0,
      followingCount: dto.followingCount ?? 0,
    );
  }
}
