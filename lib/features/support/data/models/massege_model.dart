class MessageModel {
  final String senderId;
  final String receiverId;
  final String? text;

  MessageModel(
      {required this.senderId, required this.receiverId, required this.text});
}

List<MessageModel> dummyMessages = [
  MessageModel(senderId: "1", receiverId: "2", text: "الو ياباشا اجيلك ع فين"),
  MessageModel(senderId: "1", receiverId: "2", text: "??"),
  MessageModel(
      senderId: "2", receiverId: "1", text: "تعالي انا مستنيك ف العنوان"),
  MessageModel(
      senderId: "1", receiverId: "2", text: "تمام عشر دقايق و هكون عندك"),
  MessageModel(senderId: "2", receiverId: "1", text: "تمام بس ف الانجاز"),
  MessageModel(senderId: "1", receiverId: "2", text: "داخل عليك اهو"),
  MessageModel(senderId: "2", receiverId: "1", text: "تمام"),
  MessageModel(
      senderId: "1", receiverId: "2", text: "انا جيت ف العنوان انت فين"),
  MessageModel(senderId: "1", receiverId: "2", text: "ثانية واحدة"),
  MessageModel(senderId: "1", receiverId: "2", text: "الو ياباشا اجيلك ع فين"),
  MessageModel(senderId: "1", receiverId: "2", text: "??"),
  MessageModel(
      senderId: "2", receiverId: "1", text: "تعالي انا مستنيك ف العنوان"),
  MessageModel(
      senderId: "1", receiverId: "2", text: "تمام عشر دقايق و هكون عندك"),
  MessageModel(senderId: "2", receiverId: "1", text: "تمام بس ف الانجاز"),
  MessageModel(senderId: "1", receiverId: "2", text: "داخل عليك اهو"),
  MessageModel(senderId: "2", receiverId: "1", text: "تمام"),
  MessageModel(
      senderId: "1", receiverId: "2", text: "انا جيت ف العنوان انت فين"),
  MessageModel(senderId: "1", receiverId: "2", text: "ثانية واحدة"),
];
