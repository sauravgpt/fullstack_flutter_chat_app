import 'package:chat/chat.dart';
import 'package:flutter/foundation.dart';

class LocalMessage {
  String get id => _id;
  String chatId;
  String _id;
  Message message;
  ReceiptStatus receipt;

  LocalMessage({
    @required this.chatId,
    @required this.message,
    @required this.receipt,
  });

  Map<String, dynamic> toMap() => {
        'chat_id': this.chatId,
        'id': this.message.id,
        ...message.toJson(),
        'receipt': this.receipt.value(),
      };

  factory LocalMessage.fromMap(Map<String, dynamic> json) {
    final message = Message(
      from: json['from'],
      to: json['to'],
      contents: json['contents'],
      timestamp: json['timestamp'],
    );

    final localMessage = LocalMessage(
      chatId: json['chat_id'],
      message: message,
      receipt: EnumParsing.fromString(json['receipt']),
    );

    localMessage._id = json['id'];

    return localMessage;
  }
}
