import 'package:flutter/material.dart';
import 'package:flutter_application_3/bloc/login_bloc.dart';
import 'package:flutter_application_3/layout/dashboard.dart';
import 'package:flutter_application_3/layout/loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/add_news_bloc.dart';
import 'adddataform.dart';
import 'error.dart';

class AddState extends StatefulWidget {
  const AddState({super.key});

  @override
  State<AddState> createState() => _AddStateState();
}

class _AddStateState extends State<AddState> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddNewsBloc, AddNewsState>(
      builder: (context, state) {
        if (state is AddNewsInitial) {
          return AddDataForm();
        } else if (state is AddNewsLoadingState) {
          return LoadingWidget();
        } else if (state is AddNewsSuccessState) {
          return AddDataForm();
        } else if (state is AddNewsErrorState) {
          return ErrorNotif(message: state.message);
        } else {
          return Container(
            child: Text("Error state"),
          );
        }
      },
    );
  }
}
