import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/common/avatar_photo_picker.dart';
import 'package:salesysx/core/locale/app_localizations_x.dart';

/// Centered avatar + "Change Profile Photo" link at the top of the
/// edit-profile form.
class EditProfilePhotoSection extends StatelessWidget {
  final String? avatarUrl;
  final String? name;
  final VoidCallback? onChangePhoto;

  const EditProfilePhotoSection({
    super.key,
    this.avatarUrl,
    this.name,
    this.onChangePhoto,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.lg),
      child: Center(
        child: AvatarPhotoPicker(
          imageUrl: avatarUrl,
          label: name,
          actionLabel: context.l10n.changeProfilePhoto,
          onTap: onChangePhoto,
        ),
      ),
    );
  }
}
