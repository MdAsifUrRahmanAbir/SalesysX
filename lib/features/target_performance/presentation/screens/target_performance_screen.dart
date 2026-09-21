import 'package:flutter/material.dart';
import '../../../../core/utils/responsive.dart';
import 'target_performance_mobile_view.dart';
import 'target_performance_tab_view.dart';

class TargetPerformanceScreen extends StatelessWidget {
  const TargetPerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Responsive(
        mobile: TargetPerformanceMobileView(),
        tablet: TargetPerformanceTabView(),
      ),
    );
  }
}
