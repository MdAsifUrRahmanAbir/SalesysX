import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:salesysx/features/common_models/outlet_model.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/session/auth_session_controller.dart';
import '../../../../core/utils/error_mapper.dart';
import '../../../../core/widgets/common/primary_button.dart';
import '../../../../core/widgets/common/primary_input_field.dart';
import '../../data/repositories/outlets_customers_repository.dart';

/// Form to add a brand-new sales point/shop directly from the app —
/// the "freedom feature": salesmen and team heads no longer have to
/// wait on the Admin Web Panel to start selling at a new outlet.
class AddOutletSheet extends ConsumerStatefulWidget {
  const AddOutletSheet({super.key, required this.onCreated});

  final ValueChanged<OutletModel> onCreated;

  @override
  ConsumerState<AddOutletSheet> createState() => _AddOutletSheetState();
}

class _AddOutletSheetState extends ConsumerState<AddOutletSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ownerController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _areaController = TextEditingController();

  bool _isSaving = false;
  String? _error;

  @override
  void dispose() {
    _nameController.dispose();
    _ownerController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _areaController.dispose();
    super.dispose();
  }

  String? _required(String? value) =>
      (value == null || value.trim().isEmpty) ? 'Required' : null;

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final user = ref.read(authSessionControllerProvider).user;
    if (user == null) return;

    setState(() {
      _isSaving = true;
      _error = null;
    });

    try {
      final outlet = await ref.read(outletsCustomersRepositoryProvider).addOutlet(
            name: _nameController.text.trim(),
            ownerName: _ownerController.text.trim(),
            phone: _phoneController.text.trim(),
            address: _addressController.text.trim(),
            areaRoute: _areaController.text.trim(),
            assignedSalesmanEmail: user.id,
            teamId: user.teamId ?? '',
          );
      if (!mounted) return;
      Navigator.of(context).pop();
      widget.onCreated(outlet);
    } catch (e) {
      setState(() {
        _isSaving = false;
        _error = getErrorMessage(e);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.addOutletTitle, style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: AppSizes.md),
            PrimaryInputField(
              label: AppStrings.outletNameLabel,
              controller: _nameController,
              validator: _required,
            ),
            SizedBox(height: AppSizes.md),
            PrimaryInputField(
              label: AppStrings.ownerNameLabel,
              controller: _ownerController,
              validator: _required,
            ),
            SizedBox(height: AppSizes.md),
            PrimaryInputField(
              label: AppStrings.phoneLabel,
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              validator: _required,
            ),
            SizedBox(height: AppSizes.md),
            PrimaryInputField(
              label: AppStrings.addressFieldLabel,
              controller: _addressController,
              validator: _required,
            ),
            SizedBox(height: AppSizes.md),
            PrimaryInputField(
              label: AppStrings.areaRouteFieldLabel,
              controller: _areaController,
            ),
            if (_error != null) ...[
              SizedBox(height: AppSizes.sm),
              Text(_error!, style: const TextStyle(color: AppColors.error)),
            ],
            SizedBox(height: AppSizes.lg),
            PrimaryButton(
              label: AppStrings.addOutletAction,
              loading: _isSaving,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
