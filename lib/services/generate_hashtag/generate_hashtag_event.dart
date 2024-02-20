part of 'generate_hashtag_bloc.dart';

abstract class GenerateHashtagEvent extends Equatable {
  const GenerateHashtagEvent();

  @override
  List<Object> get props => [];
}

class OnChangeNumberHastagEvent extends GenerateHashtagEvent {
  final int number;

  const OnChangeNumberHastagEvent(
    this.number,
  );

  @override
  List<Object> get props => [
        number,
      ];
}

class OnGenerateHashtagsEvent extends GenerateHashtagEvent {}
