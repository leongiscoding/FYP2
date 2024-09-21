import 'package:flutter/material.dart';
import 'package:fyp2/component/login_signup/logo_widget.dart';
import 'package:fyp2/component/main_page/drawer_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            child: LogoWidget(),
          ),
          Padding(
              padding: EdgeInsets.only(left: 10.0,bottom: 10.0,top: 10.0),
            child: Text("Easy Scan, Your Best Partner"),
          ),

          //PROFILE NAVIGATOR
          DrawerTile(
              title: "Profile",
              leading: const Icon(Icons.person),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, "/profilePage");
              },
          ),

          //LOG OUT NAVIGATOR
          DrawerTile(
              title: "Log Out",
              leading: const Icon(Icons.logout),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, "/loginPage");
              },
          ),
        ],
      ),
    );
  }
}
