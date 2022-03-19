import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit_app/state.dart';
import 'package:social_app/network/local/cach_helper.dart';


class AppCubit extends Cubit<AppState> {
  AppCubit() : super(InitAppState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = true;

  void changeTheme({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
    } else {
      CachHelper.saveData(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeThemeStates());
      });
    }
    isDark = !isDark;
  }
}
