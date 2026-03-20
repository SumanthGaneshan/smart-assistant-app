enum MessageSender { user, assistant }

class Message  {
  final String id;
  final String text;
  final MessageSender sender;
  final DateTime createdAt;

  const Message({
    required this.id,
    required this.text,
    required this.sender,
    required this.createdAt,
  });
}