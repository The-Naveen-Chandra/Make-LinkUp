import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linkup_app/components/my_list_tile.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onSignOut;
  const MyDrawer({
    super.key,
    required this.onProfileTap,
    required this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      surfaceTintColor: Colors.transparent,
      width: MediaQuery.of(context).size.width / 1.4,
      child: Column(
        children: [
          // header
          const DrawerHeader(
            child: Icon(
              CupertinoIcons.link_circle_fill,
              size: 100,
              color: Colors.white,
            ),
          ),

          // home list tile
          MyListTile(
            icon: CupertinoIcons.home,
            text: "Home",
            onTap: () => Navigator.pop(context),
          ),

          // profile list tile
          MyListTile(
            icon: CupertinoIcons.profile_circled,
            text: "Profile",
            onTap: onProfileTap,
          ),

          const Spacer(),

          // logout list tile
          MyListTile(
            icon: Icons.logout_outlined,
            text: "Logout",
            onTap: onSignOut,
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
