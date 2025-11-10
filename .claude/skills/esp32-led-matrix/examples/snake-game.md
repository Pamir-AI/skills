# Snake Game Example

Simple snake game with food collection and wrapping edges.

## Features

- Snake grows when eating food
- Wraps around edges
- Auto-moves every 200ms
- Visual distinction between head (bright green) and body (dark green)

## src/main.cpp

```cpp
#include <FastLED.h>
#include <BoardConfig.h>
#include <MatrixUtil.h>

#define NUM_LEDS (MATRIX_WIDTH * MATRIX_HEIGHT)
CRGB leds[NUM_LEDS];

struct Point {
  int8_t x, y;
};

Point snake[64];
uint8_t snakeLen = 3;
Point food;
Point dir = {1, 0};
unsigned long lastMove = 0;

void setup() {
  Serial.begin(115200);
  unsigned long t0 = millis();
  while (!Serial && millis() - t0 < 1500) { delay(10); }
  if (Serial) MU_PrintMeta();

  MU_ADD_LEDS(LED_PIN, leds, NUM_LEDS);
  FastLED.setBrightness(BRIGHTNESS_LIMIT);

  // Initialize snake in center
  snake[0] = {MATRIX_WIDTH/2, MATRIX_HEIGHT/2};
  snake[1] = {MATRIX_WIDTH/2-1, MATRIX_HEIGHT/2};
  snake[2] = {MATRIX_WIDTH/2-2, MATRIX_HEIGHT/2};

  // Place food
  food = {random(MATRIX_WIDTH), random(MATRIX_HEIGHT)};
}

void loop() {
  // Move every 200ms
  if (millis() - lastMove > 200) {
    lastMove = millis();

    // Move snake
    for (int i=snakeLen-1; i>0; --i)
      snake[i] = snake[i-1];

    snake[0].x += dir.x;
    snake[0].y += dir.y;

    // Wrap around edges
    snake[0].x = (snake[0].x + MATRIX_WIDTH) % MATRIX_WIDTH;
    snake[0].y = (snake[0].y + MATRIX_HEIGHT) % MATRIX_HEIGHT;

    // Check if ate food
    if (snake[0].x == food.x && snake[0].y == food.y) {
      if (snakeLen < 64) snakeLen++;
      food = {random(MATRIX_WIDTH), random(MATRIX_HEIGHT)};
    }
  }

  // Draw
  FastLED.clear();

  // Draw snake
  for (uint8_t i=0; i<snakeLen; ++i) {
    if (snake[i].x >= 0 && snake[i].x < MATRIX_WIDTH &&
        snake[i].y >= 0 && snake[i].y < MATRIX_HEIGHT) {
      leds[MU_XY(snake[i].x, snake[i].y)] = i==0 ? CRGB::Green : CRGB(0,64,0);
    }
  }

  // Draw food
  if (food.x >= 0 && food.x < MATRIX_WIDTH &&
      food.y >= 0 && food.y < MATRIX_HEIGHT) {
    leds[MU_XY(food.x, food.y)] = CRGB::Red;
  }

  FastLED.show();
  if (Serial) MU_SendFrameCSV(leds);
  delay(50);
}
```

## Enhancements

- Add collision detection (snake hits itself)
- Add directional controls (buttons or serial input)
- Increase speed as snake grows
- Add obstacles/walls
- Score display
