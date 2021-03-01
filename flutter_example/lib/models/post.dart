Future<List<Post>> search(String search) async {
  await Future.delayed(Duration(seconds:1));
  return List.generate(search.length, (int index) {
    return Post(
        "Title : $search $index",
      "Description : $search $index",
    );
  });
}

class Post {
  final String title;
  final String description;

  Post(this.title, this.description);
}