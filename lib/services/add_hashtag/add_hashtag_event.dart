part of 'add_hashtag_bloc.dart';

abstract class AddHashtagEvent extends Equatable {
  const AddHashtagEvent();

  @override
  List<Object> get props => [];
}

class OnAddHashtagEvent extends AddHashtagEvent {
  final String hashtag;

  const OnAddHashtagEvent({
    required this.hashtag,
  });
}
