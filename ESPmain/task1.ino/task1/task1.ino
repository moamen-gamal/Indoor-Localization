  
#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#define WIFI_SSID "STUDBME2"
#define WIFI_PASS "BME2Stud"

void setup () {
  WiFi.begin(WIFI_SSID, WIFI_PASS); 
  while (WiFi.status() != WL_CONNECTED) {
    delay(20);
  }
  Serial.begin(9600);
}
 
void loop() {
  if (WiFi.status() == WL_CONNECTED) { //Check WiFi connection status
    HTTPClient http;  //Declare an object of class HTTPClient  url?1=70&2=45
    WiFiClient wifi;
    String URL ="http://172.28.131.70:5000/automatic";
    
    http.begin(wifi,URL); //Specify request destination
    int httpCode = http.GET(); //Send the request
    if (httpCode > 0) { //Check the returning code
      String payload = http.getString();   //Get the request response payload
      Serial.println(payload);             //Print the response payload
    }else Serial.println("HTTP Failed");
 
    http.end();   //Close connection
 
  }   
}
