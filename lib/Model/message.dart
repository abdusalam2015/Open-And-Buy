class Message {
  String senderName;
  String senderID;
  String recieverName;
  String recieverID;
  String body;
  String date;
  Message(
      {this.body,
      this.senderID,
      this.senderName,
      this.recieverID,
      this.recieverName,
      this.date});
}
