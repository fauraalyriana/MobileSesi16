import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_3/bloc/login_bloc.dart';
import 'package:flutter_application_3/repository/news_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'add_news_event.dart';
part 'add_news_state.dart';

class AddNewsBloc extends Bloc<AddNewsEvent, AddNewsState> {
  NewsRepository newsRepository;

  AddNewsBloc({required this.newsRepository}) : super(AddNewsInitial()) {
    on<AddNewsInitialEvent>(_addnewsinitial);
    on<ClickTombolAddEvent>(_addnewsclick);
  }

  _addnewsinitial(AddNewsInitialEvent event, Emitter emit) async {
    emit(AddNewsLoadingState());
    emit(LoginInitial());
  }

  _addnewsclick(ClickTombolAddEvent event, Emitter emit) async {
    final String judul = event.title;
    final String deskripsi = event.desc;
    final String tanggal = event.date;
    final File gambar = event.image;
    emit(AddNewsLoadingState());

    try {
      final result = await newsRepository.addNews(
          title: judul, desc: deskripsi, date: tanggal, image: gambar);
      emit(AddNewsSuccessState());
      await Future.delayed(Duration(seconds: 3));
      emit(AddNewsInitial());
    } catch (error) {
      emit(AddNewsErrorState(message: "Error $error"));
    }
  }
}
