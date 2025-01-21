import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/business/business.dart';
import 'package:news_app/modules/science/science.dart';
import 'package:news_app/modules/sports/sports.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'science',
    ),
  ];

  void changeCurrentIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void getBusinessData() {
    emit(AppGetBusinessLoadingState());
    DioHelper.getData(
      url: 'top-headlines',
      query: {
        'category': 'business',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
        'language': 'en',
      },
    ).then((value) {
      if (value.data['status'] == 'ok' && value.data['articles'] != null) {
        business = value.data['articles'];
        emit(AppGetBusinessDataSuccessState());
      } else {
        emit(AppGetBusinessDataErrorState('No business articles found.'));
      }
    }).catchError((error) {
      emit(AppGetBusinessDataErrorState(error.toString()));
    });
  }


  void getSportsData() {
    emit(AppGetSportsLoadingState());
    DioHelper.getData(
      url: 'top-headlines',
      query: {
        'category': 'sports',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
        'language': 'en',
      },
    ).then((value) {
      if (value.data['status'] == 'ok' && value.data['articles'] != null) {
        sports = value.data['articles'];
        emit(AppGetSportsDataSuccessState());
      } else {
        emit(AppGetSportsDataErrorState('No sports articles found.'));
      }
    }).catchError((error) {
      emit(AppGetSportsDataErrorState(error.toString()));
    });
  }

  void getScienceData() {
    emit(AppGetScienceLoadingState());
    DioHelper.getData(
      url: 'top-headlines',
      query: {
        'category': 'science',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
        'language': 'en',
      },
    ).then((value) {
      if (value.data['status'] == 'ok' && value.data['articles'] != null) {
        science = value.data['articles'];
        emit(AppGetScienceDataSuccessState());
      } else {
        emit(AppGetScienceDataErrorState('No science articles found.'));
      }
    }).catchError((error) {
      emit(AppGetScienceDataErrorState(error.toString()));
    });
  }


  List search = [];

  void getSearchData(String value) {
    emit(AppGetSearchLoadingState());
    DioHelper.getData(
      url: 'everything',
      query: {
        'q': '$value',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value) {
      if (value.data['articles'] != null) {
        search = value.data['articles'];
        emit(AppGetSearchDataSuccessState());
      } else {
        emit(AppGetSearchDataErrorState('No articles found'));
      }
    }).catchError((error) {
      print(error.toString());
      emit(AppGetSearchDataErrorState(error.toString()));
    });
  }

  bool isDark = true;

  void changeAppTheme({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeThemeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolData(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeThemeModeState());
      });
    }
  }
}
