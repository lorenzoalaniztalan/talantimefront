part of 'edit_avatar_bloc.dart';

enum EditAvatarStatus {
  initial,
  editing,
  saving,
  successSubmited,
  successRemoved,
  failure
}

extension EditAvatarStatusX on EditAvatarStatus {
  bool get isLoading => [
        EditAvatarStatus.saving,
      ].contains(this);
  bool get canSave => [
        EditAvatarStatus.editing,
        EditAvatarStatus.failure,
      ].contains(this);
  bool get canEdit => ![
        EditAvatarStatus.saving,
      ].contains(this);
  bool get wasSuccess => [
        EditAvatarStatus.successRemoved,
        EditAvatarStatus.successSubmited,
      ].contains(this);
}

final class EditAvatarState extends Equatable {
  const EditAvatarState({this.status = EditAvatarStatus.initial});
  final EditAvatarStatus status;

  EditAvatarState copyWith({
    XFile? photo,
    EditAvatarStatus? status,
  }) =>
      EditAvatarState(
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [
        status,
      ];
}
