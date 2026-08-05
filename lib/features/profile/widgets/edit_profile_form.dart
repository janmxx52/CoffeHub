import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/validators.dart';
import '../../auth/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_primary_button.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/profile_provider.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({super.key});

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _fullNameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;

  @override
  void initState() {
    super.initState();

    final user = context.read<AuthProvider>().currentUser;
    _fullNameController = TextEditingController(
      text: user?.fullName ?? '',
    );

    _phoneController = TextEditingController(
      text: user?.phoneNumber ?? '',
    );

    _addressController = TextEditingController(
      text: user?.address ?? '',
    );
  }

  Future<void> _saveProfile() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final authProvider = context.read<AuthProvider>();

    final success = await authProvider.updateProfile(
      fullName: _fullNameController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      address: _addressController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Cập nhật thông tin thành công"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            authProvider.errorMessage ?? "Cập nhật thất bại",
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }


  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _fullNameController,
            autofillHints: const [
              AutofillHints.name,],
            decoration: const InputDecoration(
              labelText: 'Họ và tên',
              prefixIcon: Icon(Icons.person),
            ),
            validator: Validators.validateFullName,
          ),

          const SizedBox(height: 20),

          TextFormField(
            controller: _phoneController,
            autofillHints: const [
              AutofillHints.telephoneNumber,
            ],
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Số điện thoại',
              prefixIcon: Icon(Icons.phone),
            ),
            validator: Validators.validatePhone,
          ),

          const SizedBox(height: 20),

          TextFormField(
            controller: _addressController,
            maxLines: 2,
            autofillHints: const [
              AutofillHints.fullStreetAddress,
            ],
            decoration: const InputDecoration(
              labelText: 'Địa chỉ',
              prefixIcon: Icon(Icons.location_on),
            ),
            validator: Validators.validateAddress,
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: Consumer<AuthProvider>(
              builder: (_, provider, __) {
                return AppPrimaryButton(
                  text: "Lưu thay đổi",
                  isLoading: provider.isLoading,
                  onPressed: _saveProfile,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}