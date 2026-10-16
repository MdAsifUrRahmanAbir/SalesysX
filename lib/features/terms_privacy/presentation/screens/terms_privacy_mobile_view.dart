import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/common/app_header_bar.dart';
import '../widgets/terms_privacy_content.dart';
import 'package:salesysx/core/locale/app_localizations_x.dart';

class TermsMobileView extends ConsumerWidget {
  const TermsMobileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        AppHeaderBar(
          title: context.l10n.termsPrivacyTitle,
          subtitle: context.l10n.termsLastUpdated,
          backStyle: HeaderBackStyle.circle,
          onBackTap: (){
            context.pop();
          },
        ),
        const Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(AppSizes.lg),
            child: TermsPrivacyContent(),
          ),
        ),
      ],
    );
  }
}