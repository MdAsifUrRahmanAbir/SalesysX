import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/app_color_scheme.dart';
import '../../../../core/widgets/common/app_header_bar.dart';
import '../../../../core/widgets/common/custom_card.dart';
import '../../../../core/widgets/common/search_field.dart';
import '../../../../core/widgets/utility/custom_snackbar.dart';
import '../controllers/help_support_controller.dart';
import '../widgets/contact_support_tile.dart';
import '../widgets/faq_item.dart';
import 'package:salesysx/core/locale/app_localizations_x.dart';

class HelpSupportMobileView extends ConsumerStatefulWidget {
  const HelpSupportMobileView({super.key});

  @override
  ConsumerState<HelpSupportMobileView> createState() => _HelpSupportMobileViewState();
}

class _HelpSupportMobileViewState extends ConsumerState<HelpSupportMobileView> {
  String _query = '';

  Future<void> _launch(Uri uri) async {
    final ok = await launchUrl(uri);
    if (!ok && mounted) CustomSnackBar.show(context, context.l10n.couldNotOpenApp, error: true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final faqs = [
      (l10n.faqRecordSaleQ, l10n.faqRecordSaleA),
      (l10n.faqAddOutletQ, l10n.faqAddOutletA),
      (l10n.faqTargetQ, l10n.faqTargetA),
      (l10n.faqWrongSaleQ, l10n.faqWrongSaleA),
      (l10n.faqNotificationsQ, l10n.faqNotificationsA),
      (l10n.faqPasswordQ, l10n.faqPasswordA),
    ];
    final q = _query.trim().toLowerCase();
    final visible = q.isEmpty
        ? faqs
        : faqs.where((f) => f.$1.toLowerCase().contains(q) || f.$2.toLowerCase().contains(q)).toList();
    final teamHead = ref.watch(helpSupportControllerProvider).value;
    final headingStyle = TextStyle(fontSize: AppSizes.fontMd, fontWeight: FontWeight.w700, color: context.appColors.textPrimary);

    return Column(
      children: [
        AppHeaderBar(title: l10n.helpSupportTitle, backStyle: HeaderBackStyle.chevron),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchField(hintText: l10n.searchFaqsHint, onChanged: (v) => setState(() => _query = v)),
                const SizedBox(height: AppSizes.lg),
                Text(l10n.faqSectionTitle, style: headingStyle),
                const SizedBox(height: AppSizes.sm + AppSizes.xs),
                if (visible.isEmpty)
                  Text(l10n.noFaqMatches, style: TextStyle(color: context.appColors.textSecondary))
                else
                  for (var i = 0; i < visible.length; i++) ...[
                    FaqItem(question: visible[i].$1, answer: visible[i].$2, initiallyExpanded: i == 0 && q.isEmpty),
                    const SizedBox(height: AppSizes.sm + AppSizes.xs),
                  ],
                const SizedBox(height: AppSizes.lg),
                Text(l10n.contactSupportTitle, style: headingStyle),
                const SizedBox(height: AppSizes.sm + AppSizes.xs),
                if (teamHead == null)
                  CustomCard(
                    fullWidth: true,
                    child: Text(l10n.contactAdminHint, style: TextStyle(color: context.appColors.textSecondary, height: 1.4)),
                  )
                else ...[
                  Text(l10n.yourTeamHead(teamHead.name), style: TextStyle(color: context.appColors.textSecondary)),
                  const SizedBox(height: AppSizes.sm),
                  if (teamHead.phone.isNotEmpty) ...[
                    ContactSupportTile(
                      icon: Icons.call_outlined,
                      title: l10n.callContact,
                      actionLabel: teamHead.phone,
                      onTap: () => _launch(Uri(scheme: 'tel', path: teamHead.phone)),
                    ),
                    const SizedBox(height: AppSizes.sm + AppSizes.xs),
                  ],
                  ContactSupportTile(
                    icon: Icons.mail_outline_rounded,
                    title: l10n.emailContact,
                    actionLabel: teamHead.email,
                    onTap: () => _launch(Uri(scheme: 'mailto', path: teamHead.email)),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
