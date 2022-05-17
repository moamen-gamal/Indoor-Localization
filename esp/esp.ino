#include "ESP8266WiFi.h"
#include <ESP8266HTTPClient.h>
#define NAME ""
#define PASS ""
String NETWORKS []=["",""];
int RSSIs []=[];
int Nnum =9;

String pay;
String payload;  
int httpCode;
HTTPClient http;  //Declare an object of class HTTPClient
String URL ="http://192.168.1.2:5000/sendData?";

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  WiFi.mode(WIFI_STA);

  delay(100);
}

void loop() {
  // put your main code here, to run repeatedly:
  networkSearch();
  connectWifi();
  sendData();
}
void networkSearch(){
  WiFi.disconnect();
  int n = WiFi.scanNetworks();
  for(int i=0;i<Nnum;i++){
    bool found = false;
    for(int j =0; j<n; j++){
      if(WiFi.SSID(i) == NETWORKS[i]){
        RSSIs[i]=WiFi.RSSI(i);
      }
    }
    if(!found){
      RSSIs[i]=-100
    }
  }
}
void connectWifi(){
  WiFi.begin(NAME, PASS);
  //Serial.println("Connecting");
  while(WiFi.status() != WL_CONNECTED) {
    delay(50);
  }
}
void sendData(){
  WiFiClient wifi;
  for(int i =0;i<Nnum;i++){
  URL += String(i)+"="+String(RSSIs[i]);
  }
  http.begin(wifi,URL); //Specify request destination
  int httpCode = http.GET(); //Send the request
  if (httpCode > 0) { //Check the returning code
    String payload = http.getString();   //Get the request response payload
    Serial.println(payload);             //Print the response payload
  }else Serial.println("An error ocurred");
  http.end();   //Close connection 
}
