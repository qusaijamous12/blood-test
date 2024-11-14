class HistoryModel{
  final String ?email;
  final String ?firstName;
  final String ?lastName;
  final String ?lattiude;
  final String ?longtitude;
  final String ?phoneNumber;
  final String ?uid;
  final String ?gender;
  final String ?dateOfBirth;
  HistoryModel({
     this.uid,
     this.email,
     this.gender,
     this.phoneNumber,
     this.dateOfBirth,
     this.lastName,
     this.firstName,
     this.lattiude,
     this.longtitude
});
  factory HistoryModel.fromJson(Map<String,dynamic> json){
    return HistoryModel(
        uid: json['uid'],
        email: json['email'],
        gender: json['gender'],
        phoneNumber: json['phone_number'],
        dateOfBirth: json['date_of_birth'],
        lastName: json['last_name'],
        firstName: json['first_name'],
        lattiude: json['lattiude'],
        longtitude: json['longtitude']);
  }

}