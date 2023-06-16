class TripModel {
  String? driverNumber;
  String? goTime;
  String? price;
  String? destination;
  bool? finished;
  bool? started;
  String? source;
  String? tripNumber;
  String? busNumber;
  String? id;
  String? busType;
  String? seatsNumber;
  String? companyName;
  String? locationData;
  List<dynamic>? passengers;
  List<dynamic>? bookedSeats;

  TripModel(
      {this.driverNumber,
      this.goTime,
      this.price,
      this.destination,
      this.finished,
      this.started,
      this.source,
      this.tripNumber,
      this.seatsNumber,
      this.busType,
      this.locationData,
      this.passengers,
      this.companyName,
      this.bookedSeats,
      this.id,
      this.busNumber});

  TripModel.fromJson(Map<String, dynamic> json) {
    driverNumber = json['driverNumber'];
    goTime = json['goTime'];
    price = json['price'];
    destination = json['destination'];
    finished = json['finished'];
    started = json['started'];
    source = json['source'];
    tripNumber = json['tripNumber'];
    busNumber = json['busNumber'];
    busType = json['busType'];
    passengers = json['passengers'];
    bookedSeats = json['bookedSeats'];
    id = json['id'];
    seatsNumber = json['seatsNumber'];
    companyName = json['companyName'];
    locationData = json['locationData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['driverNumber'] = this.driverNumber;
    data['goTime'] = this.goTime;
    data['price'] = this.price;
    data['destination'] = this.destination;
    data['finished'] = this.finished;
    data['companyName'] = this.companyName;
    data['started'] = this.started;
    data['source'] = this.source;
    data['tripNumber'] = this.tripNumber;
    data['busNumber'] = this.busNumber;
    data['busType'] = this.busType;
    data['seatsNumber'] = this.seatsNumber;
    data['passengers'] = this.passengers;
    data['bookedSeats'] = this.bookedSeats;
    data['id'] = this.id;
    data['locationData'] = this.locationData;

    return data;
  }
}
