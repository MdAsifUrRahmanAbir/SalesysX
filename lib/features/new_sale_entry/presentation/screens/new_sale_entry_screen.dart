import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/responsive.dart';
import '../controllers/new_sale_entry_controller.dart';
import 'new_sale_entry_mobile_view.dart';
import 'new_sale_entry_tab_view.dart';

class NewSaleEntryScreen extends ConsumerStatefulWidget {
  const NewSaleEntryScreen({super.key, this.preselectedOutletId});

  /// Set when pushed from Outlets' "Record sale" shortcut.
  final String? preselectedOutletId;

  @override
  ConsumerState<NewSaleEntryScreen> createState() => _NewSaleEntryScreenState();
}

class _NewSaleEntryScreenState extends ConsumerState<NewSaleEntryScreen> {
  @override
  void initState() {
    super.initState();
    final outletId = widget.preselectedOutletId;
    if (outletId != null) {
      Future.microtask(
        () => ref.read(newSaleEntryControllerProvider.notifier).preselectOutlet(outletId),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Responsive(
        mobile: NewSaleEntryMobileView(),
        tablet: NewSaleEntryTabView(),
      ),
    );
  }
}
