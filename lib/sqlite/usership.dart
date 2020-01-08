class UserShip{
  String id,userId,shipId,level,damage,speed;
  UserShip({this.id,this.userId,this.shipId,this.level,this.damage,this.speed});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'userId': userId,
      'shipId': shipId,
      'level': level,
      'damage': damage,
      'speed': speed,
    };
    return map;
  }
  UserShip.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    userId = map['userId'];
    shipId = map['shipId'];
    level = map['level'];
    damage = map['damage'];
    speed = map['speed'];
  }
}