class Blog {
  String? id;
  String? title;
  String? content;
  String? pubDate;
  String? author;
  Blog({
    this.id,
    this.title,
    this.content,
    this.pubDate,
    this.author,
  });

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        pubDate: json['pubDate'],
        author: json['author'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "pubDate": pubDate,
        "author": author,
      };
}
