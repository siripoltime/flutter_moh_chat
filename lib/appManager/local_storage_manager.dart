import 'package:localstorage/localstorage.dart';
import 'package:mohpromt_chat/api/model/chatdata_model.dart';

class LocalStorageManager {
  static final LocalStorage storage = LocalStorage('MyApp');

  static const String CHATDATA = 'CHATDATA';

  static saveChatData(dynamic value) async {
    await storage.ready;
    print('saveChatData');
    return storage.setItem(CHATDATA, value);
  }

  static Future<ChatDataModel> getChatData() async {
    await storage.ready;
    var chatData = storage.getItem(CHATDATA);
    if (chatData == null) {
      var response = ChatDataModel();
      return response;
    }
    Map<String, dynamic> storageData = Map<String, dynamic>.from(chatData);
    print(chatData);
    var response = ChatDataModel.fromJson(storageData);

    return response;
  }
}
