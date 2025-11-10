# Bouncing Ball Example

Physics-based bouncing ball with motion trails.

## Features

- Smooth sub-pixel motion using floats
- Bounces off edges
- Fade trail effect
- Adjustable velocity

## src/main.cpp

```cpp
#include <FastLED.h>
#include <BoardConfig.h>
#include <MatrixUtil.h>

#define NUM_LEDS (MATRIX_WIDTH * MATRIX_HEIGHT)
CRGB leds[NUM_LEDS];

float ballX = MATRIX_WIDTH / 2.0;
float ballY = MATRIX_HEIGHT / 2.0;
float velX = 0.15;
float velY = 0.10;

void setup() {
  Serial.begin(115200);
  unsigned long t0 = millis();
  while (!Serial && millis() - t0 < 1500) { delay(10); }
  if (Serial) MU_PrintMeta();

  MU_ADD_LEDS(LED_PIN, leds, NUM_LEDS);
  FastLED.setBrightness(BRIGHTNESS_LIMIT);
}

void loop() {
  // Update position
  ballX += velX;
  ballY += velY;

  // Bounce off edges
  if (ballX <= 0 || ballX >= MATRIX_WIDTH-1) velX = -velX;
  if (ballY <= 0 || ballY >= MATRIX_HEIGHT-1) velY = -velY;

  // Keep in bounds
  ballX = constrain(ballX, 0, MATRIX_WIDTH-1);
  ballY = constrain(ballY, 0, MATRIX_HEIGHT-1);

  // Draw
  FastLED.clear();

  // Draw trail (fade previous frame)
  for (uint16_t i=0; i<NUM_LEDS; ++i)
    leds[i].fadeToBlackBy(32);

  // Draw ball
  int8_t x = (int8_t)ballX;
  int8_t y = (int8_t)ballY;
  if (x >= 0 && x < MATRIX_WIDTH && y >= 0 && y < MATRIX_HEIGHT)
    leds[MU_XY(x, y)] = CRGB::Cyan;

  FastLED.show();
  if (Serial) MU_SendFrameCSV(leds);
  delay(50);
}
```

## Enhancements

- Add gravity (increase velY over time)
- Multiple balls
- Color changes on bounce
- Energy loss on bounce (multiply velocity by 0.9)
- Add paddle for Pong-style game
