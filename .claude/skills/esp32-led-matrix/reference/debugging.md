# LED Matrix Debugging Reference

Complete guide for troubleshooting hardware issues with ESP32-S3 LED matrix displays.

## Quick Diagnostic Checklist

1. **Device detected?** → `lsusb | grep -i esp`
2. **Calibration pattern correct?** → `MU_DrawCalibration(leds)`
3. **Serial working?** → Check for META line and frame output
4. **Config matches hardware?** → Review `lib/BoardConfig/BoardConfig.h`

## Diagnostic Tools

### 1. Calibration Pattern

Add this to your code to display corner markers:

```cpp
void loop() {
  MU_DrawCalibration(leds);
  FastLED.show();
  delay(1000);
}
```

**Expected pattern:**
- **Top-Left:** Green
- **Top-Right:** Red
- **Bottom-Left:** Blue
- **Bottom-Right:** White

Use this to verify:
- Color order is correct
- Orientation is correct
- Wiring pattern is correct

### 2. Serial Visualization

```bash
# Auto-configure from META line
python3 tools/led_matrix_viz.py -p /dev/ttyACM0 -b 115200 --stats --verbose

# List available ports
python3 tools/led_matrix_viz.py --list-ports

# Demo mode (no hardware required)
python3 tools/led_matrix_viz.py --demo --width 8 --height 8
```

### 3. Device Detection

```bash
# Verify ESP32 is detected
lsusb | grep -i esp
# Should show: "Espressif USB JTAG/serial debug unit"

# List serial ports
pio device list

# Monitor raw serial
pio device monitor -b 115200
```

## Common Hardware Issues

### Issue: Colors Are Wrong

**Symptoms:**
- Red appears as blue or green
- Colors are swapped or inverted
- RGB values don't match expected colors

**Root Cause:** Different LED strips use different color orders (RGB, GRB, BGR, etc.)

**Fix:** Adjust `COLOR_ORDER` in `lib/BoardConfig/BoardConfig.h`

```cpp
// Try these options:
#define COLOR_ORDER RGB   // Most common for Waveshare ESP32-S3-Matrix
#define COLOR_ORDER GRB   // Alternative
#define COLOR_ORDER BGR   // Alternative
```

**Test with:**
```cpp
leds[0] = CRGB::Red;    // Should appear red
leds[1] = CRGB::Green;  // Should appear green
leds[2] = CRGB::Blue;   // Should appear blue
FastLED.show();
```

**After fixing:** Rebuild and upload: `pio run -t upload`

### Issue: Left/Right Swap on Alternating Rows

**Symptoms:**
- Row 0 displays correctly (left to right)
- Row 1 is mirrored (right to left)
- Pattern alternates for each row
- Serpentine/zigzag wiring pattern

**Root Cause:** LED strips can be wired in progressive (all rows same direction) or serpentine (alternating direction).

**Fix:** Set `PANEL_WIRING_SERPENTINE` in `lib/BoardConfig/BoardConfig.h`

```cpp
// Progressive row-major (all rows left-to-right):
#define PANEL_WIRING_SERPENTINE 0

// Serpentine/zigzag (alternate rows right-to-left):
#define PANEL_WIRING_SERPENTINE 1
```

**Test:** Draw vertical line at x=2. Should be straight, not zigzag.

### Issue: Display Rotated Wrong

**Symptoms:**
- Image appears rotated 90°, 180°, or 270°
- Top of display is physically on side or bottom

**Fix:** Adjust `PANEL_ROTATION` in `lib/BoardConfig/BoardConfig.h`

```cpp
#define PANEL_ROTATION 0    // No rotation
#define PANEL_ROTATION 90   // 90° clockwise
#define PANEL_ROTATION 180  // 180°
#define PANEL_ROTATION 270  // 270° clockwise (90° counter-clockwise)
```

**Test:** Use calibration pattern. Top-left should be green.

### Issue: Display Mirrored

**Symptoms:**
- Horizontally or vertically flipped
- Text appears backwards
- Pattern is mirrored

**Fix:** Adjust flip flags in `lib/BoardConfig/BoardConfig.h`

```cpp
#define PANEL_FLIP_X 0  // Set to 1 for horizontal flip
#define PANEL_FLIP_Y 0  // Set to 1 for vertical flip
```

**Test:** Calibration pattern corners should match physical positions.

