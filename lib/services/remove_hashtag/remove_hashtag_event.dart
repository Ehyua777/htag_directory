part of 'remove_hashtag_bloc.dart';

abstract class RemoveHashtagEvent extends Equatable {
  const RemoveHashtagEvent();

  @override
  List<Object> get props => [];
}

class OnRemoveHashtagEvent extends RemoveHashtagEvent {
  final HashtagModel hashtagModel;

  const OnRemoveHashtagEvent({
    required this.hashtagModel,
  });

  @override
  List<Object> get props => [
        hashtagModel,
      ];
}
