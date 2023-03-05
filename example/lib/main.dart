import 'package:flutter/material.dart';
import 'package:endless_list_view/endless_list_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InfiniteListView Example',
      home: InfiniteListViewExample(),
    );
  }
}

class InfiniteListViewExample extends StatefulWidget {
  @override
  _InfiniteListViewExampleState createState() =>
      _InfiniteListViewExampleState();
}

class _InfiniteListViewExampleState extends State<InfiniteListViewExample> {
  final List<Widget> _items = List.generate(20, (index) => Text('Item $index'));

  Future<List<Widget>> _loadMoreData() async {
    await Future.delayed(Duration(seconds: 2));
    return List.generate(
        20,
        (index) =>
            Text('Item ${index + _items.length} - Loaded asynchronously'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('InfiniteListView Example'),
      ),
      body: InfiniteListView(
        initialItems: _items,
        onLoadMoreData: _loadMoreData,
      ),
    );
  }
}
