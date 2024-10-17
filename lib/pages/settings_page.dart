import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_flutter_app/themeHandler/theme_data_style.dart';
import 'package:wallpaper_flutter_app/themeHandler/theme_provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
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
        ListTile(
          title: const Text("Theme "),
          trailing: Switch(
            value: themeProvider.themeDataStyle == ThemeDataStyle.dark
                ? true
                : false,
            onChanged: (isOn) {
              Provider.of<ThemeProvider>(context, listen: false)
                  .toggleTheme(isOn);
            },
          ),
        ),
        ListTile(
          title: const Text("About "),
          onTap: () {},
        )
      ],
    );
  }
}
