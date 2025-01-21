import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';


class SearchScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (BuildContext context, AppStates state) {  },
      builder: (BuildContext context, AppStates state) {
        var list = AppCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    textSelectionTheme: TextSelectionThemeData(
                      selectionColor: Colors.deepOrange,
                      selectionHandleColor:Colors.deepOrange,
                    ),
                  ),
                  child: TextFormField(
                    keyboardType:TextInputType.text,
                    cursorColor: Colors.deepOrange,
                    onChanged:(value){
                      AppCubit.get(context).getSearchData(value);
                    } ,
                    decoration: InputDecoration(
                        labelText: 'search',
                        labelStyle: TextStyle(
                          color: Colors.deepOrange,
                        ),
                        border:OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.deepOrange,
                          )
                        ),
                        prefixIcon:Icon(
                          Icons.search,
                        )
                    ),
                  ),
                ),
              ),
              Expanded(child: articleBuilder(list, context,isSearch: true)),
            ],
          ),
        );

      },
    );
  }
}
