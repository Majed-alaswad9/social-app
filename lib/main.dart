import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit_app/cubit.dart';
import 'package:social_app/home/home_layout.dart';
import 'package:social_app/shared/end_point.dart';
import 'cubit_app/bloc_provider.dart';
import 'cubit_app/state.dart';
import 'login_register/login_app.dart';
import 'network/local/cach_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CachHelper.init();
  Widget stateWidget;
  uId = CachHelper.getData(key: 'uId');
  bool? isDark = CachHelper.getData(key: 'isDark') ?? true;
  if (uId != null) {
    stateWidget = const HomeLayout();
  } else {
    stateWidget = LoginApp();
  }
  runApp(MyApp(stateWidget, isDark!));
}

class MyApp extends StatelessWidget {
  final Widget _widget;
  final bool isDark;

  const MyApp(this._widget, this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AppCubit()..changeTheme(),
        child: BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                appBarTheme: const AppBarTheme(
                    titleTextStyle: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                    iconTheme: IconThemeData(color: Colors.blue),
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark)),
                primarySwatch: Colors.blue,
                textTheme: const TextTheme(
                  bodyText1: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                ),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Colors.white,
                    elevation: 10,
                    selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold)),
              ),
              darkTheme: ThemeData(
                scaffoldBackgroundColor: Colors.grey[700],
                floatingActionButtonTheme: const FloatingActionButtonThemeData(
                    backgroundColor: Colors.black),
                appBarTheme: const AppBarTheme(
                  titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  iconTheme: IconThemeData(color: Colors.white),
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.black45,
                      statusBarIconBrightness: Brightness.light),
                  backgroundColor: Colors.black45,
                ),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  elevation: 10,
                  backgroundColor: Colors.black45,
                ),
                cardColor: Colors.black45,
                textTheme: const TextTheme(
                  bodyText1: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                ),
              ),
              themeMode: AppCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: _widget,
            );
          },
        ));
  }
}
