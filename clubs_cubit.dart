import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'clubs_state.dart';

class ClubsCubit extends Cubit<ClubsState> {
  ClubsCubit() : super(ClubsInitial());
}
