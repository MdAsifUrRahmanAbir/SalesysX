import 'package:flutter/material.dart';
import '../../../../core/utils/responsive.dart';
import 'new_sale_entry_mobile_view.dart';
import 'new_sale_entry_tab_view.dart';

class NewSaleEntryScreen extends StatelessWidget {
  const NewSaleEntryScreen({super.key});

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
