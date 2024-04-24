class Blog {
  String? id;
  String? title;
  String? content;
  String? thumbnail;
  String? author;

  Blog({
    this.id,
    this.title,
    this.content,
    this.thumbnail,
    this.author,
  });

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        thumbnail: json["thumbnail"],
        author: json["author"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "tumbnail": thumbnail,
        "author": author,
      };
}
