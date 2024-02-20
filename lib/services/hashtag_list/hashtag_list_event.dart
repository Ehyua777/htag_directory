part of 'hashtag_list_bloc.dart';

abstract class HashtagListEvent extends Equatable {
  const HashtagListEvent();

  @override
  List<Object> get props => [];
}

class OnInitializeHashtagListEvent extends HashtagListEvent {}

class _OnHashtagUpdatedListHashtagEvent extends HashtagListEvent {
  final List<HashtagModel> hashtags;
  const _OnHashtagUpdatedListHashtagEvent({
    required this.hashtags,
  });

  @override
  List<Object> get props => [
        hashtags,
      ];
}
