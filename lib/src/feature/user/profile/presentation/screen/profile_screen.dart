import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../common/constant/gen/assets.gen.dart';
import '../../../../../common/extension/context_extension.dart';
import '../../../../../common/router/route_arguments.dart';
import '../../../../../common/util/dimension.dart';
import '../../../../../common/widget/custom_tile.dart';
import '../state/profile_state.dart';
import '../widget/bank_card_widget.dart';
import '../widget/profile_header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({this.data, super.key});

  final String? data;

  @internal
  // ignore: library_private_types_in_public_api
  static _ProfileScreenState? maybeOf(BuildContext context) => context.findAncestorStateOfType<_ProfileScreenState>();

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ProfileState {
  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: context.dependencies.settingsBloc,
    child: Scaffold(
      backgroundColor: context.color.background,
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView(
                padding: Dimension.pAll16,
                children: [
                  // Lottie.asset(Assets.lottie.book),
                  Dimension.hBox64,
                  ProfileHeader(
                    photoUrl: '',
                    fullName: context.user?.name ?? '',
                    id: context.user?.telegramID.toString() ?? '',
                    username: context.user?.telegramUsername ?? '',
                  ),
                  Dimension.hBox16,
                  BankCardWidget(
                    fullName: context.user?.name ?? '',
                    balance: context.user?.balance ?? .0,
                    id: context.user?.telegramID.toString() ?? '',
                  ),
                  Dimension.hBox16,
                  Material(
                    color: context.color.white,
                    shape: const RoundedRectangleBorder(borderRadius: Dimension.rAll10),
                    clipBehavior: Clip.antiAlias,
                    child: CustomTile(
                      leading: Icon(CupertinoIcons.money_dollar, color: context.color.primary),
                      title: context.l10n.report,
                      onTap: () {
                        context.telegramWebApp.hapticFeedback.impactOccurred(.light);
                      },
                    ),
                  ),
                  Dimension.hBox12,
                  Material(
                    color: context.color.white,
                    shape: const RoundedRectangleBorder(borderRadius: Dimension.rAll10),
                    clipBehavior: Clip.antiAlias,
                    child: CustomTile(
                      leading: Icon(CupertinoIcons.globe, color: context.color.primary),
                      title: context.l10n.language,
                      onTap: onTapLanguageChange,
                    ),
                  ),
                  Dimension.hBox12,
                  Material(
                    color: context.color.white,
                    shape: const RoundedRectangleBorder(borderRadius: Dimension.rAll10),
                    clipBehavior: Clip.antiAlias,
                    child: CustomTile(
                      leading: Assets.vectors.addHome.svg(
                        colorFilter: ColorFilter.mode(context.color.primary, BlendMode.srcATop),
                      ),
                      title: context.l10n.addToHomeScreenApp,
                      onTap: addToHomeScreen,
                    ),
                  ),
                  Dimension.hBox12,
                  Material(
                    color: context.color.white,
                    shape: const RoundedRectangleBorder(borderRadius: Dimension.rAll10),
                    clipBehavior: Clip.antiAlias,
                    child: CustomTile(
                      leading: Icon(Icons.logout, color: context.color.error),
                      title: context.l10n.signOut,
                      onTap: logOut,
                      textColor: context.color.error,
                      isLogout: true,
                    ),
                  ),

                  Dimension.hBox12,
                  Material(
                    color: context.color.white,
                    shape: const RoundedRectangleBorder(borderRadius: Dimension.rAll10),
                    clipBehavior: Clip.antiAlias,
                    child: CustomTile(
                      leading: Icon(Icons.switch_account_sharp, color: context.color.error),
                      title: 'Switch account',
                      onTap: () => context.goReplacementNamed(Routes.adminHome),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(formatVersion(), style: context.textTheme.sfProW400s12.copyWith(color: context.color.gray)),
            ),
          ],
        ),
      ),
    ),
  );
}
