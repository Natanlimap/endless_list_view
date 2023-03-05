# EndlessListView
The EndlessListView class is a Flutter widget that enables infinite scrolling behavior. It allows for loading more data when the user scrolls to the end of the current list. This widget is useful for displaying large lists of data that may not be available all at once, or for optimizing performance by reducing the amount of data loaded at any given time.

## Example Usage
``` 
import 'package:flutter/material.dart';
import 'package:endless_list_view/endless_list_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    return List.generate(20,
        (index) => Text('Item ${index + _items.length} - Loaded asynchronously'));
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
```

In this example, we create an EndlessListView widget and provide it with an initial list of 20 items. When the user scrolls to the end of the list, the _loadMoreData function is called, which simulates loading another 20 items asynchronously. These items are then added to the end of the list, and the user can continue scrolling infinitely.

## Installation
To use this widget in your own Flutter project, simply add the following line to your pubspec.yaml file:

```
dependencies:
  endless_list_view: ^0.0.2
```

Then, run flutter pub get to install the package.

## API Reference
For more information on how to use the InfiniteListView widget, refer to the API Reference on pub.dev.

## Contributions
Contributions to this package are welcome! If you find a bug or want to add a new feature, please open an issue or pull request on the GitHub repository.