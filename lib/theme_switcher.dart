import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_notifier.dart'; // Import the theme notifier

class ThemeSwitcher {
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
                  Provider.of<ThemeNotifier>(context, listen: false).toggleThemeToLight();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Dark Mode'),
                onTap: () {
                  Provider.of<ThemeNotifier>(context, listen: false).toggleThemeToDark();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Purple Mode'),
                onTap: () {
                  Provider.of<ThemeNotifier>(context, listen: false).toggleThemeToPurple();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void show(BuildContext context) {
    _showModeDialog(context);
  }
}
