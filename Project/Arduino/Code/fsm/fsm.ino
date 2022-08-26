#define BUTTON_PIN 2

const int button_pin = BUTTON_PIN;
const int max_count = 5;
const int max_timeout = 5;

enum fsmState_t
{
  MEDINDO = 0,
  ALARME = 1,
  CONFIRMA = 2,
  CONF_1 = 3,
  CONF_2 = 4
};

fsmState_t state;
volatile int button = 0;
volatile int button_aux = 0;
volatile int count = 0;
volatile int timeout = 0;
volatile int vol = 0;
volatile int volAlvo = 1000;

void setup() {
  pinMode(button_pin, INPUT);
  Serial.begin(115200);
  state = MEDINDO;
  Serial.println("MEDINDO");

  attachInterrupt(digitalPinToInterrupt(button_pin), handleButton, RISING);
}

void handleButton()
{
  Serial.println("handleButton");
  button = 1;
}

void updateFsm()
{
  switch(state)
  {
    case MEDINDO:
      if(button == 1)
      {
        state = CONFIRMA;
        Serial.println("CONFIRMA");
      }
      else if(vol == volAlvo)
      {
        state = ALARME;
        Serial.println("ALARME");
      }
      else
      {
        // medindo o volume que passa pelo sensor
      }
      break;
    case ALARME:
      // setAlarm();
      if(button == 1)
      {
        // clearAlarm();
        state = MEDINDO;
        Serial.println("MEDINDO");
      }
      break;
    case CONFIRMA:
      if(button == 1)
      {
        timeout = 0;
        state = CONF_1;
        Serial.println("CONF_1");
      }
      else if (timeout == max_timeout)
      {
        timeout = 0;
        state = MEDINDO;
        Serial.println("MEDINDO");
      }
      timeout++;
      break;
    case CONF_1:
      if(button == 1)
      {
        volAlvo += 1000;
        if(volAlvo == 5000)
        {
          state = CONF_2;
          Serial.println("CONF_2");
        }
      }
      if(button == 1)
      {
        vol = 0;
        state = MEDINDO;
        Serial.println("MEDINDO");
      }
      break;
    case CONF_2:
      if(button == 1)
      {
        volAlvo = 1000;
      }
      break;
      if(button == 1)
      {
        vol = 0;
        state = MEDINDO;
        Serial.println("MEDINDO");
      }
  }
}

void loop() {
  updateFsm();
  delay(1);
}
