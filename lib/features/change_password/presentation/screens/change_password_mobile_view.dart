import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/common/custom_app_bar.dart';
import '../../../../core/widgets/common/custom_card.dart';
import '../../../../core/widgets/utility/custom_snackbar.dart';
import '../controllers/change_password_controller.dart';
import '../widgets/change_password_form.dart';
import 'package:salesysx/core/locale/app_localizations_x.dart';

class ChangePasswordMobileView extends ConsumerWidget {
  const ChangePasswordMobileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(changePasswordControllerProvider, (previous, next) {
      if (next.errorMessage != null && next.errorMessage != previous?.errorMessage) {
        CustomSnackBar.show(context, next.errorMessage!, error: true);
      }
    });

    return SafeArea(
      child: Column(
        children: [
          CustomAppBar(title: context.l10n.changePasswordTitle),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSizes.lg),
              child: CustomCard(
                child: ChangePasswordForm(
                  onSave: (currentPassword, newPassword) {
                    if (!context.mounted) return;
                    CustomSnackBar.show(context, 'Password updated');
                    context.pop();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
