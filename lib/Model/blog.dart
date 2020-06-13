class Blog {
  final String title;
  final String content;

  Blog({this.title, this.content});

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      title: json['title'],
      content: json['content'],
    );
  }
}