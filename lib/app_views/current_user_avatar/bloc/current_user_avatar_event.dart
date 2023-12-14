part of 'current_user_avatar_bloc.dart';

sealed class CurrentUserAvatarEvent extends Equatable {
  const CurrentUserAvatarEvent();

  @override
  List<Object?> get props => [];
}

final class CurrentUserAvatarPhotoRefresh extends CurrentUserAvatarEvent {
  const CurrentUserAvatarPhotoRefresh();
}
