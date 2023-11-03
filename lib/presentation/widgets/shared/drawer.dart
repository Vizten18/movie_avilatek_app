import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_avilatek_app/config/menu/menu_items.dart';

class DrawerMenu extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const DrawerMenu({super.key, required this.scaffoldKey});

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;

    return NavigationDrawer(
        selectedIndex: navDrawerIndex,
        onDestinationSelected: (value) {
          setState(() {
            navDrawerIndex = value;
          });

          final menuItem = appMenuItems[value];
          context.push(menuItem.link);
          widget.scaffoldKey.currentState?.openDrawer();
        },
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(28, hasNotch ? 0 : 20, 16, 10),
            child: const Text('Choose Screen'),
          ),

          //import MenuOption with spread operator
          ...appMenuItems.sublist(0, 1).map(
                (item) => NavigationDrawerDestination(
                  icon: Icon(item.icon),
                  label: Text(item.title),
                ),
              ),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
            child: Divider(),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
            child: Text('More options'),
          ),
          //more options, this app just have 2 screen for navigate
          // ...appMenuItems.sublist(2).map(
          //       (item) => NavigationDrawerDestination(
          //         icon: Icon(item.icon),
          //         label: Text(item.title),
          //       ),
          //     ),
        ]);
  }
}
