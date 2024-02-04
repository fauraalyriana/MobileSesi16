part of 'add_news_bloc.dart';

@immutable
sealed class AddNewsEvent extends Equatable {}

final class AddNewsInitialEvent extends AddNewsEvent {
  @override
  List<Object> get props => [];
}

final class ClickTombolAddEvent extends AddNewsEvent {
  final String title;
  final String desc;
  final String date;
  final File image;

  ClickTombolAddEvent(
      {required this.title,
      required this.desc,
      required this.date,
      required this.image});
  @override
  List<Object> get props => [title, desc, date, image];
}
