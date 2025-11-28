import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../common/extension/context_extension.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({required this.photoUrl, required this.fullName, required this.id, required this.username, super.key});

  final String photoUrl;
  final String fullName;
  final String id;
  final String username;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Center(
        child: SizedBox(
          height: 100,
          width: 100,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: context.color.primary,
              shape: BoxShape.circle,
            ),
            child: CachedNetworkImage(imageUrl: photoUrl),
          ),
        ),
      ),
      Center(
        child: Column(
          crossAxisAlignment: .center,
          children: [
            Text(
              fullName,
              style: context.textTheme.nunitoW600s30.copyWith(
                color: context.color.primary,
              ),
            ),
            Row(
              mainAxisAlignment: .center,
              spacing: 10,
              children: [
                Text(
                  'ID: $id',
                  style: context.textTheme.nunitoW400s14,
                ),
                Text(
                  'User: @$username',
                  style: context.textTheme.nunitoW400s14,
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
