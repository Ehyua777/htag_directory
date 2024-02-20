import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:htag_directory/models/hashtag_model.dart';
import 'package:htag_directory/repositories/hashtag_repository.dart';

part 'remove_hashtag_event.dart';
part 'remove_hashtag_state.dart';

class RemoveHashtagBloc extends Bloc<RemoveHashtagEvent, RemoveHashtagState> {
  final HashtagRepository hashtagRepository;

  RemoveHashtagBloc(
    this.hashtagRepository,
  ) : super(RemoveHashtagInitial()) {
    on<OnRemoveHashtagEvent>((event, emit) async {
      await hashtagRepository.removeHashtag(event.hashtagModel);

      emit(RemoveHashtagSuccessState(
        timestamp: DateTime.now().microsecondsSinceEpoch,
      ));
    });
  }
}
