import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talan_tools/talan_tools.dart';
import 'package:turnotron/l10n/l10n.dart';

class UserAvatarUpload extends StatefulWidget {
  const UserAvatarUpload({
    required this.photo,
    required this.onPicked,
    super.key,
  });
  final XFile? photo;
  final void Function(XFile?) onPicked;

  @override
  State<UserAvatarUpload> createState() => _UserAvatarUploadState();
}

class _UserAvatarUploadState extends State<UserAvatarUpload> {
  XFile? localPhoto;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _handlePickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      widget.onPicked(pickedImage);
    }
  }

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
        child: Column(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 250,
              ),
              child: AspectRatio(
                aspectRatio: 1,
                child: TalanTouchable(
                  onPress: () async {
                    final pickedImage = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                    );
                    if (pickedImage != null) {
                      widget.onPicked(pickedImage);
                      setState(() {
                        localPhoto = pickedImage;
                      });
                    }
                  },
                  child: localPhoto == null
                      ? const CircleAvatar(
                          foregroundImage: AssetImage(
                            'assets/img/login_background_mobile.png',
                          ),
                        )
                      : FutureBuilder<Uint8List>(
                          future: localPhoto!.readAsBytes(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator.adaptive(),
                              );
                            }
                            if (snapshot.hasData) {
                              final temp = snapshot.data!;
                              return CircleAvatar(
                                foregroundImage: Image.memory(
                                  temp,
                                  fit: BoxFit.cover,
                                ).image,
                              );
                            }
                            return Center(
                              child: Text(l10n.noData),
                            );
                          },
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
