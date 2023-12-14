part of 'authentication_bloc.dart';

enum UserAvatarStatus { initial, loading, failure }

class AuthenticationState extends Equatable {
  AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    User? user,
    this.photo,
    this.avatarStatus = UserAvatarStatus.initial,
  }) {
    this.user = user ?? User.empty;
  }

  AuthenticationState.unknown() : this._();

  AuthenticationState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  late final User user;
  final UserAvatarStatus avatarStatus;
  final XFile? photo;

  AuthenticationState copyWith({
    AuthenticationStatus? status,
    User? user,
    UserAvatarStatus? avatarStatus,
    XFile? photo,
    bool forcePhoto = false,
  }) =>
      AuthenticationState._(
        status: status ?? this.status,
        user: user ?? this.user,
        avatarStatus: avatarStatus ?? this.avatarStatus,
        photo: forcePhoto ? photo : photo ?? this.photo,
      );

  @override
  List<Object> get props => [
        status,
        user,
        avatarStatus,
        photo ?? 'emptyAvatar',
      ];
}
