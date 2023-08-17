import '../core/base.dart';
import 'note.dart';
import '../core/client.dart';

class Poll extends Base {
  Poll(Client client, this.note, Map<String, dynamic> map)
  : expiresAt = map['expiresAt'] == null ? null : DateTime.parse(map['expiresAt'] as String),
    multiple = map['multiple'] as bool,
    super(client)
  {
    var i = 0;
    choices = (map['choices'] as List<dynamic>).map(
        (e) => PollChoice(this, i++, e as Map<String, dynamic>)
    ).toList();
  }
  
  /// The note that this poll belongs to.
  final Note note;

  /// The choices of the poll.
  late final List<PollChoice> choices;

  /// The expiration time of the poll.
  final DateTime? expiresAt;

  /// Whether the poll allows multiple votes.
  final bool multiple;

  /// Vote for a choice in the poll.
  Future<void> vote(int choice) async {
    final c = choices[choice];
    if (c.isVoted) return;
    
    await client.api.post('notes/polls/vote', body: {
      'noteId': note.id,
      'choice': choice
    });
  }

  /// Get the voted choices.
  Iterable<PollChoice> get votedChoices => choices.where((e) => e.isVoted);
}

class PollChoice {
  PollChoice(this.poll, this.index, Map<String, dynamic> map)
  : text = map['text'] as String,
    votes = map['votes'] as int,
    isVoted = map['isVoted'] as bool;

  /// The poll that this choice belongs to.
  final Poll poll;

  /// The index of the choice.
  final int index;

  /// The text of the choice.
  final String text;

  /// The vote count of the choice.
  final int votes;

  /// Whether the client user voted for this choice.
  final bool isVoted;

  void vote() => poll.vote(index);
}