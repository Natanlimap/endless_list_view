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
      title: 'EndlessListView Example',
      home: EndlessListViewExample(),
    );
  }
}

class EndlessListViewExample extends StatefulWidget {
  @override
  _EndlessListViewExampleState createState() => _EndlessListViewExampleState();
}

class _EndlessListViewExampleState extends State<EndlessListViewExample> {
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
        title: Text('EndlessListView Example'),
      ),
      body: EndlessListView(
        initialItems: _items,
        onLoadMoreData: _loadMoreData,
      ),
    );
  }
}
