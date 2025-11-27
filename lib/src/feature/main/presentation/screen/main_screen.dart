import 'package:flutter/material.dart';

import '../../../../common/constant/gen/assets.gen.dart';
import '../../../../common/extension/context_extension.dart';

import '../../../card/presentation/screen/card_screen.dart';
import '../../../home/presentation/screen/home_screen.dart';

import '../../../settings/screen/settings_screen.dart';
import '../../data/model/main_tabs_enum.dart';
import '../state/main_state.dart';

/// {@template main_screen}
/// MainScreen widget.
/// {@endtemplate}
class MainScreen extends StatefulWidget {
  /// {@macro main_screen}
  const MainScreen({super.key, this.initialTab});

  /// Initial tab to display when the screen is first loaded
  final MainTabsEnum? initialTab;

  static _MainScreenState? maybeOf(BuildContext context) => context.findAncestorStateOfType<_MainScreenState>();

  @override
  State<MainScreen> createState() => _MainScreenState();
}

/// State for widget MainScreen.
class _MainScreenState extends MainState {
  @override
  Widget build(BuildContext context) => PopScope(
    canPop: canPop,
    onPopInvokedWithResult: onPopInvokedWithResult,
    child: Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const <Widget>[
          HomeScreen(),
          CardScreen(),
          SettingsScreen(),
        
        ],
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
                  for (final i in [
                    Assets.icons.home,
                    Assets.icons.cart,
                    Assets.icons.profile,
                  ])
                    NavigationDestination(
                      icon: SizedBox(
                        width: 25,
                        child: i.svg(colorFilter: const ColorFilter.mode(Color(0xFFBBBFD0), BlendMode.srcATop)),
                      ),
                      selectedIcon: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          SizedBox(
                            width: 25,
                            child: Center(
                              child: i.svg(colorFilter: ColorFilter.mode(context.color.onSurface, BlendMode.srcATop)),
                            ),
                          ),
                          Positioned(
                            bottom: 15,
                            left: 1.5,
                            child: Center(
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
