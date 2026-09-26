import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/error_mapper.dart';
import '../../../../core/widgets/common/custom_app_bar.dart';
import '../../../../core/widgets/common/custom_card.dart';
import '../../../../core/widgets/utility/custom_snackbar.dart';
import '../../../../routes/route_names.dart';
import '../controllers/auth_controller.dart';
import '../widgets/login_header.dart';
import '../widgets/login_form.dart';
import '../widgets/social_login_section.dart';
import '../widgets/register_prompt.dart';

class LoginMobileView extends ConsumerWidget {
  const LoginMobileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider).isLoading;

    ref.listen(authControllerProvider, (previous, next) {
      next.whenOrNull(
        error: (error, _) => CustomSnackbar.show(context, getErrorMessage(error)),
      );
    });

    return SafeArea(
      child: Column(
        children: [
          const CustomAppBar(title: AppStrings.signIn),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSizes.lg),
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
                          onForgotPassword: () {},
                        ),
                        const SizedBox(height: AppSizes.lg),
                        SocialLoginSection(
                          onGoogleTap: () => CustomSnackbar.show(context, 'Google sign-in coming soon'),
                          onAppleTap: () => CustomSnackbar.show(context, 'Apple sign-in coming soon'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSizes.lg),
                  RegisterPrompt(onRegisterTap: () {}),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}