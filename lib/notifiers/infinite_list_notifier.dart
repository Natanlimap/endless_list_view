import 'package:flutter/material.dart';

class InfiniteListNotifier extends ChangeNotifier {
  final List<Widget> _items = [];

  List<Widget> get items => _items;

  void addItems(List<Widget> newItems) {
    _items.addAll(newItems);
    notifyListeners();
  }
}
