# CadQuery Docker

This container installs **CadQuery 2.7.0** (latest stable release, Feb 13 2026) using **conda-forge via micromamba**.  
CadQuery’s docs and package metadata note conda is the better-supported route for CadQuery’s dependency stack (OCP/OCCT).  

## Build

```bash
./scripts/build.sh
````

Build without cq-cli:

```bash
INSTALL_CQ_CLI=0 ./scripts/build.sh
```

## Run

Interactive Python:

```bash
./scripts/run.sh cadquery:2.7.0 python
```

Quick sanity check:

```bash
./scripts/run.sh cadquery:2.7.0 python -c "import cadquery as cq; print(cq.__version__)"
```

## Example: export STEP/STL using CadQuery exporters

Create `box.py`:

```python
import cadquery as cq

result = cq.Workplane("XY").box(10, 20, 30)
cq.exporters.export(result, "box.step")
cq.exporters.export(result, "box.stl")
print("Wrote box.step and box.stl")
```

Run it:

```bash
./scripts/run.sh cadquery:2.7.0 python box.py
```

Outputs appear in your current directory.

## Example: use cq-cli (if enabled)

Validate:

```bash
./scripts/run.sh cadquery:2.7.0 cq-cli --validate true --infile /work/box.py
```

Convert to STEP:

```bash
./scripts/run.sh cadquery:2.7.0 cq-cli --codec step --infile /work/box.py --outfile /work/box.step
```

Convert to STL:

```bash
./scripts/run.sh cadquery:2.7.0 cq-cli --codec stl --infile /work/box.py --outfile /work/box.stl \
  --outputopts "linearDeflection:0.3;angularDeflection:0.3"
```

## Notes

* Headless container (no CQ-editor GUI).
* This repo avoids Dockerfile heredocs (which can break if delimiters are indented).
