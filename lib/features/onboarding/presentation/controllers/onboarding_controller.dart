import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/locale/l10n_provider.dart';
import '../../data/models/onboarding_model.dart';

/// Onboarding slide content. Update titles/descriptions/imagePaths here
/// to change what appears in the carousel — the UI widgets just render
/// whatever this list provides.
class OnboardingController extends Notifier<List<OnboardingModel>> {
  @override
  List<OnboardingModel> build() {
    final l10n = ref.watch(l10nProvider);
    return [
      OnboardingModel(
        title: l10n.onboardingSalesTitle,
        description: l10n.onboardingSalesBody,
        imagePath: 'assets/images/onboard.png',
      ),
      OnboardingModel(
        title: l10n.onboardingTargetTitle,
        description: l10n.onboardingTargetBody,
        imagePath: 'assets/images/welcome.png',
      ),
      OnboardingModel(
        title: l10n.onboardingAlertsTitle,
        description: l10n.onboardingAlertsBody,
        imagePath: 'assets/logo/logo.png',
      ),
    ];
  }
}

final onboardingControllerProvider =
    NotifierProvider<OnboardingController, List<OnboardingModel>>(
      OnboardingController.new,
    );
