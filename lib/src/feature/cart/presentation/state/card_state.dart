import 'package:flutter/material.dart';

import '../../../../common/router/route_arguments.dart';
import '../screen/cart_screen.dart';

abstract class CartState extends State<CartScreen> {
  void onOpenTestScreen() {
    Navigator.of(context).pushNamed(Routes.testInit);
  }
}
