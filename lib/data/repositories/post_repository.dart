import '../models/post.dart';
import '../services/api_service.dart';

class PostRepository {
  final ApiService _api = ApiService();

  Future<List<Post>> fetchPosts(int start, int limit) async {
    try {
      final data = await _api.get("posts?_start=$start&_limit=$limit");
      print("Fetched data: $data"); // Debug print
      return data.map<Post>((json) => Post.fromJson(json)).toList();
    } catch (e) {
      print("Error fetching posts: $e"); // Debug print
      rethrow;
    }
  }
}
