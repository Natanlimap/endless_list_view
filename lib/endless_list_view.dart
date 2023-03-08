library endless_list_view;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'widgets/loader.dart';

class EndlessListView<T> extends StatefulWidget {
  final List<Widget> initialItems;
  final Future<List<Widget>> Function() onLoadMoreData;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;
  final Clip clipBehavior;
  final DragStartBehavior dragStartBehavior;
  final int? Function(Key)? findChildIndexCallback;
  final double? itemExtent;
  final int? itemCount;
  final ScrollController? controller;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final bool reverse;
  final Axis scrollDirection;
  final int? semanticChildCount;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final Widget? loadingWidget;
  const EndlessListView({
    Key? key,
    required this.initialItems,
    required this.onLoadMoreData,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.clipBehavior = Clip.hardEdge,
    this.dragStartBehavior = DragStartBehavior.start,
    this.findChildIndexCallback,
    this.itemExtent,
    this.cacheExtent,
    this.itemCount,
    this.controller,
    this.loadingWidget,
    this.physics,
    this.padding,
    this.reverse = false,
    this.scrollDirection = Axis.vertical,
    this.semanticChildCount,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
  }) : super(key: key);

  @override
  _EndlessListViewState<T> createState() => _EndlessListViewState<T>();
}

class _EndlessListViewState<T> extends State<EndlessListView<T>> {
  final ScrollController _scrollController = ScrollController();
  bool _loadingMore = false;

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
    if (_scrollController.position.extentAfter == 0 && !_loadingMore) {
      setState(() {
        _loadingMore = true;
      });

      widget.onLoadMoreData().then((newData) {
        setState(() {
          widget.initialItems.addAll(newData);
          _loadingMore = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.initialItems.length + (_loadingMore ? 1 : 0),
      addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
      addRepaintBoundaries: widget.addRepaintBoundaries,
      addSemanticIndexes: widget.addSemanticIndexes,
      clipBehavior: widget.clipBehavior,
      dragStartBehavior: widget.dragStartBehavior,
      findChildIndexCallback: widget.findChildIndexCallback,
      itemExtent: widget.itemExtent,
      cacheExtent: widget.cacheExtent,
      controller: _scrollController,
      keyboardDismissBehavior: widget.keyboardDismissBehavior,
      padding: widget.padding,
      physics: widget.physics,
      reverse: widget.reverse,
      scrollDirection: widget.scrollDirection,
      semanticChildCount: widget.semanticChildCount,
      itemBuilder: ((context, index) {
        if (index >= widget.initialItems.length) {
          return widget.loadingWidget ?? Loader(isLoading: _loadingMore);
        }
        final item = widget.initialItems[index];

        return ListTile(
          title: item,
        );
      }),
    );
  }
}
