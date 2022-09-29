import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Models/search_model.dart';
import 'package:shop_app/Modules/search_screen/search_states.dart';
import 'package:shop_app/Shared/Component/constatnt.dart';
import 'package:shop_app/Shared/Network/Local/cache_helper.dart';
import 'package:shop_app/Shared/Network/Remote/dio_helper.dart';
import 'package:shop_app/Shared/Network/Remote/end_points.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());
  SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? searchModel;
  search({required text}) {
    emit(SearchLoadinglState());
    DioHelper.postData(
            url: getSearch,
            data: {"text": text},
            token: CacheHelper.getData(key: "token"))
        .then((value) {
      searchModel = SearchModel.fromJson(value.data);
      print(value.data);
      emit(SearchSuccesslState());
    }).catchError((error) {
      emit(SearchErrorlState());
      print(error.toString());
    });
  }
}
