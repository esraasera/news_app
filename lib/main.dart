import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/bloc_observer.dart';
import 'package:news_app/layout/app_layout.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBoolData(key: 'isDark');
  runApp(MyApp(isDark));
  Bloc.observer = MyBlocObserver();
}

class MyApp extends StatelessWidget {
final bool? isDark;
MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getBusinessData()..getSportsData()..getScienceData()..changeAppTheme(
          fromShared :isDark
      ),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context, AppStates state) {  },
        builder: (BuildContext context, AppStates state) {
          return MaterialApp(
            debugShowCheckedModeBanner:false,
            theme:ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor:Colors.white,
              appBarTheme:AppBarTheme(
                  titleSpacing:20.0,
                  iconTheme: IconThemeData(
                      color: Colors.black
                  ),
                  backgroundColor:Colors.white,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarIconBrightness:Brightness.dark,
                    statusBarColor: Colors.white,
                  ),
                  titleTextStyle:TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )
              ) ,
              bottomNavigationBarTheme:BottomNavigationBarThemeData(
                backgroundColor:Colors.white ,
                elevation:30.0,
                selectedItemColor:Colors.deepOrange,
                type:BottomNavigationBarType.fixed,
              ),
              inputDecorationTheme: InputDecorationTheme(
                enabledBorder: OutlineInputBorder(
                  borderSide:  BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
              textTheme: TextTheme(
                bodyLarge:TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize:18.0,
                ) ,
              ),

            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor:HexColor('272525'),
              appBarTheme: AppBarTheme(
                  iconTheme: IconThemeData(
                    color: Colors.white,
                  ),
                  backgroundColor:HexColor('272525'),
                  titleSpacing: 20.0,
                  systemOverlayStyle:SystemUiOverlayStyle(
                    statusBarColor: HexColor('272525'),
                    statusBarIconBrightness:Brightness.light,
                  ) ,
                  titleTextStyle: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )
              ),
              bottomNavigationBarTheme:BottomNavigationBarThemeData(
                type:BottomNavigationBarType.fixed,
                backgroundColor:HexColor('272525'),
                selectedItemColor:Colors.deepOrange,
                elevation: 30.0,
                unselectedItemColor: Colors.grey,
              ),
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: Colors.grey[700],
                enabledBorder: OutlineInputBorder(
                  borderSide:  BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
              textTheme: TextTheme(
                bodyLarge:TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize:18.0,
                ) ,
              ),
            ),
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home:NewsLayoutScreen() ,
          );

        },
      ),
    );
  }
}