class Profile {
  String firstname;
  String lastname;

  Profile({required this.firstname, required this.lastname});

  factory Profile.fromJson(Map<String, dynamic> json){
    return Profile(firstname: json['firstname'], lastname: json['lastname']);
  }
}