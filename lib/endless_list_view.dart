library endless_list_view;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'widgets/loader.dart';

/// A widget that allows for infinite scrolling of a list of items. The list
/// will load more data when the user reaches the bottom of the list.
class EndlessListView<T> extends StatefulWidget {
  /// A list of initial items to display in the list.
  final List<Widget> initialItems;

  /// A function that returns a [Future] that will resolve to a list of new
  /// items to add to the end of the list when the user reaches the bottom.
  final Future<List<Widget>> Function() onLoadMoreData;

  /// Whether to add automatic keep alive widgets to the list.
  final bool addAutomaticKeepAlives;

  /// Whether to add repaint boundaries to the list.
  final bool addRepaintBoundaries;

  /// Whether to add semantic indexes to the list.
  final bool addSemanticIndexes;

  /// The amount of space before and after the visible items to cache.
  final double? cacheExtent;

  /// The clipping behavior of the widget.
  final Clip clipBehavior;

  /// The behavior for determining the start of a drag gesture.
  final DragStartBehavior dragStartBehavior;

  /// A function that returns the index of the child with the given key.
  final int? Function(Key)? findChildIndexCallback;

  /// The extent of each item in the list.
  final double? itemExtent;

  /// The number of items in the list.
  final int? itemCount;

  /// The controller for the scroll view.
  final ScrollController? controller;

  /// The physics of the scroll view.
  final ScrollPhysics? physics;

  /// The amount of padding around the edges of the list.
  final EdgeInsetsGeometry? padding;

  /// Whether to reverse the direction of the list.
  final bool reverse;

  /// The direction in which the list scrolls.
  final Axis scrollDirection;

  /// The number of children in the list that should have a semantic index.
  final int? semanticChildCount;

  /// The behavior for dismissing the keyboard on scroll.
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  /// The widget to display when more data is being loaded.
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

  /// Initializes the state of the [_EndlessListViewState] object.
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  /// Cleans up the resources used by the [_EndlessListViewState] object.
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Callback method for [_scrollController] to detect when the scroll is at the bottom.
  /// Calls [onLoadMoreData] to fetch more data and updates the state accordingly.
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

  /// This method builds the EndlessListView widget using a [ListView.builder]
  /// widget, which allows for an infinite list by loading more data when the
  /// user scrolls to the end of the current list. The [itemCount] parameter is
  /// set to the initial length of the list plus one if the list is currently
  /// loading more data. The builder function creates a [ListTile] for each item
  /// in the list or a [Loader] widget if the list is currently loading more
  /// data. The builder function also includes optional parameters such as
  /// [addAutomaticKeepAlives], [addRepaintBoundaries], [addSemanticIndexes],
  /// [cacheExtent], [clipBehavior], [dragStartBehavior], [findChildIndexCallback],
  /// [itemExtent], [keyboardDismissBehavior], [padding], [physics], [reverse],
  /// [scrollDirection], and [semanticChildCount] for further customization of
  /// the widget.
  ///
  /// ```dart
  /// EndlessListView<String>(
  ///   initialItems: ["Item 1", "Item 2", "Item 3"],
  ///   onLoadMoreData: () async {
  ///     // Load more data
  ///   },
  /// );
  /// ```
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
