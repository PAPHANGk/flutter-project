// ignore: file_names
class Transactions {
  late int? id;
  String title;
  String title2;
  String title3;
  int amount;
  String date;

  Transactions(
      {this.id,
      required this.title,
      required this.title2,
      required this.title3,
      required this.amount,
      required this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'title2': title2,
      'title3': title3,
      'amount': amount,
      'date': date
    };
  }
}
