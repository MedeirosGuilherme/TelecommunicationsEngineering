

// Constantes não modificáveis para dispor a pinagem
const int ledPin = 13;     // Número do pin do Led
const int buttonPin = 2;  // Número do pin do botão

int buttonState = LOW; // Variável para ler o estado do botão

void setup() {
  pinMode(ledPin, OUTPUT);    // Iniciando o pin do Led como output
  pinMode(buttonPin, INPUT);  // Iniciando o pin do Botão como INPUT
}

void loop() {
  
  //leio o estado do botão.
  buttonState = digitalRead(buttonPin);
  
  if (buttonState == HIGH){
    digitalWrite(ledPin, HIGH);
    Serial.println("apertou");
  } else{
    digitalWrite(ledPin, LOW);
  }
    
}
