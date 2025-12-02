import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/extension/context_extension.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    required this.photoUrl,
    required this.fullName,
    required this.id,
    required this.username,
    super.key,
  });

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
            decoration: BoxDecoration(color: context.color.primaryContainer, shape: BoxShape.circle),
            child: _AvatarImage(photoUrl: photoUrl, fallbackText: _resolveInitials()),
          ),
        ),
      ),
      Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(fullName, style: context.textTheme.nunitoW600s30.copyWith(color: context.color.primary)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('ID: $id', style: context.textTheme.nunitoW400s14),
                if (username.isNotEmpty) ...[
                  const SizedBox(width: 10),
                  Text('User: @$username', style: context.textTheme.nunitoW400s14),
                ],
              ],
            ),
          ],
        ),
      ),
    ],
  );

  String _resolveInitials() {
    final trimmed = fullName.trim();
    if (trimmed.isEmpty) return 'Q';
    return trimmed.characters.first.toUpperCase();
  }
}

class _AvatarImage extends StatelessWidget {
  const _AvatarImage({required this.photoUrl, required this.fallbackText});

  final String photoUrl;
  final String fallbackText;

  @override
  Widget build(BuildContext context) {
    final normalizedUrl = photoUrl.replaceAll(RegExp(r'\s+'), '');
    final hasPhoto = normalizedUrl.isNotEmpty;
    final isSvg = normalizedUrl.toLowerCase().endsWith('.svg');

    if (!hasPhoto) {
      return ClipOval(child: _Placeholder(initials: fallbackText));
    }

    final Widget imageWidget;

    if (isSvg) {
      imageWidget = SvgPicture.network(
        normalizedUrl,
        fit: BoxFit.cover,
        placeholderBuilder: (_) => _Placeholder(initials: fallbackText),
      );
    } else {
      imageWidget = CachedNetworkImage(
        imageUrl: normalizedUrl,
        fit: BoxFit.cover,
        placeholder: (_, _) => _Placeholder(initials: fallbackText),
        errorWidget: (_, _, _) => _Placeholder(initials: fallbackText),
      );
    }

    return ClipOval(child: SizedBox.expand(child: imageWidget));
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.initials});

  final String initials;

  @override
  Widget build(BuildContext context) => Container(
    color: context.color.primary,
    alignment: Alignment.center,
    child: Text(initials, style: context.textTheme.nunitoW600s24.copyWith(color: context.color.white)),
  );
}
