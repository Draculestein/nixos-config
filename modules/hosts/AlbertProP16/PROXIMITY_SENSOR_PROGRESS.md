# Proximity sensor (HID-SENSOR-200011) — PROXIMITY_NEAR_LEVEL verification

Machine: ASUS ProArt P16 (H7606WV), host AlbertProP16.
Goal: determine whether `PROXIMITY_NEAR_LEVEL=1` is the correct value for the
udev hwdb rule in `configuration.nix`, or find the correct value.

## What is already in place (verified)
- `configuration.nix` adds via `services.udev.extraHwdb`:
  ```
  sensor:modalias:platform:HID-SENSOR-200011:dmi:*:svnASUSTeK*:*:rnH7606WV:*
   PROXIMITY_NEAR_LEVEL=1
  ```
- After `nh os switch`, the property IS applied. `/run/udev/data/c235:0` and
  `c235:1` both contain:
  ```
  E:PROXIMITY_NEAR_LEVEL=1
  E:IIO_SENSOR_PROXY_TYPE=iio-poll-proximity
  E:SYSTEMD_WANTS=iio-sensor-proxy.service
  ```
  So the rule matches and iio-sensor-proxy is wired to the sensor.

## IIO topology
- iio:device0 name=prox, HID-SENSOR-200011, channels:
  in_proximity0_raw (scale 1.0), in_proximity1_raw (scale 0.001), plus in_attention_*.
  path: .../HID-SENSOR-200011.1.auto/iio:device0
- iio:device1 name=prox (has in_proximity0_raw)
- iio:device2 name=als

## Driver semantics (iio-sensor-proxy 3.9, src/drv-iio-poll-proximity.c)
Poll driver reads `in_proximity0_raw` (uncached) every 700ms and computes:
```
near_level = PROXIMITY_NEAR_LEVEL           # int, =1
threshold  = near_level * (last_raw > near_level ? 0.9 : 1.1)
is_near    = (raw > threshold)              # STRICTLY greater
```
With near_level=1:
- far -> near  requires  raw > 1.1  (i.e. raw >= 2)
- near -> far  requires  raw <= 0.9 (i.e. raw == 0); stays near while raw >= 1
`near_level=0` is treated as "unset" (warning), so integer 0 is not usable.

### KEY IMPLICATION
- If the sensor raw is truly binary 0/1, `raw > 1.1` is NEVER true => "near"
  never fires => PROXIMITY_NEAR_LEVEL=1 is BROKEN for this sensor.
- Value 1 is correct ONLY IF the "near/present" raw value is >= 2.
- Must measure the actual raw values for present vs absent.

## Experiment plan
1. Baseline read `in_proximity0_raw` (uncached) on device0 & device1 while ABSENT.
2. Read again while PRESENT/close.
3. Run `monitor-sensor` and watch the reported near/far transitions while
   moving in/out of the sensor's field of view.
4. Decide: value 1 correct iff present-raw >= 2 and absent-raw <= 1
   (ideally absent=0). Otherwise compute correct near_level = separating int
   such that far->near (n*1.1) and near->far (n*0.9) cleanly split the two
   observed raw levels.

## Findings (2026-08-09, guided experiment /tmp/prox_experiment.sh)
Sampling via one-shot sysfs reads (slow, ~1-2s each, occasionally blank/EIO):
- ABSENT : in_proximity0_raw = 0 (both device0 & device1)
- NORMAL : in_proximity0_raw = 0 (no change)
- CLOSE  : in_proximity0_raw = 0 (leaning into the bezel, still 0)
- in_proximity1_raw = 0, in_attention_input = blank/0 in all phases.
- monitor-sensor: "Has proximity sensor (near: 0)"; never transitioned to near.

### Interpretation
- iio-sensor-proxy 3.9 has ONLY `iio-poll-proximity` (one-shot sysfs) for
  proximity; its udev rules classify any `in_proximity0_raw` device as poll.
- The polled `in_proximity0_raw` is stuck at 0 regardless of presence, so
  `raw > near_level*1.1` is never true -> "near" never fires for ANY near_level.
- Therefore PROXIMITY_NEAR_LEVEL=1 does NOT set the sensor up correctly. The
  value is not "wrong-but-fixable-with-another-int"; the polled interface
  yields no usable signal at all.
## External context (web research 2026-08-09)
- HID-SENSOR-200011 = Human Presence Detection (HPD) sensor. On this class of
  laptop (AMD + Chicony/USB camera module) it is KNOWN-FLAKY under Linux:
  `iio_info`/sysfs reads hang forever -> kernel HID quirks were added to work
  around hangs (Ubuntu LP #2102077 "Run iio_info will be stucked forever
  (HID-SENSOR-200011.5.auto)", LP #2103753). This matches the blank/EIO reads
  seen above.
- AMD SFH HPD is being DISABLED BY DEFAULT upstream (LP #2100748) via a new
  `/sys/bus/pci/drivers/pcie_mp2_amd/*/hpd` toggle. NOTE: on THIS machine the
  presence sensor is a USB-HID device (0003:3277:0059), not the AMD-SFH PCIe
  path, so that toggle is absent here (`ls .../pcie_mp2_amd/*/hpd` -> none).
- Kernel here: 7.1.7.

## CONCLUSION
PROXIMITY_NEAR_LEVEL=1 does NOT set the proximity sensor up correctly.
- The rule IS applied and iio-sensor-proxy DOES bind the sensor, but the polled
  `in_proximity0_raw` stays 0 even with a face/hand right against the bezel, so
  iio-sensor-proxy's "near" NEVER fires (`monitor-sensor` = near:0 throughout).
- The original comment's premise ("raw 0/1, so 1 == present") is DISPROVEN:
  present raw is 0, not 1. And even if it were 1, near_level=1 needs raw>=2
  (rule: raw > near_level*1.1), so 1 would still be wrong for a 0/1 sensor.
- No integer PROXIMITY_NEAR_LEVEL can fix this: the raw signal itself is absent
  through the polled path. The blocker is the sensor/kernel, not the hwdb value.

## RECOMMENDATION
1. Do NOT trust value 1 (or any value) to enable this sensor via iio-sensor-proxy.
2. The hwdb rule is currently INERT (harmless but non-functional). Either:
   - remove it and treat HPD as unsupported on this machine/kernel, or
   - keep it only as a documented placeholder for if the kernel path improves.
   (Comment in configuration.nix has been corrected to state this.)
3. Salvageability check — RESOLVED (2026-08-09, `sudo bash /tmp/prox_buffer.sh`):
   buffer enabled OK (enable=1, trigger=prox-dev0) but ZERO triggered records
   during a 12s hand-wave at the bezel. So the sensor is SILENT in buffered
   mode too, not just polled mode. => No path forward via iio-sensor-proxy or
   buffered capture; the HPD sensor provides no signal under Linux on this
   machine/kernel (7.1.7). Treat HPD as UNSUPPORTED. The hwdb rule can be
   removed (kept as documented placeholder only if desired).
