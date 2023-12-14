import 'dart:async';

import 'package:absence_api/absence_api.dart';
import 'package:absence_repository/absence_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:office_api/office_api.dart';
import 'package:office_repository/office_repository.dart';
import 'package:user_api/user_api.dart';
import 'package:user_repository/user_repository.dart';

part 'master_data_event.dart';
part 'master_data_state.dart';

class MasterDataBloc extends Bloc<MasterDataEvent, MasterDataState> {
  MasterDataBloc({
    required OfficeRepository officeRepository,
    required AbsenceRepository absenceRepository,
    required UserRepository userRepository,
  })  : _officeRepository = officeRepository,
        _absenceRepository = absenceRepository,
        _userRepository = userRepository,
        super(const MasterDataState(status: MasterDataStatus.loading)) {
    on<MasterDataFetchAll>(_onRefetch);
  }

  final OfficeRepository _officeRepository;
  final AbsenceRepository _absenceRepository;
  final UserRepository _userRepository;

  Future<void> _onRefetch(
    MasterDataFetchAll event,
    Emitter<MasterDataState> emit,
  ) async {
    try {
      emit(state.copyWith(status: MasterDataStatus.loading));
      var offices = <Office>[];
      var absenceTypes = <AbsenceType>[];
      var users = <User>[];
      if (event.isAdmin) {
        final data = await Future.wait([
          _officeRepository.getAllOffices(),
          _absenceRepository.getAllAbsenceTypes(),
          _userRepository.getUsers(),
        ]);
        offices = data[0] as List<Office>;
        absenceTypes = data[1] as List<AbsenceType>;
        users = data[2] as List<User>;
      } else {
        final data = await Future.wait([
          _absenceRepository.getAllAbsenceTypes(),
        ]);
        absenceTypes = data[0];
      }
      emit(
        state.copyWith(
          status: MasterDataStatus.initial,
          offices: offices,
          absenceTypes: absenceTypes,
          users: users,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: MasterDataStatus.failure));
    }
  }
}
