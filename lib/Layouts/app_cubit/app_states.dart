import 'package:shop_app/Models/change_favorites_model.dart';

abstract class AppStates {}

class AppStatesInitialState extends AppStates {}

class BottomNavChangeState extends AppStates {}

class HomeDataLoadingState extends AppStates {}

class HomeDataSuccesState extends AppStates {}

class HomeDataErorrState extends AppStates {}

class HomeCategoriesSuccesState extends AppStates {}

class HomeCategoriesErorrState extends AppStates {}

class ChangeFavoritesSuccesState extends AppStates {
  ChangeFavoritesModel? model;

  ChangeFavoritesSuccesState(this.model);
}

class ChangeFavoritesErorrState extends AppStates {}

class ChangeButtonFavoriteState extends AppStates {}

class GetFavoritesLoadingState extends AppStates {}

class GetFavoritesSuccesState extends AppStates {}

class GetFavoritesErorrState extends AppStates {}

class UserDataLoadingState extends AppStates {}

class UserDataSuccesState extends AppStates {}

class UserDataErorrState extends AppStates {}

class UpdateUserDataLoadingState extends AppStates {}

class UpdateUserDataSuccesState extends AppStates {}

class UpdateUserDataErorrState extends AppStates {}
