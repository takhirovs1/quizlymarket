import 'package:flutter/material.dart';

import '../../../../../common/extension/context_extension.dart';
import '../../../../../common/extension/int_extension.dart';
import '../../../../../common/util/dimension.dart';
import '../../data/model/user_list_model.dart';

class UserTile extends StatelessWidget {
  const UserTile({required this.user, required this.onTap, super.key});
  final ClientModel user;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Padding(
      padding: Dimension.pH16V4,
      child: Row(
        spacing: 6,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: Padding(
                padding: Dimension.pAll4,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: context.color.primary, shape: BoxShape.circle),
                  child: Center(
                    child: Text(
                      user.name.characters.first.toUpperCase(),
                      style: context.textTheme.nunitoW600s16.copyWith(color: context.color.onPrimary),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: Column(
              spacing: 4,
              children: [
                Row(
                  spacing: 6,
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        user.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.sfProW500s16.copyWith(color: context.color.primary),
                      ),
                    ),
                    Text(
                      user.balance.toInt().toUZSString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.sfProW500s16.copyWith(
                        color: context.color.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    switch (user.telegramUsername != null && user.telegramUsername!.isNotEmpty) {
                      true => Text(
                        '@${user.telegramUsername}',
                        style: context.textTheme.sfProW400s12.copyWith(color: context.color.gray),
                      ),
                      false => const SizedBox.shrink(),
                    },
                    Text(
                      'ID: ${user.telegramID}',
                      style: context.textTheme.sfProW500s12.copyWith(color: context.color.gray),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