### Issue: Serial Not Working

**Symptoms:**
- No output in serial monitor
- Visualizer shows no data
- META line not printed

**Root Cause:** Serial may not be connected or code is blocking on serial wait.

**Fix:** Ensure serial is optional in your code:

```cpp
void setup() {
  Serial.begin(115200);

  // Non-blocking wait (max 1.5 seconds)
  unsigned long t0 = millis();
  while (!Serial && millis() - t0 < 1500) {
    delay(10);
  }

  // Guard serial output
  if (Serial) MU_PrintMeta();
}

void loop() {
  // Your game code...

  // Guard serial output
  if (Serial) MU_SendFrameCSV(leds);
  delay(100);  // Limit frame rate
}
```

**Wrong approach (blocks forever if no serial):**
```cpp
void setup() {
  Serial.begin(115200);
  while (!Serial) {}  // DON'T DO THIS - hangs forever!
}
```

**Check baud rate matches:**
- Code: `Serial.begin(115200);`
- Monitor: `pio device monitor -b 115200`
- Visualizer: `python3 tools/led_matrix_viz.py -b 115200`

### Issue: XY Mapping Wrong

**Symptoms:**
- Patterns appear scrambled or incorrect
- Coordinates don't match expected positions
- Drawing at (0,0) doesn't light top-left

**Root Cause:** Manual index calculation doesn't account for wiring/orientation.

**Fix:** Always use the `MU_XY()` mapping function:

```cpp
// CORRECT: Use MU_XY for all coordinate access
leds[MU_XY(x, y)] = CRGB::Red;

// WRONG: Never calculate index manually
leds[y * MATRIX_WIDTH + x] = CRGB::Red;  // DON'T DO THIS
```

`MU_XY()` handles:
- Serpentine vs progressive wiring
- Rotation (0°, 90°, 180°, 270°)
- Horizontal/vertical flipping
- Different matrix dimensions

**Test:** Draw pixel at (0,0). Should be top-left corner.

## Systematic Debugging Workflow

### Step 1: Verify Hardware Connection

```bash
lsusb | grep -i esp
# Should show: "Espressif USB JTAG/serial debug unit"

# If not found:
# - Check USB cable is data-capable (not power-only)
# - Try different USB port
# - Replug ESP32
```

### Step 2: Display Calibration Pattern

```cpp
void loop() {
  MU_DrawCalibration(leds);
  FastLED.show();
  delay(1000);
}
```

Rebuild and upload:
```bash
pio run -t upload
```

Check physical corners:

| Physical Corner | Expected Color | If Wrong |
|----------------|----------------|----------|
| Top-Left | Green | Check ROTATION/FLIP |
| Top-Right | Red | Check ROTATION/FLIP |
| Bottom-Left | Blue | Check ROTATION/FLIP |
| Bottom-Right | White | Check ROTATION/FLIP |
| All colors wrong | — | Check COLOR_ORDER |
| Alternating rows mirrored | — | Check WIRING_SERPENTINE |

### Step 3: Test Serial Output

```cpp
void setup() {
  Serial.begin(115200);
  unsigned long t0 = millis();
  while (!Serial && millis() - t0 < 1500) { delay(10); }
  if (Serial) {
    Serial.println("ESP32 LED Matrix Starting...");
    MU_PrintMeta();
  }
}

void loop() {
  // Your pattern...
  if (Serial) {
    MU_SendFrameCSV(leds);
    Serial.println("Frame sent");
  }
  delay(100);
}
```

Monitor output:
```bash
pio device monitor -b 115200
```

Should see:
```
ESP32 LED Matrix Starting...
META,width:8,height:8,wiring:progressive,rotation:0,...
0x1e1e1e,0x000000,0x1e1e1e,...
Frame sent
```

### Step 4: Visualize in Terminal

```bash
# Auto-configure from META line
python3 tools/led_matrix_viz.py -p /dev/ttyACM0 -b 115200 --stats

# If no META, manual config:
python3 tools/led_matrix_viz.py -p /dev/ttyACM0 -b 115200 \
  --width 8 --height 8 \
  --wiring progressive \
  --input-order xy
```

Compare terminal visualization to physical hardware. Should match exactly.

### Step 5: Iterate on Board Config

Edit `lib/BoardConfig/BoardConfig.h`:

