part of 'master_data_bloc.dart';

enum MasterDataStatus { initial, loading, failure }

extension MasterDataStatusX on MasterDataStatus {
  bool get isLoading => [MasterDataStatus.loading].contains(this);
  bool get isFailure => [MasterDataStatus.failure].contains(this);
}

class MasterDataState extends Equatable {
  const MasterDataState({
    this.status = MasterDataStatus.initial,
    this.offices = const [],
    this.absenceTypes = const [],
    this.users = const [],
  });

  final MasterDataStatus status;
  final List<Office> offices;
  final List<AbsenceType> absenceTypes;
  final List<User> users;

  MasterDataState copyWith({
    MasterDataStatus? status,
    List<Office>? offices,
    List<AbsenceType>? absenceTypes,
    List<User>? users,
  }) =>
      MasterDataState(
        status: status ?? this.status,
        offices: offices ?? this.offices,
        absenceTypes: absenceTypes ?? this.absenceTypes,
        users: users ?? this.users,
      );

  @override
  List<Object> get props => [
        status,
        offices,
        absenceTypes,
        users,
      ];
}
