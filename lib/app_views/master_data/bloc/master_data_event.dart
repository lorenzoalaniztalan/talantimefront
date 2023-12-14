part of 'master_data_bloc.dart';

sealed class MasterDataEvent {
  const MasterDataEvent();
}

final class MasterDataFetchAll extends MasterDataEvent {
  const MasterDataFetchAll({
    required this.isAdmin,
  });
  final bool isAdmin;
}
