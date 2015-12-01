#include <Wire.h>
#include <SoftwareSerial.h>
#include "Adafruit_TCS34725.h"

/* Example code for the Adafruit TCS34725 breakout library */

/* Connect SCL    to analog 5
   Connect SDA    to analog 4
   Connect VDD    to 3.3V DC
   Connect GROUND to common ground */
   
/* Initialise with default values (int time = 2.4ms, gain = 1x) */
// Adafruit_TCS34725 tcs = Adafruit_TCS34725();

/* Initialise with specific int time and gain values */
Adafruit_TCS34725 tcs = Adafruit_TCS34725(TCS34725_INTEGRATIONTIME_700MS, TCS34725_GAIN_1X);


SoftwareSerial lcd(3, 2); // SparkFun 2x16 serial LCD

void setup(void) {
  Serial.begin(9600);
  
  if (tcs.begin()) {
    Serial.println("Found sensor");
  } else {
    Serial.println("No TCS34725 found ... check your connections");
    while (1);
  }
  
  // Now we're ready to get readings!
  
  // Initialize SparkFun LCD
  lcd.begin(9600);
  delay(500);
  lcd.write(254);
  lcd.write(128);
  lcd.write("                ");
  lcd.write("                ");
  lcd.write(254);
  lcd.write(128);
  lcd.write(" All your base  ");
  lcd.write("are belong to us");
  
  pinMode(7, OUTPUT); // red LED
  pinMode(6, OUTPUT); // green LED
  pinMode(5, OUTPUT); // blue LED
}

void loop(void) {
  uint16_t r, g, b, c, colorTemp, lux;
  
  tcs.getRawData(&r, &g, &b, &c);
  colorTemp = tcs.calculateColorTemperature(r, g, b);
  lux = tcs.calculateLux(r, g, b);
  
  Serial.print("Color Temp: "); Serial.print(colorTemp, DEC); Serial.print(" K - ");
  Serial.print("Lux: "); Serial.print(lux, DEC); Serial.print(" - ");
  Serial.print("R: "); Serial.print(r, DEC); Serial.print(" ");
  Serial.print("G: "); Serial.print(g, DEC); Serial.print(" ");
  Serial.print("B: "); Serial.print(b, DEC); Serial.print(" ");
  Serial.print("C: "); Serial.print(c, DEC); Serial.print(" ");
  Serial.println(" ");
  
  digitalWrite(7, LOW);
  digitalWrite(6, LOW);
  digitalWrite(5, LOW);
  clearLCD();
  if (r > g && r > b) {
    digitalWrite(7, HIGH);
    lcd.write("red");
  } else if (g > r && g > b) {
    digitalWrite(6, HIGH);
    lcd.write("green");
  } else {
    digitalWrite(5, HIGH);
    lcd.write("blue");
  }
}

void clearLCD() {
  lcd.write(254);
  lcd.write(1);
  lcd.write(254);
  lcd.write(128);
}
