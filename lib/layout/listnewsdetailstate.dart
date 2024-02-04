import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/listnewsdetail_bloc.dart';
import 'loading.dart';
import 'error.dart';
import 'listnewsdetailview.dart';

class ListNewsDetailState extends StatefulWidget {
  final String id;

  const ListNewsDetailState({required this.id});

  @override
  State<ListNewsDetailState> createState() => _ListNewsDetailStateState();
}

class _ListNewsDetailStateState extends State<ListNewsDetailState> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<ListnewsdetailBloc>().add(LoadNews(newsId: widget.id));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListnewsdetailBloc, ListNewsDetailState>(
      builder: (context, state) {
        if (state is LoadingNewsData) {
          return LoadingWidget();
        } else if (state is LoadedNewsData) {
          // Fixed: Changed ListNewsDetailState to LoadedNewsData
          return ListNewsDetailView(
            id: state.news[0]['id'],
            judul: state.news[0]['title'],
            gambar: state.news[0]['img'],
            date: state.news[0]['date'],
            deskripsi: state.news[0]['desc'],
          );
        } else if (state is FailedLoadingNewsData) {
          return ErrorNotif(message: state.message);
        } else if (state is NewsDeleted) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Hapus sukses"),
            ),
            body: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  Text("Berita ${state.title} berhasil dihapus"),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop('reload');
                    },
                    child: Text("Kembali ke halaman sebelumnya"),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container(
            child: Text("Error State"),
          );
        }
      },
    );
  }
}
