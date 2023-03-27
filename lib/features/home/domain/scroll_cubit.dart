import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScrollControllerCubit extends Cubit<ScrollController> {
  ScrollControllerCubit() : super(ScrollController());

  void setController(ScrollController scrollController) {
    emit(scrollController);
  }
}