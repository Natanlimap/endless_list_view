library endless_list_view;

import 'package:flutter/material.dart';

class EndlessListView<T> extends StatefulWidget {
  final List<Widget> initialItems;
  final Future<List<Widget>> Function() onLoadMoreData;

  const EndlessListView({
    Key? key,
    required this.initialItems,
    required this.onLoadMoreData,
  }) : super(key: key);

  @override
  _EndlessListViewState<T> createState() => _EndlessListViewState<T>();
}

class _EndlessListViewState<T> extends State<EndlessListView<T>> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.extentAfter == 0) {
      widget.onLoadMoreData().then((newData) {
        setState(() {
          widget.initialItems.addAll(newData);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.initialItems.length,
      controller: _scrollController,
      itemBuilder: ((context, index) {
        if (index >= widget.initialItems.length) {
          return const SizedBox.shrink();
        }
        final item = widget.initialItems[index];

        return ListTile(
          title: item,
        );
      }),
    );
  }
}
