import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram_web_app/telegram_web_app.dart';

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
      body: Padding(
        padding: EdgeInsets.only(top: TelegramWebApp.instance.safeAreaInset.top.toDouble()),
        child: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const <Widget>[HomeScreen(), CartScreen(), ProfileScreen()],
        ),
      ),
      // In your MainScreen build (bottomNavigationBar):
      bottomNavigationBar: bottomNavBarEnabled
          ? Theme(
              data: context.theme.copyWith(splashFactory: NoSplash.splashFactory),
              child: NavigationBar(
                indicatorColor: Colors.transparent,
                elevation: 10,
                backgroundColor: context.color.white,
                destinations: [
                  for (final i in [Assets.icons.home, Assets.icons.cart, Assets.icons.profile])
                    NavigationDestination(
                      icon: SizedBox(width: 25, child: i.svg(colorFilter: const .mode(Color(0xFFBBBFD0), .srcATop))),
                      selectedIcon: Stack(
                        clipBehavior: .none,
                        children: [
                          SizedBox(
                            width: 25,
                            child: Center(child: i.svg(colorFilter: .mode(context.color.primary, .srcATop))),
                          ),
                          Positioned(
                            bottom: 15,
                            left: 1.5,
                            child: Center(
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                width: bottomNavigationAnimated ? 22 : 0,
                                margin: .only(left: bottomNavigationAnimated ? 0 : 11),
                                height: 3,
                                decoration: BoxDecoration(
                                  color: context.color.primary,
                                  borderRadius: const .all(.circular(10)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      label: '',
                    ),
                ],
                selectedIndex: currentTab.index,
                onDestinationSelected: onItemTapped,
              ),
            )
          : null,
    ),
  );
}
