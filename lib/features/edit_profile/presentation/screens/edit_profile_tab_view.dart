import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/session/auth_session_controller.dart';
import '../../../../core/widgets/utility/custom_snackbar.dart';
import '../controllers/edit_profile_controller.dart';
import '../widgets/edit_profile_app_bar.dart';
import '../widgets/edit_profile_photo_section.dart';
import '../widgets/edit_profile_form.dart';

/// Same content as [EditProfileMobileView], centered in a
/// fixed-width column for wider (tablet/web) viewports.
class EditProfileTabView extends ConsumerWidget {
  const EditProfileTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(editProfileControllerProvider.notifier);
    final name = ref.watch(authSessionControllerProvider).user?.name;

    return Scaffold(
      appBar: EditProfileAppBar(
        onDoneTap: () async {
          await controller.submit((values) {
            if (!context.mounted) return;
            CustomSnackBar.show(context, 'Profile updated successfully');
            context.pop();
          });
          if (!context.mounted) return;
          final error = ref.read(editProfileControllerProvider).errorMessage;
          if (error != null) CustomSnackBar.show(context, error, error: true);
        },
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.xl),
            child: Column(
              children: [
                EditProfilePhotoSection(
                  name: name,
                  onChangePhoto: () => CustomSnackBar.show(context, 'Photo upload is not available yet'),
                ),
                EditProfileForm(
                  onSave: (values) {
                    if (!context.mounted) return;
                    CustomSnackBar.show(context, 'Profile updated successfully');
                    context.pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
