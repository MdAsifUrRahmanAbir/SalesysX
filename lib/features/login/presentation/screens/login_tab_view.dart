import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/utils/error_mapper.dart';
import '../../../../core/widgets/common/custom_app_bar.dart';
import '../../../../core/widgets/common/custom_card.dart';
import '../../../../core/widgets/utility/custom_snackbar.dart';
import '../../../../routes/route_names.dart';
import '../controllers/auth_controller.dart';
import '../widgets/login_header.dart';
import '../widgets/forgot_password_help.dart';
import '../widgets/login_form.dart';
import 'package:salesysx/core/locale/app_localizations_x.dart';

/// Same content as [LoginMobileView], centered in a fixed-width column
/// for wider (tablet/web) viewports.
class LoginTabView extends ConsumerWidget {
  const LoginTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider).isLoading;

    ref.listen(authControllerProvider, (previous, next) {
      next.whenOrNull(
        error: (error, _) => CustomSnackBar.show(context, getErrorMessage(error), error: true),
      );
    });

    return SafeArea(
      child: Column(
        children: [
          CustomAppBar(title: context.l10n.signIn),
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSizes.xl),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const LoginHeader(),
                            const SizedBox(height: AppSizes.lg),
                            LoginForm(
                              loading: isLoading,
                              onSignIn: (email, password, rememberMe) async {
                                final success =
                                await ref.read(authControllerProvider.notifier).login(email, password);
                                if (!context.mounted || !success) return;
                                context.go(RouteNames.mainShell);
                              },
                              onForgotPassword: () => showForgotPasswordHelp(context),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
