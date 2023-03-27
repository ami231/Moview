import 'package:flutter_bloc/flutter_bloc.dart';

class PageState {
  int page = 1;
  PageState({required this.page});
}

class PageCubit extends Cubit<PageState> {
  PageCubit() : super(PageState(page: 1));

  void nextPage() {
    emit(PageState(page: state.page + 1));
  }
}

