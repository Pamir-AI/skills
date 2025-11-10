# Rainbow Effects Examples

Various rainbow and color gradient effects.

## Horizontal Rainbow Gradient

```cpp
#include <FastLED.h>
#include <BoardConfig.h>
#include <MatrixUtil.h>

#define NUM_LEDS (MATRIX_WIDTH * MATRIX_HEIGHT)
CRGB leds[NUM_LEDS];

void setup() {
  Serial.begin(115200);
  unsigned long t0 = millis();
  while (!Serial && millis() - t0 < 1500) { delay(10); }
  if (Serial) MU_PrintMeta();

  MU_ADD_LEDS(LED_PIN, leds, NUM_LEDS);
  FastLED.setBrightness(BRIGHTNESS_LIMIT);
}

void loop() {
  uint8_t timeOffset = millis() / 20;

  for (uint8_t y=0; y<MATRIX_HEIGHT; ++y) {
    for (uint8_t x=0; x<MATRIX_WIDTH; ++x) {
      uint8_t hue = x * (256 / MATRIX_WIDTH) + timeOffset;
      leds[MU_XY(x, y)] = CHSV(hue, 255, 255);
    }
  }

  FastLED.show();
  if (Serial) MU_SendFrameCSV(leds);
  delay(50);
}
```

## Vertical Rainbow Gradient

```cpp
void loop() {
  uint8_t timeOffset = millis() / 20;

  for (uint8_t y=0; y<MATRIX_HEIGHT; ++y) {
    uint8_t hue = y * (256 / MATRIX_HEIGHT) + timeOffset;
    for (uint8_t x=0; x<MATRIX_WIDTH; ++x) {
      leds[MU_XY(x, y)] = CHSV(hue, 255, 255);
    }
  }

  FastLED.show();
  if (Serial) MU_SendFrameCSV(leds);
  delay(50);
}
```

## Diagonal Rainbow

```cpp
void loop() {
  uint8_t timeOffset = millis() / 20;

  for (uint8_t y=0; y<MATRIX_HEIGHT; ++y) {
    for (uint8_t x=0; x<MATRIX_WIDTH; ++x) {
      uint8_t hue = (x + y) * 16 + timeOffset;
      leds[MU_XY(x, y)] = CHSV(hue, 255, 255);
    }
  }

  FastLED.show();
  if (Serial) MU_SendFrameCSV(leds);
  delay(50);
}
```

## Rainbow Wave

```cpp
void loop() {
  uint8_t timeOffset = millis() / 10;

  for (uint8_t y=0; y<MATRIX_HEIGHT; ++y) {
    for (uint8_t x=0; x<MATRIX_WIDTH; ++x) {
      uint8_t hue = timeOffset + (x * 32) + (y * 32);
      uint8_t brightness = beatsin8(10, 64, 255, 0, x * 16);
      leds[MU_XY(x, y)] = CHSV(hue, 255, brightness);
    }
  }

  FastLED.show();
  if (Serial) MU_SendFrameCSV(leds);
  delay(50);
}
```

## Plasma Effect

```cpp
void loop() {
  uint8_t time1 = millis() / 10;
  uint8_t time2 = millis() / 7;

  for (uint8_t y=0; y<MATRIX_HEIGHT; ++y) {
    for (uint8_t x=0; x<MATRIX_WIDTH; ++x) {
      uint8_t hue = sin8(x * 16 + time1) + sin8(y * 16 + time2);
      leds[MU_XY(x, y)] = CHSV(hue, 255, 255);
    }
  }

  FastLED.show();
  if (Serial) MU_SendFrameCSV(leds);
  delay(30);
}
```

## Color Cycling

```cpp
void loop() {
  static uint8_t hue = 0;
  hue += 2;  // Increment each frame

  // Fill entire matrix with single color
  for (uint8_t y=0; y<MATRIX_HEIGHT; ++y)
    for (uint8_t x=0; x<MATRIX_WIDTH; ++x)
      leds[MU_XY(x, y)] = CHSV(hue, 255, 255);

  FastLED.show();
  if (Serial) MU_SendFrameCSV(leds);
  delay(50);
}
```

## Notes

- HSV (Hue, Saturation, Value) is easier for color effects
- Hue: 0-255 (0=red, 64=yellow, 128=cyan, 192=purple, 255=red)
- Saturation: 0=white, 255=full color
- Value: 0=black, 255=bright
- Use `beatsin8()` and `sin8()` for smooth animations
