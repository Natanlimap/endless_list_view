
## [0.1.0]
# Added
New optional parameter loadingWidget to the EndlessListView constructor, allowing users to customize the loading widget. If not provided, the default Loader widget is used.
# Changed
The EndlessListView widget now includes an additional item when new data is being loaded. This additional item is used to display the loadingWidget.
Modified the _onScroll method to prevent loading new data when new data is already being loaded. This avoids duplicate data being loaded.
Improved the internal state management to track whether new data is being loaded using a new private variable _loadingMore.
Minor code cleanups and improvements.
## [0.0.3] 
We have improved the EndlessListView Class by adding support for all parameters available in the ListView.builder constructor. This will give developers more flexibility and control when building infinite scrolling lists in their Flutter apps.
## [0.0.2] 
Rename method infiniteListView

## [0.0.1] 
Initial version, created by Natanlimap
