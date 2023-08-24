import 'package:flutter/material.dart';

void main() {
  runApp(Landing());
}

class Landing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Add your item 1 logic here
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Add your item 2 logic here
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Row(
          children: [
            GestureDetector(
              onTap: _openDrawer,
              child: Image.asset(
                'assets/images/menuicon.png', // Replace with your image asset
                width: 50,
                height: 50,
              ),
            ),
            const SizedBox(width: 10),
            const Text('Click the image to open the drawer'),
          ],
        ),
      ),
    );
  }
}
