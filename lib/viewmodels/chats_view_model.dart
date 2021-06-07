import 'package:chat/chat.dart';
import 'package:fullstack_chat_app/data/datasources/datasource_contract.dart';
import 'package:fullstack_chat_app/models/chat.dart';
import 'package:fullstack_chat_app/models/local_message.dart';
import 'package:fullstack_chat_app/viewmodels/base_view_model.dart';

class ChatsViewModel extends BaseViewModel {
  IDatasource _datasource;

  ChatsViewModel(this._datasource) : super(_datasource);

  Future<List<Chat>> getChats() async => await _datasource.findAllChats();

  Future<void> receivedMessage(Message message) async {
    LocalMessage localMessage =
        LocalMessage(message.from, message, ReceiptStatus.deliverred);
    await addMessage(localMessage);
  }
}
