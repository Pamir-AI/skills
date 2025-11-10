# LED Matrix Game Development Reference

Complete guide for creating LED matrix games using shared libraries and best practices.

## Minimal Game Template

Every new game starts with this structure:

```cpp
// src/main.cpp
#include <FastLED.h>
#include <BoardConfig.h>
#include <MatrixUtil.h>

#define NUM_LEDS (MATRIX_WIDTH * MATRIX_HEIGHT)
CRGB leds[NUM_LEDS];

void setup() {
  Serial.begin(115200);
  unsigned long t0 = millis();
  while (!Serial && millis() - t0 < 1500) { delay(10); } // non-blocking
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
  if (Serial) MU_SendFrameCSV(leds); // terminal visualization
  delay(100);
}
```

## Shared Libraries

### BoardConfig.h

Single source of truth for hardware configuration:

```cpp
#include <BoardConfig.h>

// Available constants:
MATRIX_WIDTH         // Matrix width (e.g., 8)
MATRIX_HEIGHT        // Matrix height (e.g., 8)
LED_PIN             // Data pin number (e.g., 14)
BRIGHTNESS_LIMIT    // Max brightness (e.g., 60)
COLOR_ORDER         // Color order (RGB, GRB, BGR)
PANEL_WIRING_SERPENTINE  // 0=progressive, 1=serpentine
PANEL_ROTATION      // 0, 90, 180, 270
PANEL_FLIP_X        // 0 or 1
PANEL_FLIP_Y        // 0 or 1
```

**Never hardcode dimensions or pins.** Always use these constants.

### MatrixUtil.h

Helper functions for LED matrix operations:

```cpp
#include <MatrixUtil.h>

// Coordinate mapping (handles all wiring/orientation)
uint16_t index = MU_XY(x, y);
leds[MU_XY(x, y)] = CRGB::Red;

// FastLED initialization
MU_ADD_LEDS(LED_PIN, leds, NUM_LEDS);

// Serial helpers
MU_PrintMeta();           // Print config once (auto-configures visualizer)
MU_SendFrameCSV(leds);   // Send frame for visualization

// Debug calibration pattern
MU_DrawCalibration(leds);  // TL=Green, TR=Red, BL=Blue, BR=White
```

## Essential Development Rules

### 1. Always Use MU_XY() for Coordinates

```cpp
// CORRECT:
leds[MU_XY(x, y)] = CRGB::Red;

// WRONG - breaks with different wiring/orientation:
leds[y * MATRIX_WIDTH + x] = CRGB::Red;  // DON'T DO THIS
```

`MU_XY()` handles:
- Serpentine vs progressive wiring
- Rotation (0°, 90°, 180°, 270°)
- Horizontal/vertical flipping
- Different matrix dimensions

### 2. Never Hardcode Dimensions

```cpp
// CORRECT:
for (uint8_t y=0; y<MATRIX_HEIGHT; ++y)
  for (uint8_t x=0; x<MATRIX_WIDTH; ++x)
    leds[MU_XY(x,y)] = color;

// WRONG:
for (uint8_t y=0; y<8; ++y)  // Hardcoded!
  for (uint8_t x=0; x<8; ++x)  // Hardcoded!
    leds[y*8 + x] = color;  // Wrong mapping!
```

Why? Code works on different matrix sizes without changes.

### 3. Keep Serial Optional

```cpp
// CORRECT: Non-blocking wait, guarded output
void setup() {
  Serial.begin(115200);
  unsigned long t0 = millis();
  while (!Serial && millis() - t0 < 1500) { delay(10); }
  if (Serial) MU_PrintMeta();
}

void loop() {
  // game logic...
  if (Serial) MU_SendFrameCSV(leds);
}

// WRONG: Blocking wait
void setup() {
  Serial.begin(115200);
  while (!Serial) {}  // Hangs forever if no serial!
}
```

Why? Hardware works without serial connection.

### 4. Limit Frame Rate for Serial

```cpp
void loop() {
  // game logic...
  FastLED.show();

  if (Serial) MU_SendFrameCSV(leds);
  delay(100);  // 10 FPS - keeps serial stable
}
```

Ideal range: 5-20 FPS (50-200ms delay). Too fast overwhelms serial buffer.

