import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/constant/gen/assets.gen.dart';
import '../../../../../common/enum/bloc_status_enum.dart';
import '../../../../../common/extension/context_extension.dart';
import '../../../../../common/util/dimension.dart';
import '../../../../auth/bloc/auth_bloc.dart';
import '../../../cart/presentation/screen/cart_screen.dart';
import '../../../home/presentation/screen/home_screen.dart';
import '../../../profile/presentation/screen/profile_screen.dart';
import '../../data/model/main_tabs_enum.dart';
import '../state/main_state.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({this.initialTab = MainTabsEnum.home, super.key});

  final MainTabsEnum initialTab;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends MainState {
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = const [HomeScreen(), CartScreen(), ProfileScreen()];
  }

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: false,
    onPopInvokedWithResult: onPopInvokedWithResult,
    child: Scaffold(
      appBar: currentTab.isProfileTab
          ? null
          : AppBar(
              backgroundColor: context.color.primary,
              automaticallyImplyLeading: false,
              scrolledUnderElevation: 0,
              elevation: 0,
              toolbarHeight: context.telegramWebApp.safeAreaInset.top + 56,
              surfaceTintColor: context.color.transparent,
              title: Column(
                children: [
                  SizedBox(height: context.telegramWebApp.safeAreaInset.top.toDouble()),
                  Center(
                    child: Text(switch (currentTab.index) {
                      1 => context.l10n.cart,
                      _ => context.l10n.appName,
                    }, style: context.textTheme.nunitoW600s24.copyWith(color: context.color.white)),
                  ),
                ],
              ),
            ),
      body: IndexedStack(index: currentTab.index, children: _pages),
      bottomNavigationBar: Padding(
        padding: Dimension.pBottom10,
        child: DecoratedBox(
          decoration: BoxDecoration(color: context.color.gray),
          child: Padding(
            padding: Dimension.pTop1,
            child: BottomNavigationBar(
              currentIndex: currentTab.index,
              onTap: onItemTapped,
              enableFeedback: true,
              type: .fixed,
              backgroundColor: context.color.background,
              selectedItemColor: context.color.primary,
              unselectedItemColor: context.color.gray,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              elevation: 0,
              items: [
                _buildBottomItem(Assets.icons.home),
                _buildBottomItem(Assets.icons.cart),
                _buildBottomItem(Assets.icons.profile),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  BottomNavigationBarItem _buildBottomItem(SvgGenImage icon) => BottomNavigationBarItem(
    icon: _buildIcon(icon, isSelected: false),
    activeIcon: _buildSelectedIcon(icon),
    label: '',
  );

  Widget _buildSelectedIcon(SvgGenImage icon) => Column(
    crossAxisAlignment: .center,
    children: [
      _buildIcon(icon, isSelected: true),
      Dimension.hBox4,
      SizedBox(
        width: 25,
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: bottomNavigationAnimated ? 22 : 0,
            height: 3,
            decoration: BoxDecoration(color: context.color.black, borderRadius: const .all(.circular(10))),
          ),
        ),
      ),
    ],
  );

  Widget _buildIcon(SvgGenImage icon, {required bool isSelected}) => Column(
    children: [
      SizedBox(
        width: 25,
        child: Center(
          child: icon.svg(
            width: 25,
            height: 25,
            colorFilter: .mode(isSelected ? context.color.black : const Color(0xffBBBFD0), .srcATop),
          ),
        ),
      ),
      if (!isSelected) Dimension.hBox4,
    ],
  );
}
