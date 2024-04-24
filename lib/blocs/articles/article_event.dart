// eventler -> stateler arası geçişi sağlayabilecek aksiyonlar

abstract class ArticleEvent {}

// article ları çekecek event
class FetchArticles extends ArticleEvent {}