### 5. Always Check Bounds

```cpp
// CORRECT: Bounds checking
if (x >= 0 && x < MATRIX_WIDTH && y >= 0 && y < MATRIX_HEIGHT) {
  leds[MU_XY(x, y)] = color;
}

// WRONG: No bounds checking
leds[MU_XY(x, y)] = color;  // May access out of bounds!
```

## Common Patterns

### Checkerboard

```cpp
for (uint8_t y=0; y<MATRIX_HEIGHT; ++y)
  for (uint8_t x=0; x<MATRIX_WIDTH; ++x)
    if ((x+y) & 1)
      leds[MU_XY(x,y)] = CRGB(30,30,30);
```

### Border

```cpp
for (uint8_t y=0; y<MATRIX_HEIGHT; ++y)
  for (uint8_t x=0; x<MATRIX_WIDTH; ++x)
    if (x==0 || x==MATRIX_WIDTH-1 || y==0 || y==MATRIX_HEIGHT-1)
      leds[MU_XY(x,y)] = CRGB::Blue;
```

### Moving Dot

```cpp
uint8_t x = (millis() / 200) % MATRIX_WIDTH;
uint8_t y = MATRIX_HEIGHT / 2;
leds[MU_XY(x, y)] = CRGB::Green;
```

### Random Pixels

```cpp
uint8_t x = random(MATRIX_WIDTH);
uint8_t y = random(MATRIX_HEIGHT);
leds[MU_XY(x, y)] = CRGB(random(256), random(256), random(256));
```

### Fill Rectangle

```cpp
void fillRect(uint8_t x0, uint8_t y0, uint8_t w, uint8_t h, CRGB color) {
  for (uint8_t dy=0; dy<h; ++dy)
    for (uint8_t dx=0; dx<w; ++dx)
      if (x0+dx < MATRIX_WIDTH && y0+dy < MATRIX_HEIGHT)
        leds[MU_XY(x0+dx, y0+dy)] = color;
}
```

### Draw Line (Horizontal)

```cpp
void drawHLine(uint8_t x0, uint8_t y, uint8_t len, CRGB color) {
  for (uint8_t i=0; i<len; ++i)
    if (x0+i < MATRIX_WIDTH && y < MATRIX_HEIGHT)
      leds[MU_XY(x0+i, y)] = color;
}
```

### Draw Line (Vertical)

```cpp
void drawVLine(uint8_t x, uint8_t y0, uint8_t len, CRGB color) {
  for (uint8_t i=0; i<len; ++i)
    if (x < MATRIX_WIDTH && y0+i < MATRIX_HEIGHT)
      leds[MU_XY(x, y0+i)] = color;
}
```

### Fade All LEDs

```cpp
// Fade to black
for (uint16_t i=0; i<NUM_LEDS; ++i)
  leds[i].fadeToBlackBy(64);  // 0-255
```

## FastLED Essentials

### Color Constants

```cpp
leds[i] = CRGB::Red;
leds[i] = CRGB::Green;
leds[i] = CRGB::Blue;
leds[i] = CRGB::White;
leds[i] = CRGB::Black;     // Off
leds[i] = CRGB::Yellow;
leds[i] = CRGB::Cyan;
leds[i] = CRGB::Magenta;
leds[i] = CRGB::Orange;
leds[i] = CRGB::Purple;
```

### RGB Values

```cpp
leds[i] = CRGB(255, 0, 0);      // Red (R, G, B)
leds[i] = CRGB(255, 128, 0);    // Orange
leds[i] = CRGB(0, 255, 0);      // Green
leds[i] = CRGB(0, 0, 255);      // Blue
leds[i] = CRGB(255, 255, 255);  // White
```

### Operations

```cpp
FastLED.clear();                 // All LEDs off (leds[] = black)
FastLED.show();                  // Update physical LEDs
FastLED.setBrightness(50);       // 0-255 (use BRIGHTNESS_LIMIT from config)
```

### Color Math

```cpp
leds[i] = CRGB::Red;
leds[i].fadeToBlackBy(128);      // 50% dimmer
leds[i] %= 128;                  // Scale brightness
leds[i] += CRGB::Blue;           // Add blue component
leds[i] -= CRGB(10, 10, 10);    // Subtract from all channels

// Scale entire array
for (uint16_t i=0; i<NUM_LEDS; ++i)
  leds[i].nscale8(128);          // Scale by 50%
```