```cpp
// Try different values:
#define COLOR_ORDER RGB              // or GRB, BGR
#define PANEL_WIRING_SERPENTINE 0    // or 1
#define PANEL_ROTATION 0             // or 90, 180, 270
#define PANEL_FLIP_X 0               // or 1
#define PANEL_FLIP_Y 0               // or 1
```

Rebuild after each change:
```bash
pio run -t upload
```

All games use the same config, so **fix it once and everything works**.

## Visualization Tools

### led_matrix_viz.py

Terminal visualizer with auto-configuration:

```bash
# Auto-detect from META
python3 tools/led_matrix_viz.py -p /dev/ttyACM0 -b 115200 --stats --verbose

# Manual configuration
python3 tools/led_matrix_viz.py -p /dev/ttyACM0 -b 115200 \
  --width 8 --height 8 \
  --wiring progressive \
  --input-order xy \
  --rotate 0

# ASCII mode (no colors)
python3 tools/led_matrix_viz.py -p /dev/ttyACM0 -b 115200 --ascii

# Quick flip test
python3 tools/led_matrix_viz.py -p /dev/ttyACM0 -b 115200 --flip-x --flip-y

# Demo mode (no hardware)
python3 tools/led_matrix_viz.py --demo --width 8 --height 8
```

### monitor_pong.py

Raw serial monitor:

```bash
python3 tools/monitor_pong.py -p /dev/ttyACM0
```

Shows unfiltered serial output, useful for debugging print statements.

## Configuration File Location

**Single source of truth:** `lib/BoardConfig/BoardConfig.h`

```cpp
// Matrix dimensions
#define MATRIX_WIDTH 8
#define MATRIX_HEIGHT 8

// LED hardware
#define LED_PIN 14
#define BRIGHTNESS_LIMIT 60  // ≤ 60 recommended
#define COLOR_ORDER RGB      // RGB for Waveshare ESP32-S3-Matrix

// Panel orientation
#define PANEL_WIRING_SERPENTINE 0  // 0=progressive, 1=serpentine
#define PANEL_ROTATION 0           // 0, 90, 180, 270
#define PANEL_FLIP_X 0             // 0 or 1
#define PANEL_FLIP_Y 0             // 0 or 1
```

**After changing:** Rebuild all affected projects with `pio run -t upload`

## Debugging Tips

### Limit Serial Frame Rate

Too fast overwhelms serial buffer:

```cpp
void loop() {
  // Game logic...
  FastLED.show();

  if (Serial) MU_SendFrameCSV(leds);
  delay(100);  // 10 FPS - keeps serial stable
}
```

Ideal range: 5-20 FPS (50-200ms delay)

### Use Simple Test Patterns

Start with single pixel before complex animations:

```cpp
// Single pixel test
leds[MU_XY(0, 0)] = CRGB::Red;  // Top-left
leds[MU_XY(MATRIX_WIDTH-1, 0)] = CRGB::Green;  // Top-right
FastLED.show();
```

### Check Bounds

Always validate coordinates:

```cpp
void setPixel(int8_t x, int8_t y, CRGB color) {
  if (x >= 0 && x < MATRIX_WIDTH && y >= 0 && y < MATRIX_HEIGHT) {
    leds[MU_XY(x, y)] = color;
  }
}
```

## Quick Reference Table

| Problem | Location to Fix | Values to Try |
|---------|----------------|---------------|
| Wrong colors | `COLOR_ORDER` | RGB, GRB, BGR |
| Alternating row mirror | `PANEL_WIRING_SERPENTINE` | 0, 1 |
| Rotated display | `PANEL_ROTATION` | 0, 90, 180, 270 |
| Mirrored display | `PANEL_FLIP_X/Y` | 0, 1 |
| Scrambled pattern | Code | Use `MU_XY(x,y)` |
| No serial output | Code | Add `if (Serial)` guards |
| Device not detected | Hardware | Check cable, replug |
| Upload timeout | Hardware | BOOT+RESET sequence |

## Helpful Commands

```bash
# Device detection
lsusb | grep -i esp

# List ports
python3 tools/led_matrix_viz.py --list-ports
pio device list

# Visualize
python3 tools/led_matrix_viz.py -p /dev/ttyACM0 -b 115200 --stats

# Monitor serial
pio device monitor -b 115200

# Rebuild and upload
pio run -t upload
```
