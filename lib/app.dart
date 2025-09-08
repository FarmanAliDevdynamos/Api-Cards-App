import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/posts/view/posts_screen.dart';
import 'features/posts/viewmodel/posts_viewmodel.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostsViewModel()..fetchPosts()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MVVM Posts',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const PostsScreen(),
      ),
    );
  }
}
