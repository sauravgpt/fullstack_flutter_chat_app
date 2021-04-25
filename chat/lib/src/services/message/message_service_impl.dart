import 'dart:async';
import 'package:chat/src/services/encryption/encryption_contract.dart';

import '../../models/user.dart';
import '../../models/message.dart';
import './message_service_contract.dart';
import 'package:flutter/foundation.dart';
import 'package:rethinkdb_dart/rethinkdb_dart.dart';

class MessageService implements IMessageService {
  final Connection _connection;
  final Rethinkdb r;
  final IEncryption _encryption;
  final _controller = StreamController<Message>.broadcast();
  StreamSubscription _changefeed;

  MessageService(this.r, this._connection, this._encryption);

  @override
  dispose() async {
    await _controller?.close();
    _changefeed?.cancel();
  }

  @override
  Stream<Message> messages({User activeUser}) {
    _startReceivingMessages(activeUser);
    return _controller.stream;
  }

  @override
  Future<bool> send(Message message) async {
    var data = message.toJson();
    data['contents'] = _encryption.encrypt(message.contents);
    Map record = await r.table('messages').insert(data).run(_connection);

    return record['inserted'] == 1;
  }

  _startReceivingMessages(User activeUser) {
    _changefeed = r
        .table('messages')
        .filter({'to': activeUser.id})
        .changes({'include_initial': true})
        .run(_connection)
        .asStream()
        .cast<Feed>()
        .listen((event) {
          event
              .forEach((feedData) {
                if (feedData['new_val'] == null) return;

                final message = _messageFromFeed(feedData);
                _controller.sink.add(message);

                _removeDeliveredMessage(message);
              })
              .catchError((err) => {
                    debugPrint(err),
                  })
              .onError((error, stackTrace) => debugPrint(error));
        });
  }

  Message _messageFromFeed(feedData) {
    var data = feedData['new_val'];
    data['contents'] = _encryption.decrypt(data['contents']);
    return Message.fromJson(data);
  }

  _removeDeliveredMessage(Message message) {
    r
        .table('messages')
        .get(message.id)
        .delete({'return_changes': false}).run(_connection);
  }
}
