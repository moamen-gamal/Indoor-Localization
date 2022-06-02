#include "ESP8266WiFi.h"
#include <ESP8266HTTPClient.h>
#define NAME "STUDBME2"
#define PASS "BME2Stud"
int AvailableNetworks;
void connectWifi();
void sendDatas();
String routers_ssid[11] = { "MO",
                            "medhat",
                            "El-lab",
                            "RehabLab",
                            "Elmodarag",
                            "STUDBME1",
                            "STUDBME2",
                            "WE_99ECD6",
                            "noran",
                            "mawlana",
                            "Redmi7788"
                          };
int RSSIs[11] = { -100, -100, -100, -100, -100, -100, -100, -100, -100 , -100 , -100};

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
  sendDatas();
}
void networkSearch(){
  WiFi.disconnect();
  int n = WiFi.scanNetworks();
  AvailableNetworks = WiFi.scanNetworks();
  for (int j = 0; j < 11; j++)
  {
    for (int i = 0; i < AvailableNetworks; i++)
    {
      if (routers_ssid[j] == WiFi.SSID(i))
      {
        RSSIs[j] = WiFi.RSSI(i);
      }
    }
    Serial.print(RSSIs[j]);
    Serial.print(',');
  }

  Serial.println("");
  delay(500);
}

void connectWifi(){
 WiFi.begin(NAME, PASS);
 //Serial.println("Connecting");
 while(WiFi.status() != WL_CONNECTED) {
   delay(50);
 }
}
void sendDatas(){
 WiFiClient wifi;
 for(int i =0;i<11;i++){
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
