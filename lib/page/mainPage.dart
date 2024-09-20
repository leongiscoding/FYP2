import 'package:flutter/material.dart';
import 'package:fyp2/component/main_page/drawer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const Text(
          "EzScan",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      drawer: const MyDrawer(),

      body: Stack(
        //DUMMY DATA
        children: <Widget>[
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
                color: Colors.white,
                padding: EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                    padding: EdgeInsets.all(10.0),
                    backgroundColor: Colors.grey.shade300,
                    foregroundColor: Colors.black
                  ),
                  //PERFORM USER UPLOAD IMAGE, AND ESTIMATE CALORIE BY TRAINED MODEL
                  onPressed: (){},
                  child: Text("Estimate Calorie"),
                ),
              ),
          ),

        ],
      ),
    );
  }
}
