import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_3/repository/news_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'listnewsdetail_event.dart';
part 'listnewsdetail_state.dart';

class ListnewsdetailBloc
    extends Bloc<ListnewsdetailEvent, ListnewsdetailState> {
  NewsRepository newsRepository;
  ListnewsdetailBloc({required this.newsRepository})
      : super(LoadingNewsData()) {
    on<LoadNews>(_loadnews);
    on<DeleteNews>(_deletenews);
  }

  _loadnews(LoadNews event, Emitter emit) async {
    String id = event.newsId;

    emit(LoadingNewsData());

    List res = await newsRepository.selectNews(id);

    if (res.isNotEmpty) {
      emit(ListnewsdetailInitial(news: res));
    } else {
      emit(FailedLoadingNewsData(message: "Gagal memuat data"));
    }
  }

  _deletenews(DeleteNews event, Emitter emit) async {
    String id = event.newsId;
    String title = event.title;

    Map res = await newsRepository.deleteNews(id);

    if (res.isNotEmpty) {
      emit(NewsDeleted(title: title));
    } else {
      emit(FailedLoadingNewsData(message: "Gagal menghapus data"));
    }
  }
}
