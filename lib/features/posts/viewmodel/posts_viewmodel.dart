import 'package:flutter/material.dart';
import '../../../data/models/post.dart';
import '../../../data/repositories/post_repository.dart';

enum PostState { loading, success, error, empty }

class PostsViewModel extends ChangeNotifier {
  final PostRepository _repo = PostRepository();

  List<Post> posts = [];
  PostState state = PostState.loading;
  bool isLoadingMore = false;
  bool hasMore = true;

  int _page = 0;
  final int _limit = 10;

  Future<void> fetchPosts({bool refresh = false}) async {
    if (refresh) {
      posts.clear();
      _page = 0;
      hasMore = true;
      state = PostState.loading;
      notifyListeners();
    }

    try {
      final newPosts = await _repo.fetchPosts(_page * _limit, _limit);
      if (newPosts.isEmpty && posts.isEmpty) {
        state = PostState.empty;
      } else {
        posts.addAll(newPosts);
        state = PostState.success;
        if (newPosts.length < _limit) {
          hasMore = false;
        }
        _page++;
      }
    } catch (e) {
      state = PostState.error;
    }
    notifyListeners();
  }

  Future<void> loadMore() async {
    if (isLoadingMore || !hasMore) return;
    isLoadingMore = true;
    notifyListeners();
    await fetchPosts();
    isLoadingMore = false;
  }
}
