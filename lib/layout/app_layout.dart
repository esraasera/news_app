import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/search/search_screen.dart';

class NewsLayoutScreen extends StatelessWidget {
  const NewsLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context, AppStates state) {  },
        builder: (BuildContext context, AppStates state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
            title:Text(
              'News App'
            ) ,
              actions: [
                IconButton(
                    icon:Icon(
                      Icons.search,
                    ),
                  onPressed:(){
               Navigator.push(
                   context,
                   MaterialPageRoute
                     (
                     builder: (context)=> SearchScreen(),
                   )
               );
                  },
                ),
                IconButton(
                  icon:Icon(
                    Icons.brightness_4_outlined,
                  ),
                  onPressed:(){
                   AppCubit.get(context).changeAppTheme();
                  },
                ),
              ],
            ),
            bottomNavigationBar:BottomNavigationBar(
                currentIndex:cubit.currentIndex ,
                onTap:(index){
                cubit.changeCurrentIndex(index);
                } ,
                items:cubit.bottomItems,
            ) ,
            body:cubit.screens[cubit.currentIndex] ,
          );

        },
      );
  }
}
