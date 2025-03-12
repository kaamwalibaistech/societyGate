import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_society/dashboard/members/network/memberslist_api.dart';
import 'package:my_society/models/memberlist_model.dart';

part 'members_event.dart';
part 'members_state.dart';

class MembersBloc extends Bloc<MembersEvent, MembersState> {
  MemberlistModel? _memberlistModel;

  MembersBloc() : super(MembersInitialState()) {
    on<GetMemberListEvent>(_getList);
  }

  void _getList(GetMemberListEvent event, Emitter<MembersState> emit) async {
    // emit(MembersInitialState());

    try {
      final memberData = await memberListApi(event.soceityId);
      _memberlistModel = memberData;
      if (_memberlistModel!.status == 200) {
        emit(MembersSuccessState(memberlistModel: _memberlistModel));
      } else {
        emit(MembersErrorState(_memberlistModel!.message.toString()));
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
