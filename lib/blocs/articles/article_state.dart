// abstract olma nedeni -> bütün articlestate leri temsil edecek ortak bir class olması için
// Burada durumlarımızı belirttik.  State ler içinde veri taşıyabilir.

import 'package:mini_blog/models/blog.dart';

abstract class ArticleState {}

class ArticlesNotLoaded extends ArticleState {}

class ArticlesLoaded extends ArticleState {
  final List<Blog> blogs;

  ArticlesLoaded({required this.blogs});
}

class ArticlesLoading extends ArticleState {}

class ArticlesLoadFail extends ArticleState {}
