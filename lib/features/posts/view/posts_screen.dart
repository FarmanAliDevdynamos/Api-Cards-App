import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/posts_viewmodel.dart';
import '../widgets/post_card.dart';
import '../widgets/shimmer_loader.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PostsViewModel>();

    Widget body;
    switch (vm.state) {
      case PostState.loading:
        body = const ShimmerLoader();
        break;
      case PostState.error:
        body = Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Failed to load posts"),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => vm.fetchPosts(refresh: true),
                child: const Text("Retry"),
              ),
            ],
          ),
        );
        break;
      case PostState.empty:
        body = const Center(child: Text("No posts available"));
        break;
      case PostState.success:
        body = ListView.builder(
          itemCount: vm.posts.length + (vm.hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < vm.posts.length) {
              return PostCard(post: vm.posts[index]);
            } else {
              // Load More
              vm.loadMore();
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              );
            }
          },
        );
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: body,
    );
  }
}
