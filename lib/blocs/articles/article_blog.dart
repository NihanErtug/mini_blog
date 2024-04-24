import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_blog/blocs/articles/article_event.dart';
import 'package:mini_blog/blocs/articles/article_state.dart';
import 'package:mini_blog/repositories/article_repository.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepository articleRepository;
  // alt taraf başlangıç state'i(initial state)
  ArticleBloc({required this.articleRepository}) : super(ArticlesNotLoaded()) {
    on<FetchArticles>(_fetchArticles);
  }
// emit -> değiştirici
  void _fetchArticles(FetchArticles event, Emitter<ArticleState> emit) async {
    // fonk. çalıştığı anda article state'i bununla (loading) değiştirecek.
    emit(ArticlesLoading());
    try {
      final blogs = await articleRepository.fetchAll();
      emit(ArticlesLoaded(blogs: blogs));
    } catch (e) {
      emit(ArticlesLoadFail());
    }
  }
}
