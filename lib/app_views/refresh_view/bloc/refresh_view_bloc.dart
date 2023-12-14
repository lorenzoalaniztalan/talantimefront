import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'refresh_view_event.dart';
part 'refresh_view_state.dart';

class RefreshViewBloc extends Bloc<RefreshViewEvent, RefreshViewState> {
  RefreshViewBloc() : super(const RefreshViewState()) {
    on<RefreshViewRefreshEvent>((event, emit) => emit(state.nextState()));
  }
}
