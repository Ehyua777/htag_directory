import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:htag_directory/models/hashtag_model.dart';
import 'package:htag_directory/repositories/hashtag_repository.dart';

part 'hashtag_list_event.dart';
part 'hashtag_list_state.dart';

class HashtagListBloc extends Bloc<HashtagListEvent, HashtagListState> {
  final HashtagRepository hashtagRepository;

  HashtagListBloc(
    this.hashtagRepository,
  ) : super(
          HashtagListInitialState(
            hashtagList: List<HashtagModel>.from([]),
          ),
        ) {
    hashtagRepository.hashtags.listen((hashtags) {
      add(_OnHashtagUpdatedListHashtagEvent(hashtags: hashtags));
    });

    on<_OnHashtagUpdatedListHashtagEvent>(
      (event, emit) async {
        await hashtagRepository.initialize();

        emit(
          const HashtagListInitialState(
            hashtagList: [],
          ),
        );
      },
    );

    on<_OnHashtagUpdatedListHashtagEvent>((event, emit) {
      emit(
        HashtagListInitialState(
          hashtagList: event.hashtags,
        ),
      );
    });
  }
}
