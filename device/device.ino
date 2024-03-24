#include <ArduinoJson.h>
#include <ESP8266WiFi.h>
#include <FirebaseArduino.h>
#include <Servo.h>

#define WIFI_SSID ""
#define WIFI_PASSWORD ""
#define FIREBASE_HOST "parking-express-27f82-default-rtdb.firebaseio.com"
#define FIREBASE_AUTH "HC7h3CH0BLOS44zokVdN5xsZZKsuQfo8vLtwr4AK"

Servo servo;
int pos = 0;

void setup() {
  Serial.begin(9600);
  servo.attach(D7);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    delay(300);
  }
  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();

  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
}

void loop() {
  delay(1000);
  bool sta = Firebase.getBool("/parkings/-NtWu3CCWVF4ne8J69uK/door");
  Serial.print("Door Status: ");
  Serial.println(sta);

  if (sta) {
    for (pos = 0; pos <= 180; pos += 1) {
      servo.write(pos);
      delay(10);
    }
    delay(2000);
    for (pos = 180; pos >= 0; pos -= 1) {
      servo.write(pos);
      delay(10);
    }
    Firebase.setBool("/parkings/-NtWu3CCWVF4ne8J69uK/door", false);
  }

}
