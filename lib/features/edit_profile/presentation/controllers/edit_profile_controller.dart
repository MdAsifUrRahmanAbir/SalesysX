import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/locale/l10n_provider.dart';
import '../../../../core/session/auth_session_controller.dart';
import '../../../../core/utils/error_mapper.dart';
import '../../data/repositories/edit_profile_repository.dart';

class EditProfileState {
  final bool isSaving;
  final String? errorMessage;

  const EditProfileState({this.isSaving = false, this.errorMessage});

  EditProfileState copyWith({bool? isSaving, String? errorMessage}) {
    return EditProfileState(
      isSaving: isSaving ?? this.isSaving,
      errorMessage: errorMessage,
    );
  }
}

class EditProfileController extends Notifier<EditProfileState> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;

  EditProfileRepository get _repository => ref.read(editProfileRepositoryProvider);

  @override
  EditProfileState build() {
    final user = ref.read(authSessionControllerProvider).user;
    nameController = TextEditingController(text: user?.name ?? '');
    emailController = TextEditingController(text: user?.email ?? '');
    phoneController = TextEditingController(text: user?.phone ?? '');
    ref.onDispose(() {
      nameController.dispose();
      emailController.dispose();
      phoneController.dispose();
    });

    return const EditProfileState();
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return ref.read(l10nProvider).fullNameRequired;
    }
    return null;
  }

  bool validate() => formKey.currentState?.validate() ?? false;

  Future<void> submit(void Function(Map<String, String> values) onSave) async {
    if (!validate() || state.isSaving) return;

    final user = ref.read(authSessionControllerProvider).user;
    if (user == null) return;

    state = state.copyWith(isSaving: true, errorMessage: null);
    try {
      await _repository.updateProfile(
        email: user.id,
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
      );
      await ref.read(authSessionControllerProvider.notifier).restoreSession();
      state = state.copyWith(isSaving: false);
      onSave({'name': nameController.text.trim(), 'phone': phoneController.text.trim()});
    } catch (e) {
      state = state.copyWith(isSaving: false, errorMessage: getErrorMessage(e));
    }
  }
}

final editProfileControllerProvider =
NotifierProvider.autoDispose<EditProfileController, EditProfileState>(
  EditProfileController.new,
);
