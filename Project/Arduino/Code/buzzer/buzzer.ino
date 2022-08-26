#define BUZZER_PIN 13
#define N_BIPES 4

#define DO 261
#define RE 293
#define MI 329
#define FA 349
#define SOL 392
#define LA 440
#define SI 493

int buzzerPin = BUZZER_PIN;

void acionaBuzzer(int freq, int n, int intervalo)
{
  for(int i = 0; i < N_BIPES; i++)
  {
    tone(buzzerPin, freq);
    delay(100);
    noTone(buzzerPin);
    delay(100);
  }
  delay(intervalo);
}

void setup() {
  pinMode(buzzerPin, OUTPUT);
  
}

void loop() {
  acionaBuzzer(RE, 4, 5000);

}
