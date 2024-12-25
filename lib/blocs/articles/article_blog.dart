import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_blog/blocs/articles/article_event.dart';
import 'package:mini_blog/blocs/articles/article_state.dart';
import 'package:mini_blog/repo/article_repository.dart';

class ArticleBlog extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepository articleRepository;

  ArticleBlog({required this.articleRepository}) : super(ArticlesNotLoaded()) {
    on<FetchArticles>(_fetchArticles);
  }

// emit -> değiştirici
  void _fetchArticles(FetchArticles event, Emitter<ArticleState> emit) async {
    emit(ArticlesLoading());
    try {
      final blogs = await articleRepository.fetchAll();
      emit(ArticlesLoaded(blogs: blogs));
    } catch (e) {
      emit(AtriclesLoadFail());
    }
  }
}
