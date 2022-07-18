// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:messenger/helper.dart';

import 'package:messenger/pages/calls_page.dart';
import 'package:messenger/pages/contacts_page.dart';
import 'package:messenger/pages/messages_page.dart';
import 'package:messenger/pages/notifications_page.dart';
import 'package:messenger/theme.dart';
import 'package:messenger/widgets/avatar.dart';
import 'package:messenger/widgets/glowingActionButton.dart';
import 'package:messenger/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier('Messages');
  final pages = const [
    MessagesPage(),
    NotificationsPage(),
    CallsPage(),
    ContactsPage(),
  ];
  final pageTitles = const ['Messages', 'Notifications', 'Calls', 'Contacts'];
  void _OnNavigationItemSelected(index) {
    title.value = pageTitles[index];
    pageIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme,
        title: ValueListenableBuilder(
          valueListenable: title,
          builder: (BuildContext context, String value, _) {
            return Center(
              child: Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            );
          },
        ),
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(
              icon: CupertinoIcons.search,
              onTap: () {
                print('search');
              }),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Avatar.small(url: Helpers.randomPictureUrl()),
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (BuildContext context, int value, _) {
          return pages[value];
        },
      ),
      bottomNavigationBar: _BottonNavigationBar(
        onItemSelected: _OnNavigationItemSelected,
      ),
    );
  }
}

//Bottom Navigation Bar
class _BottonNavigationBar extends StatefulWidget {
  _BottonNavigationBar({Key? key, required this.onItemSelected})
      : super(key: key);

  final ValueChanged<int> onItemSelected;

  @override
  State<_BottonNavigationBar> createState() => _BottonNavigationBarState();
}

class _BottonNavigationBarState extends State<_BottonNavigationBar> {
  var selectedIndex = 0;
  void handledItemSelected(index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Card(
      color: (brightness == Brightness.light) ? Colors.transparent : null,
      elevation: 0,
      margin: EdgeInsets.zero,
      child: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavigationBarItem(
                index: 0,
                label: 'Messages',
                icon: CupertinoIcons.bubble_left_bubble_right_fill,
                isSelected: (selectedIndex == 0),
                onTap: handledItemSelected,
              ),
              _NavigationBarItem(
                index: 1,
                label: 'Notifications',
                icon: CupertinoIcons.bell_solid,
                isSelected: (selectedIndex == 1),
                onTap: handledItemSelected,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GlowingActionButton(
                    color: AppColors.secondary,
                    icon: CupertinoIcons.add,
                    onPressed: () {}),
              ),
              _NavigationBarItem(
                index: 2,
                label: 'Calls',
                icon: CupertinoIcons.phone_fill,
                isSelected: (selectedIndex == 2),
                onTap: handledItemSelected,
              ),
              _NavigationBarItem(
                index: 3,
                label: 'Contacts',
                icon: CupertinoIcons.person_2_fill,
                isSelected: (selectedIndex == 3),
                onTap: handledItemSelected,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  _NavigationBarItem(
      {Key? key,
      required this.index,
      required this.label,
      required this.icon,
      this.isSelected = false,
      required this.onTap})
      : super(key: key);

  final ValueChanged<int> onTap;
  final int index;
  final String label;
  final bool isSelected;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap(index);
      },
      child: SizedBox(
        // height: 50,
        width: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? AppColors.secondary : null,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              label,
              style: isSelected
                  ? TextStyle(
                      fontSize: 11,
                      color: AppColors.secondary,
                      fontWeight: FontWeight.bold)
                  : TextStyle(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
