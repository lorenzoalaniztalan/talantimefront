import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turnotron/app_views/refresh_view/bloc/refresh_view_bloc.dart';

class RefreshViewWidget extends StatelessWidget {
  const RefreshViewWidget({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RefreshViewBloc(),
      child: _RefreshViewWidget(
        child: child,
      ),
    );
  }
}

class _RefreshViewWidget extends StatelessWidget {
  const _RefreshViewWidget({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RefreshViewBloc, RefreshViewState>(
      builder: (context, state) {
        return Builder(
          key: ValueKey('refreshViewBuilder${state.refreshId}'),
          builder: (context) {
            return child;
          },
        );
      },
    );
  }
}
