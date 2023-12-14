part of 'current_user_avatar_bloc.dart';

enum CurrentUserAvatarStatus { initial, loading, failure }

extension CurrentUserAvatarStatusX on CurrentUserAvatarStatus {
  bool get isLoading => [
        CurrentUserAvatarStatus.loading,
      ].contains(this);
}

final class CurrentUserAvatarState extends Equatable {
  const CurrentUserAvatarState({
    this.photo,
    this.status = CurrentUserAvatarStatus.initial,
  });
  final CurrentUserAvatarStatus status;
  final XFile? photo;

  CurrentUserAvatarState copyWith({
    XFile? photo,
    CurrentUserAvatarStatus? status,
  }) =>
      CurrentUserAvatarState(
        photo: photo,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [status, photo];
}
