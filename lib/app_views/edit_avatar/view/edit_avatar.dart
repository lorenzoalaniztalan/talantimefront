import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talan_tools/talan_tools.dart';
import 'package:turnotron/app_views/authentication/bloc/authentication_bloc.dart';
import 'package:turnotron/app_views/edit_avatar/bloc/edit_avatar_bloc.dart';
import 'package:turnotron/l10n/l10n.dart';
import 'package:turnotron/utils/notifications.dart';
import 'package:user_repository/user_repository.dart';

class EditAvatarView extends StatelessWidget {
  const EditAvatarView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocProvider(
      create: (context) => EditAvatarBloc(
        userRepository: context.read<UserRepository>(),
      ),
      child: AlertDialog(
        title: Row(
          children: [
            Expanded(child: Text(l10n.editAvatarTitle)),
            IconButton(
              onPressed: Navigator.of(context).pop,
              icon: Icon(
                Icons.close,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            )
          ],
        ),
        content: const _EditAvatarView(),
      ),
    );
  }
}

class _EditAvatarView extends StatelessWidget {
  const _EditAvatarView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 450,
        maxHeight: 500,
      ),
      child: SizedBox(
        width: 300,
        child: BlocListener<EditAvatarBloc, EditAvatarState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status.wasSuccess) {
              context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationUserAvatarRequested());
              handleSuccess(l10n.editAvatarSuccessMessage);
            }
            if (state.status == EditAvatarStatus.failure) {
              handleError(l10n.editAvatarErrorMessage);
            }
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 250,
                ),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: BlocBuilder<AuthenticationBloc,
                            AuthenticationState>(
                          builder: (context, state) {
                            final photo = state.photo;
                            if (photo == null) {
                              final user =
                                  context.read<AuthenticationBloc>().state.user;
                              return CircleAvatar(
                                backgroundColor: TalanAppColors.primary,
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: AutoSizeText(
                                    user.initials,
                                    style: const TextStyle(fontSize: 200),
                                  ),
                                ),
                              );
                            }
                            return FutureBuilder<Uint8List>(
                              future: photo.readAsBytes(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  );
                                }
                                if (snapshot.hasData) {
                                  final data = snapshot.data!;
                                  return CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    foregroundImage: Image.memory(
                                      data,
                                      fit: BoxFit.cover,
                                    ).image,
                                  );
                                }
                                return Center(
                                  child: Text(l10n.noData),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Positioned.fill(
                        child: BlocBuilder<AuthenticationBloc,
                            AuthenticationState>(
                          buildWhen: (previous, current) =>
                              previous.status != current.status,
                          builder: (context, state) {
                            return Visibility(
                              visible: state.avatarStatus ==
                                  UserAvatarStatus.loading,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: TalanAppColors.n600.withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                                child:
                                    const CircularProgressIndicator.adaptive(),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              spacerM,
              OutlinedButton.icon(
                onPressed: () async {
                  final pickedImage = await ImagePicker().pickImage(
                    source: ImageSource.gallery,
                  );
                  if (pickedImage != null) {
                    context
                        .read<EditAvatarBloc>()
                        .add(EditAvatarPhotoChanged(pickedImage));
                  }
                },
                icon: const Icon(Icons.upload),
                label: Text(l10n.editAvatarUploadImageButton),
              ),
              spacerS,
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  return TextButton.icon(
                    style: TextButton.styleFrom(
                      foregroundColor: TalanAppColors.error,
                    ),
                    onPressed: state.photo != null
                        ? () => context
                            .read<EditAvatarBloc>()
                            .add(const EditAvatarPhotoRemoved())
                        : null,
                    icon: const Icon(Icons.delete_forever),
                    label: Text(l10n.editAvatarDeleteImageButton),
                  );
                },
              ),
              spacerXs,
            ],
          ),
        ),
      ),
    );
  }
}
