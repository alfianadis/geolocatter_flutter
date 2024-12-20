class FormData {
  int? id;
  String nik;
  String name;
  String phone;
  String gender;
  String date;
  String address;
  String imagePath;

  FormData({
    this.id,
    required this.nik,
    required this.name,
    required this.phone,
    required this.gender,
    required this.date,
    required this.address,
    required this.imagePath,
  });

  factory FormData.fromMap(Map<String, dynamic> json) => FormData(
        id: json['id'],
        nik: json['nik'],
        name: json['name'],
        phone: json['phone'],
        gender: json['gender'],
        date: json['date'],
        address: json['address'],
        imagePath: json['imagePath'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nik': nik,
      'name': name,
      'phone': phone,
      'gender': gender,
      'date': date,
      'address': address,
      'imagePath': imagePath,
    };
  }
}