### HSV Colors

```cpp
leds[i] = CHSV(hue, 255, 255);  // Hue: 0-255, Saturation: 0-255, Value: 0-255

// Rainbow effect
uint8_t hue = (millis() / 10) % 256;
leds[i] = CHSV(hue, 255, 255);
```

## Project Structure

```
examples/MyGame/
├── platformio.ini         # PlatformIO config
├── src/
│   └── main.cpp          # Your game code
└── README.md (optional)  # Game description
```

### platformio.ini Template

```ini
[env:waveshare-esp32s3-matrix]
platform = espressif32
board = adafruit_feather_esp32s3
framework = arduino
lib_deps =
    fastled/FastLED@^3.9.20
lib_extra_dirs = ../../lib      # CRITICAL: Shared libs
monitor_speed = 115200
upload_speed = 921600
```

**CRITICAL:** Always include `lib_extra_dirs = ../../lib` to use shared libraries.

## Development Workflow

### 1. Create Project

```bash
mkdir -p examples/MyGame/src
cd examples/MyGame
# Copy platformio.ini from RotatingDonut example
# Create src/main.cpp from template
```

### 2. Implement Game Logic

Edit `src/main.cpp`:

- Keep the template `setup()` and `loop()` structure
- Add your game logic in `loop()`
- Always use `MU_XY(x, y)` for coordinates
- Always check bounds: `if (x < MATRIX_WIDTH && y < MATRIX_HEIGHT)`
- Guard serial: `if (Serial)`

### 3. Build and Test

```bash
pio run                    # Build
pio run -t upload          # Upload to ESP32
```

### 4. Debug Visually

```bash
# Terminal visualizer (auto-configures from META)
python3 ../../tools/led_matrix_viz.py -p /dev/ttyACM0 -b 115200 --stats
```

### 5. Iterate

Make changes → rebuild → test. Visualizer runs in parallel with hardware.

## Example: Simple Snake Game

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

## Example: Bouncing Ball

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

  // Draw trail
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

## Example: Rainbow Gradient

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

## Development Checklist

Before asking "why doesn't my game work?":

- [ ] Using `MU_XY(x, y)` for all coordinate access?
- [ ] Bounds checking all coordinates?
- [ ] Using `MATRIX_WIDTH/HEIGHT` not hardcoded values?
- [ ] Serial output guarded with `if (Serial)`?
- [ ] Added `delay()` to limit frame rate?
- [ ] `lib_extra_dirs = ../../lib` in platformio.ini?
- [ ] Includes `<BoardConfig.h>` and `<MatrixUtil.h>` with angle brackets?
- [ ] Called `FastLED.show()` after drawing?
- [ ] Non-blocking serial wait in setup()?

## Performance Tips

### Optimize Loop Speed

```cpp
void loop() {
  // Minimize work in loop
  // Cache calculations outside loop if possible

  static unsigned long lastUpdate = 0;
  if (millis() - lastUpdate > 100) {  // Update every 100ms
    lastUpdate = millis();
    // Your update logic here
  }

  // Render
  FastLED.show();
}
```

### Reduce Serial Overhead

```cpp
// Only send frames occasionally
static uint8_t frameCount = 0;
if (Serial && ++frameCount % 2 == 0) {  // Every other frame
  MU_SendFrameCSV(leds);
}
```

### Use Fixed-Point Math

```cpp
// Instead of float (slow):
float x = 1.5;
x += 0.1;

// Use fixed-point (faster):
int16_t x = 150;  // 1.5 * 100
x += 10;          // 0.1 * 100
// Use: x / 100 for display
```

## Reference Files

- **Example project:** `examples/RotatingDonut/` - working PlatformIO game
- **Board config:** `lib/BoardConfig/BoardConfig.h` - hardware configuration
- **Matrix utils:** `lib/MatrixUtil/MatrixUtil.h` - helper functions
- **Visualizer:** `tools/led_matrix_viz.py` - terminal display

## Next Steps

- See [setup.md](setup.md) for project creation
- See [debugging.md](debugging.md) for troubleshooting
- Check [../examples/](../examples/) for more code samples
