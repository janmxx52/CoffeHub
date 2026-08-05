import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/providers/auth_provider.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        ListTile(
          leading: const Icon(Icons.edit),
          title: const Text("Cập Nhật Thông Tin Cá Nhân"),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            Navigator.pushNamed(
              context,
              '/edit-profile',
            );
          },
        ),

        const Divider(),

        ListTile(
          leading: const Icon(
            Icons.logout,
            color: Colors.red,
          ),
          title: const Text(
            "Đăng xuất",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
            onTap: () async {
              final result = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Đăng xuất"),
                  content: const Text(
                    "Bạn có chắc chắn muốn đăng xuất?",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text("Hủy"),
                    ),
                    FilledButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text("Đăng xuất"),
                    ),
                  ],
                ),
              );

              if (result != true || !context.mounted) return;

              try {
                await context.read<AuthProvider>().logout();

                if (!context.mounted) return;

                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/home',
                      (route) => false,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Đã đăng xuất"),
                  ),
                );
              } catch (e) {
                if (!context.mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Đăng xuất thất bại: $e"),
                  ),
                );
              }
            }
        ),
      ],
    );
  }
}