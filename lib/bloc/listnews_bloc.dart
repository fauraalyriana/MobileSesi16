import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_3/repository/news_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'listnews_event.dart';
part 'listnews_state.dart';

class ListnewsBloc extends Bloc<ListnewsEvent, ListnewsState> {
  NewsRepository newsRepository;
  ListnewsBloc({required this.newsRepository}) : super(LoadingListnews()) {
    on<TampilList>(_tampilList);
  }

  _tampilList(TampilList event, Emitter emit) async {
    String key = event.keyword;
    emit(LoadingListnews());
    List res = await newsRepository.getlistNews(key);
    log("dari bloc $res");
    emit(ListnewsInitial(news: res, searchText: key));
  }
}
