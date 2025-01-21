abstract class AppStates{ }

 class AppInitialState extends AppStates{ }

class AppChangeBottomNavBarState extends AppStates{ }


class AppGetBusinessLoadingState extends AppStates{ }


class AppGetDataLoadingState extends AppStates{ }
class AppGetBusinessDataSuccessState extends AppStates{ }
class AppGetBusinessDataErrorState extends AppStates{
 final String error;
 AppGetBusinessDataErrorState(this.error);
}

class AppGetSportsLoadingState extends AppStates{ }
class AppGetSportsDataSuccessState extends AppStates{ }
class AppGetSportsDataErrorState extends AppStates{

 final String error;
 AppGetSportsDataErrorState(this.error);
}

class AppGetScienceLoadingState extends AppStates{ }
class AppGetScienceDataSuccessState extends AppStates{ }
class AppGetScienceDataErrorState extends AppStates{

 final String error;
 AppGetScienceDataErrorState(this.error);
}


class AppGetSearchLoadingState extends AppStates{ }
class AppGetSearchDataSuccessState extends AppStates{ }
class AppGetSearchDataErrorState extends AppStates{

 final String error;
 AppGetSearchDataErrorState(this.error);
}

class AppChangeThemeModeState extends AppStates{ }
