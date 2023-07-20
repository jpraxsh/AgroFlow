#include <Arduino.h>
#include <DHT.h>
#include <WiFi.h>
#include <HTTPClient.h>
#include<ArduinoJson.h>


const int DHT_PIN = 4;
const int MOisture_Sensor = 34;
const int motor = 26;
DHT dhtSensor(DHT_PIN,DHT22);
bool motor_status = false;


void motorControl(bool status){
  if(motor_status == status) return;
  if(status){
    Serial.println("Motor : High");
     digitalWrite(motor,HIGH);
  }
   
  else{
    Serial.println("Motor : Low");
    digitalWrite(motor,LOW);
  } 
    
  motor_status = status;
  delay(500);
  return;

}


void setupWifi(){
  const char* ssid = "jplaptop";
  const char* pass = "1234567890";
  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid,pass);
  
  Serial.print("Connecting to WiFi");
  while (WiFi.status() != WL_CONNECTED) {
    delay(100);
    Serial.print(".");
  }
  Serial.println(" Connected!");
  return ;
}
bool send_data(float temp,float humidity,int moisture){
  String path = "http://192.168.109.93:2003/send?temp="+String(temp,2)+"&hum="+String(humidity,1)+"&mois="+String(moisture);
  HTTPClient client;  
  client.begin(path);
  int httpCode = client.GET();
  if (httpCode > 0){
    String payload = client.getString();

    // Parse JSON directly from payload
    DynamicJsonDocument doc(500);
    DeserializationError error = deserializeJson(doc, payload);

    if (error) {
      Serial.println("Error parsing JSON");
      return false;
    }

    String status = doc["motor"].as<String>();
    motorControl(status == "true");
    
    
  }else{
    Serial.print("Error in http");
  }
  return true;
}
void setup() {
  Serial.begin(921600);
  setupWifi();
  dhtSensor.begin();
  digitalWrite(motor,LOW);
  pinMode(motor, OUTPUT);
  
}

void loop() { 
  float temp = dhtSensor.readTemperature();
  float humidity = dhtSensor.readHumidity();
  int moisture_value = analogRead(MOisture_Sensor);
  Serial.println("Temp: " + String(temp, 2) + "°C");
  Serial.println("Humidity: " + String(humidity, 1) + "%");
  Serial.print("Moisture value: ");
  Serial.println(moisture_value);
  Serial.println("---");
  send_data(temp,humidity,moisture_value);
  delay(1000);
}