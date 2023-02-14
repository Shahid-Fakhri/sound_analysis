class Patient {
  String id;
  String patientName;
  String email;
  String cnic;
  String age;
  String phone;
  String gender;
  Patient({
    this.id,
    this.patientName,
    this.email,
    this.cnic,
    this.age,
    this.gender,
    this.phone,
  });

  Patient.fromMapObject(Map<String, dynamic> map) {
    id = map['id'];
    patientName = map['name'];
    email = map['email'];
    cnic = map['cnic'];
    phone = map['phone'];
    age = map['age'];
    gender = map['gender'];
  }
}
