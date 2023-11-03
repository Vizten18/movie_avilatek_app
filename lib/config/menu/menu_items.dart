import 'package:flutter/material.dart';

//Menu object list item for the drawer
class MenuItem {
  final String title;
  final String subtitle;
  final String link;
  final IconData icon;

  const MenuItem({
    required this.title,
    required this.subtitle,
    required this.link,
    required this.icon,
  });
}

const appMenuItems = <MenuItem>[
  MenuItem(
    title: 'Settings',
    subtitle: '',
    link: '/Config',
    icon: Icons.settings,
  ),
];
