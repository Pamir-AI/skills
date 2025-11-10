# Minimal LED Matrix Game Template

The simplest starting point for a new LED matrix game.

## src/main.cpp

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
  FastLED.clear(); FastLED.show();
}

void loop() {
  FastLED.clear();

  // YOUR GAME LOGIC HERE
  for (uint8_t y=0; y<MATRIX_HEIGHT; ++y)
    for (uint8_t x=0; x<MATRIX_WIDTH; ++x)
      if ((x+y)&1) leds[MU_XY(x,y)] = CRGB(30,30,30);

  FastLED.show();
  if (Serial) MU_SendFrameCSV(leds);
  delay(100);
}
```

## platformio.ini

```ini
[env:waveshare-esp32s3-matrix]
platform = espressif32
board = adafruit_feather_esp32s3
framework = arduino
lib_deps =
    fastled/FastLED@^3.9.20
lib_extra_dirs = ../../lib
monitor_speed = 115200
upload_speed = 921600
```

## Setup

```bash
mkdir -p examples/MyGame/src
cd examples/MyGame
# Copy platformio.ini above
# Copy src/main.cpp above
pio run -t upload
```
