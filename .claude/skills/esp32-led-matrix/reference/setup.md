# ESP32 LED Matrix Setup Reference

Complete guide for installing PlatformIO and creating new ESP32-S3 LED matrix projects.

## PlatformIO Installation

### Method 1: Using uv (Recommended)

**Why uv?** 10-100x faster than pip, handles PATH automatically, keeps Python environment clean.

```bash
# Install uv (modern Python package manager)
curl -LsSf https://astral.sh/uv/install.sh | sh
source ~/.bashrc  # Or restart terminal

# Install PlatformIO
uv tool install platformio

# Verify installation
pio --version
```

### Method 2: Using pip (Quick Alternative)

```bash
pip3 install platformio --break-system-packages
```

Note: This works immediately but doesn't have the performance and PATH benefits of uv.

## Create New Game Project

### Step 1: Create Directory Structure

```bash
mkdir -p examples/MyGame/src
cd examples/MyGame
```

### Step 2: Create platformio.ini

```ini
[env:waveshare-esp32s3-matrix]
platform = espressif32
board = adafruit_feather_esp32s3  # 4MB flash (matches Waveshare hardware)
framework = arduino
lib_deps =
    fastled/FastLED@^3.9.20
lib_extra_dirs = ../../lib      # Shared libs at repo root
monitor_speed = 115200
upload_speed = 921600
```

**Critical:** Always include `lib_extra_dirs = ../../lib` to access shared BoardConfig and MatrixUtil libraries.

### Step 3: Create src/main.cpp

Use the minimal template:

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

## Build & Upload Commands

### First Build

```bash
pio run
```

**Note:** First build downloads ~1.5GB ESP32 toolchain (takes 5-10 minutes). Subsequent builds are fast.

### Upload to ESP32

```bash
# Auto-detect port
pio run -t upload

# Specific port
pio run -t upload --upload-port /dev/ttyACM0
```

### Other Commands

```bash
# Clean build
pio run -t clean

# Monitor serial output
pio device monitor

# List available devices
pio device list
```

## Upload Troubleshooting

### Normal Case (No Buttons Needed)

```bash
pio run -t upload  # Usually just works
```

You should see:
```
Connecting....
Writing at 0x00010000... (10 %)
Writing at 0x00020000... (20 %)
...
```

If you see progress bars, upload is working correctly!

### If Upload Fails ("Connecting..." Forever)

If you see endless dots with no progress:
```
Connecting........._____....._____
```

**Manual Button Sequence:**

1. Hold **BOOT** button
2. While holding BOOT, press **RESET** button once
3. Release both buttons
4. Run `pio run -t upload` again **within 10 seconds**

### Still Failing?

Check these:

```bash
# Verify ESP32 is detected
lsusb | grep -i esp
# Should show: "Espressif USB JTAG/serial debug unit"

# List available ports
pio device list

# Check USB connection
# - Try different USB port on computer
# - Try different USB cable (some are power-only)
# - Ensure cable is firmly connected
```

### If Code Crashes or Acts Weird

- Press **RESET** button once (no BOOT needed)
- This restarts your code from the beginning

## Quick Reference Table

| Issue | Solution |
|-------|----------|
| Upload times out with dots | BOOT+RESET sequence → retry upload |
| Code frozen/not responding | Press RESET only |
| "Couldn't find board" | Check `lsusb`, check cable, try button sequence |
| First upload on new board | Often needs manual button sequence |

## Common Setup Issues

### Flash Size Mismatch

**Symptom:** "Detected size(4096k) smaller than (8192k)" on boot

**Solution:** Use correct board in platformio.ini:
```ini
board = adafruit_feather_esp32s3  # CORRECT (4MB)
# NOT: board = esp32-s3-devkitc-1  # WRONG (8MB)
```

### Wrong Device Detected

**Symptom:** `lsusb` shows "MicroPython" or "Pico" instead of "Espressif"

**Solution:** That's the internal CM5 system. Replug the ESP32's USB cable.

### Include Errors

**Symptom:** Cannot find BoardConfig.h or MatrixUtil.h

**Solution:**
- Use angle brackets: `#include <BoardConfig.h>` not `#include "BoardConfig.h"`
- Add `lib_extra_dirs = ../../lib` to platformio.ini

### Shared Libraries Not Found

**Symptom:** Build fails with "No such file or directory" for BoardConfig.h

**Solution:** Verify platformio.ini has:
```ini
lib_extra_dirs = ../../lib
```

And verify files exist:
```bash
ls ../../lib/BoardConfig/BoardConfig.h
ls ../../lib/MatrixUtil/MatrixUtil.h
```

## Board Configuration

The single source of truth is `lib/BoardConfig/BoardConfig.h`:

```cpp
// Matrix dimensions
#define MATRIX_WIDTH 8
#define MATRIX_HEIGHT 8

// LED hardware
#define LED_PIN 14
#define BRIGHTNESS_LIMIT 60  // ≤ 60 recommended
#define COLOR_ORDER RGB      // RGB for Waveshare ESP32-S3-Matrix

// Panel orientation
#define PANEL_WIRING_SERPENTINE 0  // 0=progressive row-major, 1=serpentine
#define PANEL_ROTATION 0           // 0, 90, 180, 270
#define PANEL_FLIP_X 0             // 0 or 1
#define PANEL_FLIP_Y 0             // 0 or 1
```

All games use this shared configuration. Change it once, everything follows.

## Project Structure

```
examples/MyGame/
├── platformio.ini         # PlatformIO configuration
├── src/
│   └── main.cpp          # Your game code
└── .pio/                 # Build artifacts (auto-generated)
```

Shared libraries at repo root:
```
lib/
├── BoardConfig/
│   ├── BoardConfig.h     # Hardware configuration
│   └── library.json
└── MatrixUtil/
    ├── MatrixUtil.h      # Helper functions
    └── library.json
```

## Next Steps

After setup:
- See [debugging.md](debugging.md) for hardware troubleshooting
- See [development.md](development.md) for game development guides
- Check [../examples/](../examples/) for code templates
