class BookModel {
  bool? accepted;
  String? busNumber;
  String? destination;
  String? email;
  String? goTime;
  String? phone;
  String? price;
  String? source;
  String? tripNumber;
  String? id;
  String? tripId;
  int? seatNo;
  BookModel(
      {this.accepted,
      this.busNumber,
      this.destination,
      this.email,
      this.goTime,
      this.id,
      this.seatNo,
      this.tripId,
      this.phone,
      this.price,
      this.source,
      this.tripNumber});

  BookModel.fromJson(Map<String, dynamic> json) {
    accepted = json['accepted'];
    busNumber = json['busNumber'];
    destination = json['destination'];
    email = json['email'];
    goTime = json['goTime'];
    phone = json['phone'];
    price = json['price'];
    id = json['id'];
    source = json['source'];
    seatNo = json['seatNo'];
    tripNumber = json['tripNumber'];
    tripId = json['tripId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['accepted'] = this.accepted;
    data['busNumber'] = this.busNumber;
    data['destination'] = this.destination;
    data['email'] = this.email;
    data['goTime'] = this.goTime;
    data['phone'] = this.phone;
    data['tripId'] = this.tripId;
    data['price'] = this.price;
    data['id'] = this.id;
    data['source'] = this.source;
    data['seatNo'] = this.seatNo;
    data['tripNumber'] = this.tripNumber;
    return data;
  }
}
