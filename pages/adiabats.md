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
# Dry adiabat

This notebook is part of [The Climate Laboratory](https://brian-rose.github.io/ClimateLaboratoryBook) by [Brian E. J. Rose](http://www.atmos.albany.edu/facstaff/brose/index.html), University at Albany.

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
from scipy.integrate import solve_ivp
```

## Calculate dry adiabat

+++

## equations

+++

$$
\begin{aligned}
& h=c_p T-\frac{1}{p} \\
& d h=c_p d T-\frac{1}{p} d p \\
& d p=-p g d z
\end{aligned}
$$

$$
\begin{aligned}
& \frac{dh}{dt}=c_p \frac{dT}{dt}-\frac{1}{p}\frac{dp}{dt} = 0\\
& \frac{d p}{dt}=-\rho g \frac{d z}{dt}
\end{aligned}
$$

+++

## code

```{code-cell} ipython3

```

```{code-cell} ipython3
def reach_height(t, the_vars,wvel,stop_height):
    """Event: when height (the_vars[0]) is zero."""
    return the_vars[2] - stop_height

def find_derivs_dry_adiabat(the_time,the_vars,wvel,stop_height):
    """
    the_vars[0] = T
    the_vars[1] = p
    the_vars[2] = z
    """
    T, p, z = the_vars[0],the_vars[1],the_vars[2]
    cpd = 1004
    Rd = 287
    g=9.8
    rho = p/(Rd*T)
    vol = 1/rho
    dz_dt = wvel
    dp_dt = -rho*g*wvel
    dT_dt = (vol*dp_dt)/cpd
    return [dT_dt,dp_dt,dz_dt]
```

```{code-cell} ipython3
# Set reach_height to be a terminal event (stops integration)
# and only trigger when the (height - stop_height) is going from negative to positive (direction=1)
# to avoid triggering at the start (t=0).
T_start = 283.15
p_start = 1.e5
z_start = 0
wvel = 5

init_0 = [T_start,p_start,z_start]
reach_height.terminal = True
reach_height.direction = 1
tspan=[0,10000]
stop_height=10000

sol = solve_ivp(
    find_derivs_dry_adiabat,
    tspan,
    init_0,
    events=[reach_height,],
    args = (wvel,stop_height),
    dense_output=True # Enable interpolation for plotting smooth curve
)
```

```{code-cell} ipython3
the_times = np.arange(0,sol.t[-1],10)
results = sol.sol(the_times)
df_output = pd.DataFrame.from_records(results.T,columns = ['temp','press','height'])
df_output['time']=the_times
df_output['press']*=1.e-2
df_output['temp']-= 273.15
df_output.head()
```

## skewT plot

```{code-cell} ipython3
def make_skewT():
    fig = plt.figure(figsize=(9, 15))
    skew = SkewT(fig, rotation=30)
    # note: SkewT.plot takes pressure first, then temperature
    skew.plot(df_output['press'].values, df_output['temp'].values,
              color='black', linestyle='-', linewidth=3, label='10 deg dry adiabat')
    skew.ax.set_ylim(1050, 200)
    skew.ax.set_xlim(-60, 30)
    # Add the relevant special lines
    skew.plot_dry_adiabats(linewidth=0.5)
    skew.plot_moist_adiabats(linewidth=0.5)
    #skew.plot_mixing_lines()
    skew.ax.legend()
    skew.ax.set_xlabel('Temperature (degC)', fontsize=14)
    skew.ax.set_ylabel('Pressure (hPa)', fontsize=14)
    return skew
```

```{code-cell} ipython3
skew=make_skewT()
```

```{code-cell} ipython3

```
