class DataModel{
  String temp;
  String hum;
  String con;
  String mois;

  DataModel.fromJson(Map<String,dynamic> json)
    : temp = json['temp'],
      hum = json['hum'],
      con = json['con'],
      mois = json['mois'];


  Map<String,dynamic> toJson()=>{
    'temp':temp,
    'hum':hum,
    'con':con,
    'mois':mois
  };

}