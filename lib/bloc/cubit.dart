import 'package:flutter_bloc/flutter_bloc.dart';

class PageState {
  int page = 1;
  PageState({required this.page});
}

class MaxPageState {
  int maxPage = 2;
  MaxPageState({required this.maxPage});
}

class SearchState {
  
}

class PageCubit extends Cubit<PageState> {
  PageCubit() : super(PageState(page: 1));

  void nextPage() {
    emit(PageState(page: state.page + 1));
  }
}

class MaxPageCubit extends Cubit<MaxPageState> {
  MaxPageCubit() : super(MaxPageState(maxPage: 2));

  void updateMaxPage(number) {
    emit(MaxPageState(maxPage: number));
  }
}

