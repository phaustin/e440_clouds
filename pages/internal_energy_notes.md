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

**Here are some comments on the material in Thompkins Chapter 1**

(sec-conservation)=
## Conservation of energy

Adrian Thompkins (eq. 1.9) writes the first law as:

```{math}
:label: eq-firstwh
du = \dbar q - \dbar w
```

(although the bar notation isn't used by AT, it's more informative, since
the $\dbar$ symbol indicates that only the variable $u$ can actually have
a differential. To understand why, it helps to think of the internal energy,
which is a state variable (i.e. and instantaneous function of the system) as
a *noun* and *heating* and *working* as *verbs*.
You can't take derivative of heating and working because they are processes,
not variables. You can, however, ask how much energy heating and working
contribute to the system over a very short time interval, and write
that contributions as $\dbar q = q_t dt$ and $\dbar w = w_t dt$, where
$q_t$ and $w_t$ are the *heating* and *working* rates, with
units of $\un{J\,kg^{-1} s^{-1}}$.

When in doubt, you can do any thermodynamic derivation in terms of
derivative instead of differentials, and write:

```{math}
:label: eq-first
\frac{du}{dt} = q_t - w_t
```

or alternatively:

```{math}
:label: eq-firstb
du = q_t dt - w_t dt
```

Note that $q_t$ and $w_t$ have the units of a rate (J/kg/s), and are functions.
Below, I'll use differentials to derive $c_v$ (see eq. {eq}`eq-cv3`) and derivatives to derive $c_p$
(equation {eq}`eq-hcp` following Bohren and Albecht),
so you can see the difference in approach.

Some definitions

> *$q_t$ is the rate of change of internal energy of the system as a consequence of
> a temperature difference between it and its surroundings*

and $w_t\ (\un{J\,kg\,s^{-1}})$ is the *working rate*:

> *rate of change of internal energy of the system as a consequence of
> of a force exerted through a distance (positive if work done by the system*

and in another text, ($Q\ (\un{J})$) similarly is defined as:

> *... any spontaneous flow of energy from one object to another caused by a difference
> in temperature between objects*

Again note the use of flow -- this is a process, not a quantity.

and work is also defined as a process or flow ($W\, (\un{J})$):

> *... any other transfer of energy into or out of the system.
> You do work on a system whenever you push on a piston, stir a cup
> of coffee, or run current through a resistor.*

**Spoiler alert:** If the above seems a little fuzzy, you can
look up the statistical mechanics
definition of heat and work. Bottom line is
that heat is energy transfer between systems with no change to their
energy levels (just changes to the number distribution of particles
among those energy levels), where work involves some external change
to the systems that does affect the value of the energy levels
available to the the system.

(sec-heat-capacity)=
## Heat capacity

For the ideal gas discussed in the Day 2 temperature reading, we know that
with 3 translational ($\frac{1}{2}mv_x^2 + \frac{1}{2}mv_y^2 + \frac{1}{2}mv_z^2$)
[degrees of freedom](http://en.wikipedia.org/wiki/Degrees_of_freedom_%28physics_and_chemistry%29)
a monotomic or diatomic ideal gas has kinetic energy:

```{math}
:label: eq-Umono
u_{monotomic}\ (\un{J\,kg^{-1}}) = \#\ \text{of molecules/kg} \times \left\langle KE \right\rangle
= \frac{N_A}{M_d} 3 \frac{k T}{2}
```

where $M_d$ is the mean molecular weight of air as before, and we have
divided by $M_d$ to get the *specific internal energy, $u$ $\un{J\,kg^{-1}}$*.

A diatomic gas has additional vibrational and
rotational energy. There are two rotational degrees of freedom
($\frac{1}{2} I_1 \omega_1^2 + \frac{1}{2} I_2 \omega_2^2$) (since
rotation about the molecular axis has such a small moment of inertia
($I_3$) that it doesn't contribute significant energy) and two
vibrational degrees of freedom (vibrational kinetic $\frac{1}{2} m
\frac{1}{4} \left( \frac{dl}{dt} \right)^2$ and potential energy
$\frac{1}{2}k (l - l_0)^2$ (see
[this Wikipedia discussion](http://en.wikipedia.org/wiki/Equipartition_theorem)).

As the web page at <http://en.wikipedia.org/wiki/Heat_capacity> points out, for light
molecules like $N_2$ the vibrational energy is suppressed
(*frozen out*) at terrestrial temperatures because there is a
big jump to the first vibrational energy level for light molecules.
That leaves just the two rotational modes, contributing $2 \times
\frac{N_A}{M_d} \frac{1}{2} k T$ so that the total energy for an
$N_2$ $O_2$ gas mixture in thermodynamic equilibrium is

```{math}
:label: eq-Udiam
u_{diatomic}\ (\un{J\,kg^{-1}}) = \frac{N_A}{M_d} 5 \frac{k T}{2} = c_v T
```

Plugging in
$N_A k = R^* = 8314\ \un{J\,kg^{-1}\,K^{-1}}$, and $M_d = 28.97\ \un{kg\,kmol^{-1}}$ I get
$c_v = 717\ \un{J\,kg^{-1}\,K^{-1}}$, which agrees with the usual tabulated value.
Also, take a look a this this link (scroll down to
[(Figure 4)](http://en.wikipedia.org/wiki/Equipartition_theorem)).

For dry air at 300 K I get $U = 717 \times 300 = 2.15 \times 10^5\ \un{J\,kg^{-1}}$. This is about
the same energy possessed by a 1 kg weight moving at $656\ \un{km\,hr^{-1}}$.

(sec-first-pass)=
### First pass: deriving $c_v$ using differentials

The constant $c_v$ in {eq}`eq-Udiam` is is the heat capacity at constant volume.
To see how this is related to the first law and the state variables $\rho$, T and p,
write the work done in time $dt$ as $w dt = p dv$, where
$v$ is the *specific volume* (i.e. $1/\rho$), then {eq}`eq-firstb`
becomes

```{math}
:label: eq-cv1
q_t dt = du + p dv
```

Switching to finite differences and assuming constant volume ($dv = 0$):

```{math}
:label: eq-cv2
\frac{q_t \Delta t}{\Delta T} = \frac{\Delta u}{\Delta T}
```

and taking the limit as $\Delta t, \Delta T \rightarrow 0$

```{math}
:label: eq-cv3
c_v = \frac{\partial u}{\partial T}
```

which is Thompkins 1.20

(*why the partial derivative?*). In words, $c_v$ is the amount of energy
required to raise the temperature of the gas by unit temperature, given
fixed volume.

Two subtle but important points:

1. $c_v$ is not a function of volume for an ideal gas,
   i.e.:

   ```{math}
   :label: eq-cv4
   \frac{\partial^2 u}{\partial v \partial T} = 0
   ```

2. From {eq}`eq-Udiam` it's clear that $u$ depends only on temperature, so we can
   change the partial to a total derivative in {eq}`eq-cv3` and write

   ```{math}
   :label: eq-cv5
   c_v = \frac{du}{dT}
   ```

   or:

   ```{math}
   :label: eq-cv6
   u = c_v T
   ```

   which (to repeat) is true no matter whether the volume is changing or not.

(sec-enthalpy)=
## enthalpy

It's not often that we get to work with constant volume situations in
the atmosphere so $u$ is not conserved even when $q = 0$. Also the
specific volume $v$ is comparatively hard to measure.
More useful than the internal energy in atmospheric thermodynamics is
the *specific enthalpy*, $h\ (\un{J\,kg^{-1}})$, defined as:

```{math}
:label: eq-enthalpy
h = u + pv
```

Note that the $p v$ term in {eq}`eq-enthalpy` looks like pressure-volume
work, and can be interpreted as the work required at constant pressure $p$
to make room for the system with internal energy $u$ (Schroeder p. 149).

Using $h$ we can rewrite the first law ($du/dt = q_t - p\, dv/dt$) as

```{math}
:label: eq-entba
\frac{dh}{dt} = q_t + v \frac{dp}{dt}
```

This is Thompkins eq. 1.25

Taking $dp/dt = 0$ in {eq}`eq-entba`, we can say that the heating rate
$q_t$ is equal to the time rate of change of enthalpy at constant
pressure. Since evaporation and condensation occur at constant
pressure we will find $h$ useful when we deal with phase change.

Now expand $h$ in $p, T$ using calculus:

```{math}
:label: eq-Hchain
\frac{dh}{dt} = \frac{\partial h}{\partial T} \frac{dT}{dt} +
                \frac{\partial h}{\partial p} \frac{dp}{dt}
```

and substitute {eq}`eq-Hchain` into {eq}`eq-entba` to get:

```{math}
:label: eq-firstH
q_t = \frac{\partial h}{\partial T} \frac{dT}{dt} + \left( \frac{\partial h}{\partial p} - v \right) \frac{dp}{dt}
```

(sec-second-pass)=
### Second pass: deriving $c_p$ using derivatives

If the pressure is constant, then $dp/dt = 0$, and {eq}`eq-firstH`
produces the definition of the *heat capacity at constant
pressure*:

```{math}
:label: eq-hcp
q_t = c_p \frac{\partial T}{\partial t}\ \text{at constant pressure}
```

where:

```{math}
:label: eq-cpdef
c_p = \frac{\partial h}{\partial T}
```

Which is Thompkins eq. 1.27.

If you don't like the hand-waving limits I took to get $c_v$ in terms of $u$
in Section [](#sec-heat-capacity), equation {eq}`eq-cv2` above, you can redo it in the
same way as in {eq}`eq-firstH` to get:

```{math}
:label: eq-firstU
q_t = \frac{\partial u}{\partial T} \frac{dT}{dt} + \left( \frac{\partial u}{\partial v} + p \right) \frac{dv}{dt}
```

and taking constant volume ($dv/dt = 0$):

```{math}
:label: eq-ucv
\begin{aligned}
c_v &= \frac{\partial u}{\partial T} \\
q_t &= c_v \frac{\partial T}{\partial t}\ \text{at constant volume}
\end{aligned}
```

This derivation is a little longer than the one in Thompkins, but it doesn't rely on any
confusing combinations state variables and processes like this one in Thompkins eq. 1.17:

```{math}
:label: eq-bizarre
c_p = \left( \frac{\partial q}{\partial T} \right)_P
```

which tend to make mathematicians queasy, given what we've already said about $\dbar q$ not being a perfect differential.

(sec-gibbs-phase-rule)=
### Gibbs phase rule

In the same way note from the definition of $h$ in {eq}`eq-enthalpy` that it
also depends only on temperature for an ideal gas (*why?*).
We can also show that $c_p$ is roughly independent of temperature (and
pressure) so {eq}`eq-hcp` can be integrated to obtain:

```{math}
:label: eq-hcpT
h \approx c_p T
```

How are $c_v$ and $c_p$ related? Recall the first law

```{math}
:label: eq-firstw
q_t\, dt = du + w\, dt
```

and substituting in pressure work:

```{math}
:label: eq-firstpv
q_t\, dt = du + p dv = c_v dT + p dv = c_v + d(pv) - v dp
```

But also note that the intensive form of the ideal gas law is:

```{math}
:label: eq-eqstate
p v = R_d T
```

which implies

```{math}
:label: eq-deqst
d(pv) = R_d dT
```

Where $R_d = 287\ \un{J\,K^{-1}\,kg^{-1}}$ as before.

This means:

```{math}
:label: eq-firstlaw
\begin{aligned}
q_t\, dt &= (c_v + R_d) \frac{dT}{dt} - v \frac{dp}{dt} \\
q_t\, dt &= c_p \frac{dT}{dt} - v \frac{dp}{dt} \\
q_t\, dt &= \frac{dh}{dt} - v \frac{dp}{dt}
\end{aligned}
```

which implies that

```{math}
:label: eq-intengas
c_p = (c_v + R_d)
```

Can you explain physically why $c_p > c_v$? For dry air, $c_p = 1004\
\un{J\,kg^{-1}\,K^{-1}}$, while $c_v = 717\ \un{J\,kg^{-1}\,K^{-1}}$.

Note that I only need two independent coordinates (e.g. $T$ and $p$)
to specify this single-phase system as long as mass is conserved.

That's because I've got five quantities ($p$, $V$, $m$, $T$ and
$\rho$) and three constraints:

```{math}
:label: eq-constraints
\begin{aligned}
m &= \text{constant} \\
\rho &= m/V \\
p &= f(V,T)\quad \textit{equation of state}
\end{aligned}
```

This relationship between independent parameters (*degrees of
freedom*) and the number of phases/components in the system is known
as the *Gibb's phase rule*, and we'll discuss it in more detail below.

(sec-static-energy)=
## Static energy and potential temperature

Once again, recall the hydrostatic equation:

```{math}
:label: eq-hydro
dp = -\rho g dz
```

Using {eq}`eq-hydro` we can go back to the first law and show why
enthalpy is a very useful quantity, especially to atmospheric
modelers. Inserting {eq}`eq-hydro` into the last line of {eq}`eq-firstlaw` gives:

```{math}
:label: eq-firstlawh
q_t dt = dh + g dz
```

If there is no heating (i.e. the process is *adiabatic*) then $q = 0$
and we can integrate {eq}`eq-firstlawh` to get a *conservation equation*
for the *dry static energy $h_d$*:

```{math}
:label: eq-cons
s_d = h_{dry\ air} + gz = \text{constant}
```

(compare Thompkins eq. 1.43, p. 13). This conservation makes $h_d$
a useful tracer, since changes to $h_d$ have come come from some
diabatic process (radiation, evaporation), and can't come from simply
lifting or sinking air.

Note also that $gz$ is just the *potential energy per
kilogram*. So as the parcel decreases or increases its altitude,
energy is moving between potential and internal, while $h_d$ is
staying the same.

We can also take {eq}`eq-cons` apart to get an equation for the
*dry adiabatic lapse rate*:

```{math}
:label: eq-drylapse
\begin{aligned}
c_p \frac{dT}{dz} &= -g \\
\frac{dT}{dz} &= \Gamma_d = -\frac{g}{c_p} \approx -9.8\ \un{K\,km^{-1}}
\end{aligned}
```

What if we want to work with pressure instead of height? Then rewrite
the last line of {eq}`eq-firstlaw` using the equation of state to get:

```{math}
:label: eq-poten1
q_t dt = c_p dT - \frac{R_d T}{p} dp
```

(note the lack of virtual temperature -- this is for dry air).

Again, if $q = 0$,

```{math}
:label: eq-adiathet
\begin{aligned}
c_p \frac{dT}{T} &= R_d \frac{dp}{p} \\
c_p\, d\log T &= R_d\, d\log p
\end{aligned}
```

Integrating both sides of the second line of {eq}`eq-adiathet` from the
surface, with (temperature, pressure) given by $(\theta, p_0)$
to a lower pressure $p$ and lower (why?) temperature $T$
gives *Poisson's equation* (Thompkins 1.37):

```{math}
:label: eq-poisson
\frac{c_p}{R_d} \log \left( \frac{T}{\theta} \right) = \log \left( \frac{p}{p_0} \right)
```

Equation {eq}`eq-poisson` defines the *potential temperature*, $\theta$
which is conserved for adiabatic ascent/descent:

```{math}
:label: eq-pottemp
\theta = T \left( \frac{p_0}{p} \right)^{R_d/c_p} =
T \left( \frac{p_0}{p} \right)^{(c_p - c_v)/c_p} =
T \left( \frac{p_0}{p} \right)^{\frac{\gamma - 1}{\gamma}}
```

where $\gamma = c_p/c_v$. Like $s_d$, $\theta$ is constant for a dry adiabatic process.

Problem: show in the same way as the above that another conservation
relation exists for the specific volume, i.e.:

```{math}
:label: eq-specvol
p v^\gamma = \text{constant}
```

for adiabatic processes.
