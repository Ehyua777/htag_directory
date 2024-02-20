import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:htag_directory/main.dart';
import 'package:htag_directory/models/hashtag_model.dart';
import 'package:htag_directory/repositories/hashtag_repository.dart';

part 'generate_hashtag_event.dart';
part 'generate_hashtag_state.dart';

class GenerateHashtagBloc
    extends Bloc<GenerateHashtagEvent, GenerateHashtagState> {
  final HashtagRepository hashtagRepository;

  GenerateHashtagBloc(this.hashtagRepository)
      : super(const GenerateHashtagInitialState(0)) {
    on<OnChangeNumberHastagEvent>((event, emit) {
      hashtagRepository.number = event.number;
      emit(GenerateHashtagInitialState(event.number));
    });

    on<GenerateHashtagEvent>(
      (event, emit) async {
        List<HashtagModel> hashtagModel = await hashtagRepository.generate();

        emit(GenerateHashtagSuccessState(hashtagModel));
      },
    );
  }
}
