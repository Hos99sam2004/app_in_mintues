import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<String> colors = ['default', 'purple', 'orange', 'teal', 'gold'];
  late int _colorIndex;

  @override
  void initState() {
    super.initState();
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    _colorIndex = colors.indexOf(themeProvider.colorScheme);
    if (_colorIndex == -1) _colorIndex = 3; // gold
  }

  void _cycleColor() {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    _colorIndex = (_colorIndex + 1) % colors.length;
    themeProvider.setTheme(themeProvider.themeMode, colors[_colorIndex]);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final textColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.white;
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: [
          IconButton(icon: Icon(Icons.palette), onPressed: _cycleColor),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Theme Mode
            Text(
              'Theme Mode:',
              style: TextStyle(color: textColor, fontSize: 18),
            ),
            RadioListTile<String>(
              title: Text('Light', style: TextStyle(color: textColor)),
              value: 'light',
              groupValue: themeProvider.themeMode,
              onChanged: (value) {
                themeProvider.setTheme(value!, themeProvider.colorScheme);
              },
            ),
            RadioListTile<String>(
              title: Text('Dark', style: TextStyle(color: textColor)),
              value: 'dark',
              groupValue: themeProvider.themeMode,
              onChanged: (value) {
                themeProvider.setTheme(value!, themeProvider.colorScheme);
              },
            ),
            SizedBox(height: 20),
            // Color Scheme
            Text(
              'Color Scheme:',
              style: TextStyle(color: textColor, fontSize: 18),
            ),
            RadioListTile<String>(
              title: Text('Default', style: TextStyle(color: textColor)),
              value: 'default',
              groupValue: themeProvider.colorScheme,
              onChanged: (value) {
                themeProvider.setTheme(themeProvider.themeMode, value!);
              },
            ),
            RadioListTile<String>(
              title: Text('Purple', style: TextStyle(color: textColor)),
              value: 'purple',
              groupValue: themeProvider.colorScheme,
              onChanged: (value) {
                themeProvider.setTheme(themeProvider.themeMode, value!);
              },
            ),
            RadioListTile<String>(
              title: Text('Orange', style: TextStyle(color: textColor)),
              value: 'orange',
              groupValue: themeProvider.colorScheme,
              onChanged: (value) {
                themeProvider.setTheme(themeProvider.themeMode, value!);
              },
            ),
            RadioListTile<String>(
              title: Text('Teal', style: TextStyle(color: textColor)),
              value: 'teal',
              groupValue: themeProvider.colorScheme,
              onChanged: (value) {
                themeProvider.setTheme(themeProvider.themeMode, value!);
              },
            ),
            RadioListTile<String>(
              title: Text('Gold', style: TextStyle(color: textColor)),
              value: 'gold',
              groupValue: themeProvider.colorScheme,
              onChanged: (value) {
                themeProvider.setTheme(themeProvider.themeMode, value!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
