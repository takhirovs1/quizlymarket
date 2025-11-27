import 'package:flutter/cupertino.dart';

final class HomeRouterDelegate extends RouterDelegate<List<CupertinoPage<Object?>>> with ChangeNotifier {
  HomeRouterDelegate({required this.onDidRemovePage, required List<CupertinoPage<Object?>> pages}) : _pages = pages;

  final List<CupertinoPage<Object?>> _pages;
  final void Function(Page<Object?> pages)? onDidRemovePage;

  @override
  Widget build(BuildContext context) =>
      Navigator(key: navigatorKey, pages: List<CupertinoPage<Object?>>.of(_pages), onDidRemovePage: onDidRemovePage);

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Future<bool> popRoute() async {
    if (_pages.length > 1) {
      _pages.removeLast();
      notifyListeners();
      return true;
    }

    return false;
  }

  @override
  Future<void> setNewRoutePath(List<CupertinoPage<Object?>> configuration) async {
    _pages
      ..clear()
      ..addAll(configuration);

    notifyListeners();
  }

  void push(CupertinoPage<Object?> page) {
    _pages.add(page);
    notifyListeners();
  }

  void pop() {
    if (_pages.length > 1) {
      _pages.removeLast();
      notifyListeners();
    }
  }
}
