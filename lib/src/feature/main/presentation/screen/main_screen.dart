import 'package:flutter/material.dart';

import '../../../../common/constant/gen/assets.gen.dart';
import '../../../../common/extension/context_extension.dart';
import '../../../../common/util/dimension.dart';
import '../../data/model/main_tabs_enum.dart';
import '../state/main_state.dart';
import '../../../cart/presentation/screen/cart_screen.dart';
import '../../../home/presentation/screen/home_screen.dart';
import '../../../profile/presentation/screen/profile_screen.dart';

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
    _pages = const [
      HomeScreen(),
      CartScreen(),
      ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: false,
    onPopInvokedWithResult: onPopInvokedWithResult,
    child: Scaffold(
      body: IndexedStack(
        index: currentTab.index,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab.index,
        onTap: onItemTapped,
        enableFeedback: true,
        type: BottomNavigationBarType.fixed,
        backgroundColor: context.color.background,
        selectedItemColor: context.color.primary,
        unselectedItemColor: context.color.gray,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 10,
        items: [
          _buildBottomItem(Assets.icons.home),
          _buildBottomItem(Assets.icons.cart),
          _buildBottomItem(Assets.icons.profile),
        ],
      ),
    ),
  );

  BottomNavigationBarItem _buildBottomItem(SvgGenImage icon) =>
      BottomNavigationBarItem(
        icon: _buildIcon(icon, isSelected: false),
        activeIcon: _buildSelectedIcon(icon),
        label: '',
      );

  Widget _buildSelectedIcon(SvgGenImage icon) => Column(
    children: [
      _buildIcon(icon, isSelected: true),
      Dimension.hBox4,
      Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: bottomNavigationAnimated ? 22 : 0,
          margin: EdgeInsets.only(left: bottomNavigationAnimated ? 0 : 11),
          height: 3,
          decoration: BoxDecoration(
            color: context.color.black,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    ],
  );

  Widget _buildIcon(SvgGenImage icon, {required bool isSelected}) => SizedBox(
    width: 25,
    child: Center(
      child: icon.svg(
        width: 25,
        height: 25,
        colorFilter: ColorFilter.mode(
          isSelected ? context.color.black : const Color(0xffBBBFD0),
          BlendMode.srcATop,
        ),
      ),
    ),
  );
}
