part of 'add_news_bloc.dart';

@immutable
sealed class AddNewsState extends Equatable {}

final class AddNewsInitial extends AddNewsState {
  @override
  List<Object> get props => [];
}

final class AddNewsLoadingState extends AddNewsState {
  @override
  List<Object> get props => [];
}

final class AddNewsSuccessState extends AddNewsState {
  @override
  List<Object> get props => [];
}

final class AddNewsErrorState extends AddNewsState {
  String message;

  AddNewsErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
