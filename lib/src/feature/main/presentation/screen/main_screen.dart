import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/constant/gen/assets.gen.dart';
import '../../../../common/extension/context_extension.dart';
import '../../../../common/util/dimension.dart';
import '../state/main_state.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends MainState {
  @override
  Widget build(BuildContext context) => PopScope(
    canPop: false,
    child: Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.navigationShell.currentIndex,
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
