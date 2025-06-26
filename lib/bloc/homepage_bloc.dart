import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:society_gate/bloc/homepage_event.dart';
import 'package:society_gate/bloc/homepage_state.dart';
import 'package:society_gate/dashboard/notice_board/notice_api.dart';

import '../constents/local_storage.dart';
import '../models/announcements_model.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  HomepageBloc() : super(HomePageInitialState()) {
    on<GetHomePageDataEvent>(_getHomePageData);
  }

  void _getHomePageData(
      GetHomePageDataEvent event, Emitter<HomepageState> emit) async {
    try {
      final getLoginModel = LocalStoragePref().getLoginModel();
      Announcementmodel? mydata =
          await getAnnouncement(getLoginModel!.user!.societyId.toString());

      if (mydata!.status == 200) {
        emit(HomePageLoadedState(mydata: mydata));
      } else {
        emit(HomePageErrorState(msg: "Something went wrong"));
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
