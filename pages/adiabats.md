---
jupytext:
  formats: ipynb,md:myst
  text_representation:
    extension: .md
    format_name: myst
    format_version: 0.13
    jupytext_version: 1.19.6
kernelspec:
  display_name: Python 3 (ipykernel)
  language: python
  name: python3
---

+++ {"slideshow": {"slide_type": "slide"}}

(nb:radeq)=
# Radiative Equilibrium

This notebook is part of [The Climate Laboratory](https://brian-rose.github.io/ClimateLaboratoryBook) by [Brian E. J. Rose](http://www.atmos.albany.edu/facstaff/brose/index.html), University at Albany.

+++

____________

## 1. The observed annual, global mean temperature profile
____________

Let's look again the observations of air temperature from the NCEP Reanalysis data we first encountered in the [Radiation notes](https://brian-rose.github.io/ClimateLaboratoryBook/courseware/radiation.html).

In this notebook  we'll define a function to create the Skew-T diagram, because later we are going to reuse it several times.

*Click to expand code cells to see Python details*

```{code-cell} ipython3
:tags: [hide_input]

#  This code is used just to create the skew-T plot of global, annual mean air temperature
%matplotlib inline
import numpy as np
import matplotlib.pyplot as plt
import xarray as xr
from pathlib import Path
import pandas as pd
from metpy.plots import SkewT

# Cache the global-mean profile locally so we only hit the NOAA server once.
# Delete the csv file (or set use_cache = False) to force a fresh download.
use_cache = True
tglobal_csv = Path("Tglobal_ncep.csv")

if use_cache and tglobal_csv.exists():
    df = pd.read_csv(tglobal_csv)
    Tglobal = xr.DataArray(
        df["air"].values,
        coords={"level": df["level"].values},
        dims="level",
        name="air",
    )
    print(f"read Tglobal from {tglobal_csv}")
else:
    ncep_url = "http://www.esrl.noaa.gov/psd/thredds/dodsC/Datasets/ncep.reanalysis.derived/"
    ncep_air = xr.open_dataset( ncep_url + "pressure/air.mon.1981-2010.ltm.nc",
        decode_times=xr.coders.CFDatetimeCoder(use_cftime=True))
    #  Take global, annual average 
    coslat = np.cos(np.deg2rad(ncep_air.lat))
    weight = coslat / coslat.mean(dim='lat')
    Tglobal = (ncep_air.air * weight).mean(dim=('lat','lon','time'))
    pd.DataFrame({"level": Tglobal.level.values, "air": Tglobal.values}).to_csv(
        tglobal_csv, index=False
    )
    print(f"wrote Tglobal to {tglobal_csv}")
```

```{code-cell} ipython3
:tags: [hide_input]

def make_skewT():
    fig = plt.figure(figsize=(9, 9))
    skew = SkewT(fig, rotation=30)
    skew.plot(Tglobal.level, Tglobal, color='black', linestyle='-', linewidth=2, label='Observations')
    skew.ax.set_ylim(1050, 10)
    skew.ax.set_xlim(-90, 45)
    # Add the relevant special lines
    skew.plot_dry_adiabats(linewidth=0.5)
    skew.plot_moist_adiabats(linewidth=0.5)
    #skew.plot_mixing_lines()
    skew.ax.legend()
    skew.ax.set_xlabel('Temperature (degC)', fontsize=14)
    skew.ax.set_ylabel('Pressure (hPa)', fontsize=14)
    return skew
```

## Add a dry adiabat

```{code-cell} ipython3
from scipy.integrate import solve_ivp

def hit_ground(t, the_vars):
    """Event: when height (the_vars[0]) is zero."""
    return the_vars[0]

def find_derivs(the_time,the_vars):
    dx_dt = the_vars[1]
    dy_dt = -the_vars[0]
    return [dx_dt,dy_dt]

# Set hit_ground to be a terminal event (stops integration)
# and only trigger when the value is going from positive to negative (direction=-1)
# to avoid triggering at the start (t=0).
init_0 = [0,1]
hit_ground.terminal = True
hit_ground.direction = -1
tspan=[0,6]

sol = solve_ivp(
    find_derivs,
    tspan,
    init_0,
    events=[hit_ground],
    dense_output=True # Enable interpolation for plotting smooth curve
)
```

```{code-cell} ipython3
the_times = np.arange(0,sol.t[-1],0.01)
yplot = sol.sol(the_times)
df_output = pd.DataFrame.from_records(yplot.T,columns = ['xvar','yvar'])
df_output['time']=the_times
```

```{code-cell} ipython3
ig, ax = plt.subplots(1,1)
ax.plot('time','xvar',data=df_output)
ax.plot('time','yvar',data=df_output)
ax.legend();
```

```{code-cell} ipython3

```
