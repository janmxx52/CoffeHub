import 'package:flutter/material.dart';

import '../../../data/models/user_model.dart';

class ProfileHeader extends StatelessWidget {
  final UserModel user;

  const ProfileHeader({
    super.key,
    required this.user,
  });



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 45,
          backgroundImage: user.photoUrl != null &&
              user.photoUrl!.isNotEmpty
              ? NetworkImage(user.photoUrl!)
              : null,
          child: user.photoUrl == null || user.photoUrl!.isEmpty
              ? const Icon(
            Icons.person,
            size: 50,
          )
              : null,
        ),

        const SizedBox(height: 15),

        Text(
          user.fullName,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 5),

        Text(
          user.email,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}