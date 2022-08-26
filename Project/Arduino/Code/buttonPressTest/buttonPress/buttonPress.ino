#define led_pin 12
#define buttonPin 8

// Variávies do temporizador do botão
int startPressed = 0;
int endPressed = 0;
int holdTime = 0;
int idleTime = 0;
int buttonState = 0;
int lastButtonState = 0;
int led = 0;

// Variáveis do sistema:
float vol = 0;
int i = 0;

void setup() {
  pinMode(led_pin, OUTPUT);
  pinMode(buttonPin, INPUT);
  Serial.begin(9600);
}

void loop() {
  buttonState = digitalRead(buttonPin);
  
  if(i == 0){
    vol = 50.00;
    Serial.print("Volume inicial:" );
    Serial.println(vol);
    i = 1;
  }

  if(buttonState != lastButtonState) {
    if(digitalRead(buttonPin) == HIGH){
      Serial.println("Botão apertado!");
    } else{
      Serial.println("Botão solto!\n");
    }
    updateState();
  }
  
  lastButtonState = buttonState;
}

// Temporizador de botões e estados da MEF:
void updateState() {
  if (buttonState == HIGH){
    startPressed = millis();
    idleTime = startPressed - endPressed;
    
  } else {
    endPressed = millis();
    holdTime = endPressed - startPressed;

    if (holdTime >=2000 && holdTime < 5000){
      Serial.println("Botão foi apertado por 2 segundos");
      digitalWrite(led_pin, HIGH);
      Serial.println("Led aceso!\n");
    } 

    if (holdTime >= 30000){
      Serial.println("Botão foi apertado por 30 segundos");
      Serial.println("Volume medido zerado.");
      vol = 0;
      Serial.println(vol);
    }
  }
} 
