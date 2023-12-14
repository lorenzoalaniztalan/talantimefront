part of 'edit_avatar_bloc.dart';

sealed class EditAvatarEvent extends Equatable {
  const EditAvatarEvent();

  @override
  List<Object?> get props => [];
}

final class EditAvatarPhotoChanged extends EditAvatarEvent {
  const EditAvatarPhotoChanged(this.photo);

  final XFile photo;

  @override
  List<Object?> get props => [photo];
}

final class EditAvatarPhotoRemoved extends EditAvatarEvent {
  const EditAvatarPhotoRemoved();
}
