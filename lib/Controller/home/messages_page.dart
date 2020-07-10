import 'package:OpenAndBuy/Controller/constants/colors.dart';
import 'package:OpenAndBuy/Model/localization/localizationConstants.dart';
import 'package:OpenAndBuy/Model/store.dart';
import 'package:OpenAndBuy/Model/user_detail.dart';
import 'package:OpenAndBuy/Service/message_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class MessagesPage extends StatelessWidget {
   StoreDetail storeDetail;
  UserDetail userDetail;
  MessagesPage({this.storeDetail, this.userDetail});
  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider.value(
      value: MessageNotifier(userID: userDetail.userID),
      child: MessagesPage2 (
        storeDetail: storeDetail,
        userDetail: userDetail,
      ),
    ); 
  }
}

class MessagesPage2 extends StatefulWidget {
 StoreDetail storeDetail;
  UserDetail userDetail;
  MessagesPage2({this.storeDetail, this.userDetail});
  @override
  _MessagesPage2State createState() => _MessagesPage2State();
}

class _MessagesPage2State extends State<MessagesPage2> {

  String value(String key) {
    return getTranslated(context, key);
  }
  @override
  Widget build(BuildContext context) {
    MessageNotifier messageNotifier = Provider.of<MessageNotifier>(context);
    messageNotifier.getMessages(widget.userDetail.userID);

    return Scaffold(
      appBar: AppBar(backgroundColor: APPBARCOLOR, title: Text(value('title'))),
      body: (messageNotifier.messages != null)
          ? (messageNotifier.messages.length != 0)
              ? messages(messageNotifier)
              : Center(child: Text(value('noMessages')))
          : Center(child: Text(value('noMessages'))),
    );
  }
   Widget messages(MessageNotifier messageNotifier) {
    return messageNotifier.messages != null
        ? ListView.builder(
            itemCount: messageNotifier.messages != null
                ? messageNotifier.messages.length
                : 0,
            itemBuilder: (context, i) {
              String img = messageNotifier.messages[i].body;
              String status = messageNotifier.messages[i].body;
              return ListTileTheme(
                selectedColor: Colors.blueAccent,
                child: ListTile(
                  selected: status == '' ? false : true,
                  onTap: () {
                    // Navigator.pop(context);
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => OrderPage(
                    //       index: i,
                    //     )));
                  },
                  title: RichText(
                    text: TextSpan(
                      text: messageNotifier.messages[i].body,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                            text: value('orderedOrder'),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal)),
                        TextSpan(
                          text: value('total') +
                              ' ${messageNotifier.messages[i].body} SKE ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                        TextSpan(
                          text: status,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: status == 'Accepted'
                                  ? Colors.green
                                  : Colors.red),
                        ),
                      ],
                    ),
                  ),
                  subtitle: Text(messageNotifier.messages[i].body.toString()),
                  leading: CircleAvatar(
                    backgroundColor: Colors.red,
                    backgroundImage: img != ''
                        ? NetworkImage(img)
                        : AssetImage('assets/profile_picture.png'),
                  ),
                ),
              );
            },
          )
        : Center(child: Text(value('noOrders')));
  }
}