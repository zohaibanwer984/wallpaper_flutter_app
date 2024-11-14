import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper_flutter_app/themeHandler/theme_data_style.dart';
import 'package:wallpaper_flutter_app/themeHandler/theme_provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  // Define a list of accent colors to display in the color picker
  final List<Color> accentColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
  ];
  bool isDarkMode = false;
  // Load theme preference
  @override
  void initState() {
    super.initState();
    _loadThemeValue();
  }

  void _loadThemeValue() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = pref.getBool('theme') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return ListView(
      padding: const EdgeInsets.all(5),
      physics: const BouncingScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Settings",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        // Theme toggle switch
        ListTile(
          title: const Text("Dark Mode "),
          trailing: Switch(
            value: isDarkMode,
            onChanged: (isOn) {
              Provider.of<ThemeProvider>(context, listen: false)
                  .toggleTheme(isOn);
              setState(() {
                isDarkMode = isOn;
              });
            },
          ),
        ),
        const SizedBox(height: 20),

        // Accent Color Picker
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Accent Color",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          children: accentColors.map((color) {
            return GestureDetector(
              onTap: () {
                themeProvider.setAccentColor(color);
              },
              child: Container(
                margin: const EdgeInsets.all(8),
                width: 40,
                height: 40,
                child: (themeProvider.accentColor == color)
                    ? Icon(
                        Icons.done_outline,
                        color: Colors.white,
                      )
                    : null,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: themeProvider.themeDataStyle.disabledColor,
                    width: 2,
                  ),
                ),
              ),
            );
          }).toList(),
        ),

        // About option
        ListTile(
          title: const Text("About us"),
          onTap: () {
            // Add about dialog or page logic here
          },
        ),
      ],
    );
  }
}
