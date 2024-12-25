import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_blog/screens/blog_list.dart';
import 'package:mini_blog/theme/theme_notifier.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<Homepage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Medium Yazıları"),
        actions: [
          IconButton(
              icon: Icon(
                ref.watch(themeProvider) == ThemeMode.light
                    ? Icons.nightlight_round
                    : Icons.wb_sunny,
              ),
              onPressed: () {
                final themeNotifier = ref.read(themeProvider.notifier);
                themeNotifier.toggleTheme(themeMode != ThemeMode.dark);
              }),
        ],
      ),
      body: BlogList(),
    );
  }
}
