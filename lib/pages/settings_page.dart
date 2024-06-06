import 'package:flutter/material.dart';
import '../bottom_nav_bar.dart';
import 'map_page.dart';  // Make sure to import your MapScreen or MapPage if it's in a different file

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  void _showModeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Mode'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: const Text('Light Mode'),
                onTap: () {
                  // Set light mode
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Dark Mode'),
                onTap: () {
                  // Set dark mode
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSquareButton({required String text, required IconData icon, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: SizedBox(  // Wrap the content in a SizedBox to limit the size
        width: 80,  // Fixed width for all buttons
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 40, color: Colors.black),  // Fixed size for all icons
            const SizedBox(height: 10),
            Flexible(  // Use Flexible to limit the text length and allow it to wrap if needed
              child: Text(
                text,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                textAlign: TextAlign.center,  // Center align the text
                maxLines: 2,  // Limit the number of lines to prevent overflow
                overflow: TextOverflow.ellipsis,  // Use ellipsis for overflow
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Settings Page"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Settings',
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, fontFamily: 'Times New Roman'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSquareButton(
                  text: 'Language',
                  icon: Icons.language,
                  onPressed: () {},
                ),
                _buildSquareButton(
                  text: 'Donate',
                  icon: Icons.monetization_on,
                  onPressed: () {},
                ),
                _buildSquareButton(
                  text: 'Logout',
                  icon: Icons.logout,
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSquareButton(
                  text: 'Mode',
                  icon: Icons.lightbulb_outline,
                  onPressed: () {
                    _showModeDialog(context);
                  },
                ),
                _buildSquareButton(
                  text: 'Mute',
                  icon: Icons.volume_off,
                  onPressed: () {},
                ),
                _buildSquareButton(
                  text: 'Map',
                  icon: Icons.map,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapPage()),
                    );
                  },
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 240.0),
              child: Text(
                '© YMBA SE-2225\n   Version: 1.0.0',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Times New Roman'),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
    );
  }
}
