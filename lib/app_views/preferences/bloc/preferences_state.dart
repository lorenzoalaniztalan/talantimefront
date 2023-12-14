part of 'preferences_bloc.dart';

enum PreferencesStatus { initial, loading, failure }

extension MasterDataStatusX on PreferencesStatus {
  bool get isLoading => [PreferencesStatus.loading].contains(this);
  bool get isFailure => [PreferencesStatus.failure].contains(this);
}

class PreferencesState extends Equatable {
  const PreferencesState({
    this.status = PreferencesStatus.initial,
    this.isFirstLogin = true,
  });

  final PreferencesStatus status;
  final bool isFirstLogin;

  PreferencesState copyWith({
    PreferencesStatus? status,
    bool? isFirstLogin,
  }) =>
      PreferencesState(
        status: status ?? this.status,
        isFirstLogin: isFirstLogin ?? this.isFirstLogin,
      );

  @override
  List<Object> get props => [status, isFirstLogin];
}
