import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_repository/user_repository.dart';

part 'edit_avatar_event.dart';
part 'edit_avatar_state.dart';

class EditAvatarBloc extends Bloc<EditAvatarEvent, EditAvatarState> {
  EditAvatarBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const EditAvatarState()) {
    on<EditAvatarPhotoChanged>(_onPhotoChanged);
    on<EditAvatarPhotoRemoved>(_onPhotoRemoved);
  }
  final UserRepository _userRepository;

  Future<void> _onPhotoChanged(
    EditAvatarPhotoChanged event,
    Emitter<EditAvatarState> emit,
  ) async {
    final binary = await event.photo.readAsBytes();
    final mimeType = event.photo.mimeType ?? 'image/jpeg';
    await _userRepository.setCurrentUserAvatar(binary, mimeType);
    emit(
      state.copyWith(
        status: EditAvatarStatus.successSubmited,
      ),
    );
  }

  Future<void> _onPhotoRemoved(
    EditAvatarPhotoRemoved event,
    Emitter<EditAvatarState> emit,
  ) async {
    await _userRepository.removeCurrentUserAvatar();
    emit(
      state.copyWith(
        status: EditAvatarStatus.successRemoved,
      ),
    );
  }
}
