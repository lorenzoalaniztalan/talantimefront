part of 'refresh_view_bloc.dart';

class RefreshViewState extends Equatable {
  const RefreshViewState({
    this.refreshId = 1,
  });

  final int refreshId;

  RefreshViewState copyWith({
    int? refreshId,
  }) {
    return RefreshViewState(
      refreshId: refreshId ?? this.refreshId,
    );
  }

  RefreshViewState nextState() {
    return RefreshViewState(
      refreshId: refreshId + 1,
    );
  }

  @override
  List<Object> get props => [
        refreshId,
      ];
}
