import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/common/custom_card.dart';
import '../../../../core/widgets/common/primary_input_field.dart';
import '../../../../core/widgets/common/primary_button.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileForm extends ConsumerWidget {
  final bool showSaveButton;
  final void Function(Map<String, String> values) onSave;

  const EditProfileForm({
    super.key,
    required this.onSave,
    this.showSaveButton = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(editProfileControllerProvider.notifier);
    final isSaving = ref.watch(editProfileControllerProvider).isSaving;

    return Form(
      key: controller.formKey,
      child: CustomCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimaryInputField(
              label: AppStrings.fullName,
              controller: controller.nameController,
              validator: controller.validateName,
            ),

            const SizedBox(height: AppSizes.md),

            PrimaryInputField(
              label: AppStrings.emailAddress,
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              enabled: false,
            ),

            const SizedBox(height: AppSizes.md),

            PrimaryInputField(
              label: AppStrings.phoneNumber,
              controller: controller.phoneController,
              keyboardType: TextInputType.phone,
            ),

            if (showSaveButton) ...[
              const SizedBox(height: AppSizes.lg),

              PrimaryButton(
                label: AppStrings.saveChanges,
                loading: isSaving,
                onPressed: () {
                  controller.submit(onSave);
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
