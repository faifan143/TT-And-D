class BusModel {
  String? busType;
  String? seatsNumber;
  String? busNumber;
  bool? busy;
  String? passengers;

  BusModel(
      {this.busType,
      this.seatsNumber,
      this.busNumber,
      this.busy,
      this.passengers});

  BusModel.fromJson(Map<String, dynamic> json) {
    busType = json['busType'];
    seatsNumber = json['seatsNumber'];
    busNumber = json['busNumber'];
    busy = json['busy'];
    passengers = json['passengers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['busType'] = this.busType;
    data['seatsNumber'] = this.seatsNumber;
    data['busNumber'] = this.busNumber;
    data['busy'] = this.busy;
    data['passengers'] = this.passengers;
    return data;
  }
}
