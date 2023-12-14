import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_repository/user_repository.dart';

part 'current_user_avatar_event.dart';
part 'current_user_avatar_state.dart';

class CurrentUserAvatarBloc
    extends Bloc<CurrentUserAvatarEvent, CurrentUserAvatarState> {
  CurrentUserAvatarBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const CurrentUserAvatarState()) {
    on<CurrentUserAvatarPhotoRefresh>(_onRefresh);
  }
  final UserRepository _userRepository;

  Future<void> _onRefresh(
    CurrentUserAvatarPhotoRefresh event,
    Emitter<CurrentUserAvatarState> emit,
  ) async {
    emit(state.copyWith(status: CurrentUserAvatarStatus.loading));
    XFile? photo;
    try {
      final res = await _userRepository.getCurrentUserAvatar();
      photo = XFile.fromData(res);
    } catch (e) {/* TODO: handle error */}
    emit(
      state.copyWith(
        status: CurrentUserAvatarStatus.initial,
        photo: photo,
      ),
    );
  }
}
