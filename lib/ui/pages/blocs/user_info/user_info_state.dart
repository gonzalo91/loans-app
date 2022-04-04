part of 'user_info_cubit.dart';

@immutable
abstract class UserInfoState {
  final String name;
  final String balance;
  final String email;
  final String imageProfile;

  const UserInfoState(this.name, this.balance, this.email, this.imageProfile);
}

class UserInfoInitial extends UserInfoState {
  const UserInfoInitial(
      String name, String balance, String email, String imageProfile)
      : super(name, balance, email, imageProfile);
}
