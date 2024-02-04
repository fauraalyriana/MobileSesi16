import 'package:flutter/material.dart';
import '../bloc/listnews_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListNewsViews extends StatefulWidget {
  final List news;
  String searchText;
  const ListNewsViews({required this.news, required this.searchText});

  @override
  State<ListNewsViews> createState() => _ListNewsViewsState();
}

class _ListNewsViewsState extends State<ListNewsViews> {
  TextEditingController _search = TextEditingController();
  @override
  void initState() {
    super.initState();
    _search = TextEditingController(text: widget.searchText);
  }
}

Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("List News"),
    ),
    body: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          TextField(
            controller: _search,
            decoration: InputDecoration(labelText: "Search News"),
          ),
          ElevatedButton(
              onPressed: () {
                context.read <
                    ListnewsBloc().add(TampilList(keyword: _search.text));
              },
              child: Text("search")),
          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: Widget.news.length,
                  itemBuilder: (context, index) {
                    final Map newsItem = Widget.news[index];

                    return Card(
                      margin: EdgeInsets.all(8),
                      child: ListTile(
                        leading: Image.network(
                          newsItem['img'],
                          width: 50.0,
                          fit: BoxFit.cover,
                        ),
                        title: Text(newsItem['title']),
                        subtitle: Text(newsItem['date']),
                        onTap: () {},
                      ),
                    );
                  }))
        ],
      ),
    ),
  );
}
