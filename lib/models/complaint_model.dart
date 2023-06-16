class ComplaintModel {
  String? busNumber;
  String? companyName;
  String? complainer;
  String? complaint;

  ComplaintModel(
      {this.busNumber, this.companyName, this.complainer, this.complaint});

  ComplaintModel.fromJson(Map<String, dynamic> json) {
    busNumber = json['busNumber'];
    companyName = json['companyName'];
    complainer = json['complainer'];
    complaint = json['complaint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['busNumber'] = this.busNumber;
    data['companyName'] = this.companyName;
    data['complainer'] = this.complainer;
    data['complaint'] = this.complaint;
    return data;
  }
}
