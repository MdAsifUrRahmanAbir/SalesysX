import 'package:flutter/material.dart';
import '../../../../core/utils/responsive.dart';
import 'profile_mobile_view.dart';
import 'profile_tab_view.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Responsive(
        mobile: ProfileMobileView(),
        tablet: ProfileTabView(),
      ),
    );
  }
}
