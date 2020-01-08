class UserData{
  String username,password,id,hiLevel,hiScore,coins;
  UserData({this.id,this.username,this.password,this.hiLevel,this.hiScore,this.coins});

   Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'username': username,
      'password': password,
      'hiLevel': hiLevel,
      'hiScore': hiScore,
      'coins': coins,
    };
    return map;
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return new UserData(
      id : map['id'],
      username : map['username'],
      password : map['password'],
      hiLevel : map['hiLevel'],
      hiScore : map['hiScore'],
      coins : map['coins'],
    );
  }
}