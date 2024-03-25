class Medicine {
  String? drugName;
  List<String>? alternativeBrands;
  List<String>? company;

  Medicine({this.drugName, this.alternativeBrands, this.company});

  Medicine.fromJson(Map<String, dynamic> json) {
    drugName = json['Drug_Name'];
    alternativeBrands = json['Alternative_Brands'].cast<String>();
    company = json['Company'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Drug_Name'] = this.drugName;
    data['Alternative_Brands'] = this.alternativeBrands;
    data['Company'] = this.company;
    return data;
  }
}
