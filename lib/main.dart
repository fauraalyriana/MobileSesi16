import 'package:flutter/material.dart';
import 'package:flutter_application_3/bloc/add_news_bloc.dart';
import 'package:flutter_application_3/bloc/listnews_bloc.dart';
import 'package:flutter_application_3/bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/listnewsdetail_bloc.dart';

import 'repository/login_repository.dart';
import 'layout/mainstate.dart';
import 'repository/news_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => LoginRepository()),
          RepositoryProvider(create: (context) => NewsRepository()),
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: ((context) => LoginBloc(
                      loginRepository: context.read<LoginRepository>())
                    ..add(LoginInitialEvent()))),
              BlocProvider(
                  create: ((context) => AddNewsBloc(
                      newsRepository: context.read<NewsRepository>())
                    ..add(AddNewsInitialEvent()))),
              BlocProvider(
                  create: ((context) => ListnewsBloc(
                      newsRepository: context.read<NewsRepository>())
                    ..add(TampilList()))),
              BlocProvider(
                  create: ((context) => ListnewsBloc(
                      newsRepository: context.read<NewsRepository>()))),
            ],
            child: MaterialApp(
              title: "STTB News",
              home: MainState(),
            )));
  }
}
