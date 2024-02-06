import 'package:flutter/material.dart';

/// CustomTabBar is a reusable widget in Flutter that provides a customizable tab bar with multiple tabs.
///
/// It allows you to define the tab names and corresponding callback functions for each tab.
/// This widget is designed to be used in various screens where you need a tab bar with different functionalities.
///
/// Example usage in HomeScreen:
/// ```dart
/// final List<String> tabNames = ['Tab 1', 'Tab 2'];
/// final List<VoidCallback> tabCallbacks = [
///   () => // Callback function for Tab 1,
///   () => // Callback function for Tab 2,
/// ];
///
/// CustomTabBar(
///   tabNames: tabNames,
///   tabCallbacks: tabCallbacks,
/// )
/// ```
class CustomTabBar extends StatefulWidget {
  /// List of tab names to be displayed in the tab bar.
  final List<String> tabNames;

  /// List of callback functions corresponding to each tab. These callbacks are executed when a tab is selected.
  final List<VoidCallback> tabCallbacks;

  /// Constructor for CustomTabBar.
  ///
  /// The [tabNames] parameter is a list of tab names to be displayed in the tab bar.
  /// The [tabCallbacks] parameter is a list of callback functions corresponding to each tab.
  /// Make sure that the length of [tabNames] and [tabCallbacks] match.
  const CustomTabBar({required this.tabNames, required this.tabCallbacks, super.key});

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabNames.length, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      // Execute the callback function corresponding to the selected tab.
      widget.tabCallbacks[_tabController.index]();
    }
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.background,
            ),
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              controller: _tabController,
              indicator: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
              labelColor: Theme.of(context).colorScheme.background,
              unselectedLabelColor: Theme.of(context).colorScheme.outline,
              labelPadding: const EdgeInsets.symmetric(vertical: 14),
              tabs: widget.tabNames.map((name) => Text(name)).toList(),
            ),
          ),
        ],
      );

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }
}
