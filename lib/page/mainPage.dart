import 'package:flutter/material.dart';
import 'package:fyp2/component/main_page/drawer.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.secondary,
        backgroundColor: Colors.transparent,
        title:  Text(
          "EzScan",
          style: GoogleFonts.dmSerifText(
            textStyle: TextStyle(
              color: Theme.of(context).colorScheme.secondary
            ),
          ),
        ),
      ),
      drawer: const MyDrawer(),

      body: Stack(
        children: [
          //DUMMY DATA
          Positioned.fill(
              child: ListView(
                children: [
                  ListTile(title: Text("Item 1")),
                  ListTile(title: Text("Item 2")),
                  ListTile(title: Text("Item 3")),
                  ListTile(title: Text("Item 4")),
                  ListTile(title: Text("Item 5")),
                  ListTile(title: Text("Item 6")),
                  ListTile(title: Text("Item 7")),
                  ListTile(title: Text("Item 8")),
                  ListTile(title: Text("Item 9")),
                  ListTile(title: Text("Item 10")),
                  ListTile(title: Text("Item 11")),
                  ListTile(title: Text("Item 12")),
                  ListTile(title: Text("Item 13")),
                  ListTile(title: Text("Item 14")),
                  ListTile(title: Text("Item 15")),
                  ListTile(title: Text("Item 16")),
                  ListTile(title: Text("Item 17")),
                  ListTile(title: Text("Item 18")),
                ],
              ),
          ),

          //Fixed button at bottom
          Positioned(
            bottom: 0, left: 0, right: 0,
              child: Container(
                color: Theme.of(context).colorScheme.surface,
                padding: EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                    padding: EdgeInsets.all(10.0),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  //PERFORM USER UPLOAD IMAGE, AND ESTIMATE CALORIE BY TRAINED MODEL
                  onPressed: (){},
                  child: Text(
                      "Estimate Calorie",
                      style: GoogleFonts.dmSerifText(fontSize: 16),
                  ),
                ),
              ),
          ),

        ],
      ),
    );
  }
}
