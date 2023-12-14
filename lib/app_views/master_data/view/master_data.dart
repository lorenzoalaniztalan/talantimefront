import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turnotron/app_views/loading/view/loading_page.dart';
import 'package:turnotron/app_views/master_data/bloc/master_data_bloc.dart';
import 'package:turnotron/app_views/preferences/bloc/preferences_bloc.dart';
import 'package:turnotron/widgets/error_widget.dart';

class MasterDataProvider extends StatelessWidget {
  const MasterDataProvider({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _MasterDataOrchester(child: child);
  }
}

class _MasterDataOrchester extends StatelessWidget {
  const _MasterDataOrchester({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MasterDataBloc, MasterDataState>(
      builder: (context, masterDataState) {
        return BlocBuilder<PreferencesBloc, PreferencesState>(
          builder: (context, preferencesState) {
            if (masterDataState.status.isLoading ||
                preferencesState.status.isLoading) {
              return const SplashPage();
            }
            if (masterDataState.status.isFailure ||
                preferencesState.status.isFailure) {
              return const TalanErrorWidget();
            }
            return child;
          },
        );
      },
    );
  }
}
