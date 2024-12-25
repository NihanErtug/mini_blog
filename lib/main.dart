import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mini_blog/blocs/articles/article_blog.dart';
import 'package:mini_blog/repo/article_repository.dart';
import 'package:mini_blog/screens/homepage.dart';

import 'package:mini_blog/theme/theme_notifier.dart';
import 'package:mini_blog/theme/themes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer();
  final themeNotifier = container.read(themeProvider.notifier);
  await themeNotifier.loadThemePreferences();

  runApp(UncontrolledProviderScope(container: container, child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    return BlocProvider(
      create: (context) => ArticleBlog(articleRepository: ArticleRepository()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeMode,
        home: Homepage(),
      ),
    );
  }
}
