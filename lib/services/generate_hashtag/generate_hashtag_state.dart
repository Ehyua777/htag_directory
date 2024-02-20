part of 'generate_hashtag_bloc.dart';

abstract class GenerateHashtagState extends Equatable {
  const GenerateHashtagState();

  @override
  List<Object> get props => [];
}

class GenerateHashtagInitialState extends GenerateHashtagState {
  final int number;

  const GenerateHashtagInitialState(this.number);

  @override
  List<Object> get props => [
        number,
      ];
}

class GenerateHashtagSuccessState extends GenerateHashtagState {
  final List<HashtagModel> hashtags;
  const GenerateHashtagSuccessState(
    this.hashtags,
  );

  @override
  List<Object> get props => [
        hashtags,
      ];
}
