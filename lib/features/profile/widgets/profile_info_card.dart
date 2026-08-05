import 'package:flutter/material.dart';

import '../../../data/models/user_model.dart';

class ProfileInfoCard extends StatelessWidget {
  final UserModel user;

  const ProfileInfoCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text("Số điện thoại:"),
              subtitle: Text(
                user.phoneNumber ?? "Chưa cập nhật",
              ),
            ),

            const Divider(),

            // ListTile(
            //   leading: const Icon(Icons.admin_panel_settings),
            //   title: const Text("Role"),
            //   subtitle: Text(user.role),
            // ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.verified_user),
              title: const Text("Trạng Thái:"),
              subtitle: Text(
                user.isActive ? "Hoạt Động" : "Không Hoạt Động",
              ),


            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text("Địa chỉ:"),
              subtitle: Text(
                user.address ?? "Chưa cập nhật",
              ),
            ),
          ],
        ),
      ),
    );
  }
}