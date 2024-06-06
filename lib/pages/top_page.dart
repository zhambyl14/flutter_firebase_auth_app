import 'package:flutter/material.dart';
import '../bottom_nav_bar.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  bool isWorldSelected = true;
  bool isRegionSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Top Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Perform user-specific action
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero, // Remove the default padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // Set the border radius
                    side: BorderSide(color: Colors.black, width: 2), // Add a black border
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Add padding for the text
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Minimize the column width
                    children: [
                      SizedBox(height: 10), // Add some space between the icon and text
                      Text('Achievements', style: TextStyle(fontSize: 22.0, color: Colors.black, fontFamily: 'Times New Roman')), // Text
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                'Stats',
                // Replace with user's name
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, fontFamily: 'Times New Roman'),
              ),
            ),
            Divider(
              height: 1, // Line height
              thickness: 1, // Line thickness
              color: Colors.black, // Line color
            ),
            Center(
              child: Text(
                'Level: 50\nRecord: 72\nCoins: 50',
                // Replace with user's name
                style: TextStyle(fontSize: 20.0, fontFamily: 'Times New Roman'),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16.0),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50), // Set the card corner radius
                side: BorderSide(color: Colors.black, width: 2), // Add a black border
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Top', // "Top" text
                      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, fontFamily: 'Times New Roman'),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isWorldSelected = true;
                              isRegionSelected = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isWorldSelected ? Color.fromARGB(236, 255, 255, 255) : Color.fromARGB(239, 189, 189, 192), // Set the button background color
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Add padding for the text
                          ),
                          child: Text('World', style: TextStyle(color: isWorldSelected ? Colors.black : Colors.black, fontFamily: 'Times New Roman')),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isWorldSelected = false;
                              isRegionSelected = true;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isRegionSelected ? Color.fromARGB(236, 255, 255, 255) : Color.fromARGB(239, 180, 180, 189), // Set the button background color
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Add padding for the text
                          ),
                          child: Text('Region', style: TextStyle(color: isRegionSelected ? Colors.black : Colors.black, fontFamily: 'Times New Roman')),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    if (isWorldSelected)
                      Text('Player 1\nPlayer 2\nPlayer 3\nPlayer 4\nPlayer 5', style: TextStyle(fontFamily: 'Times New Roman')), // Content for "World" button
                    if (isRegionSelected)
                      Text('Player 1\nPlayer 2\nPlayer 3\nPlayer 4', style: TextStyle(fontFamily: 'Times New Roman')), // Content for "Region" button
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 0),
    );
  }
}
