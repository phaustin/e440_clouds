// Converted from internal_energy_notes.tex
#set document(title: "First law of thermodynamics (Week 2)")
#set page(
  paper: "us-letter",
  margin: (top: 50pt + 30pt, bottom: 1in, x: 20mm),
  header: context [
    First law of thermodynamics (Week 2)
    #h(1fr)
    page~#counter(page).display()/#counter(page).final().first()
    #v(-6pt)
    #line(length: 100%, stroke: 0.4pt)
  ],
)
#set text(size: 12pt, font: "New Computer Modern")
#set par(justify: true, first-line-indent: (amount: 1.5em, all: true))
#set heading(numbering: "1.1")
#show heading: it => block(above: 1.4em, below: 1em, it)
#import "@preview/equate:0.3.3": equate
#show: equate.with(breakable: true, sub-numbering: true)
#set math.equation(numbering: "(1a)", supplement: none)
#show ref: it => {
  let el = it.element
  if el != none and el.func() == heading { link(el.location(), numbering(el.numbering, ..counter(heading).at(el.location()))) } else { it }
}
#show link: set text(fill: rgb("#1a4f9c"))
#show quote.where(block: true): set pad(x: 2em)

// đ: inexact differential (LaTeX \dbar)
#let dbar = math.class("normal", text(style: "italic")[đ])


#strong[Here are some comments on the material in Thompkins Chapter 1]

= Conservation of energy

Adrian Thompkins (eq. 1.9) writes the first law as:

$ d u = dbar q - dbar w $ <eq:firstwh>

(although the bar notation isn't used by AT, it's more informative, since
the $dbar$ symbol indicates that only the variable $u$ can actually have
a differential. To understand why, it helps to think of the internal energy,
which is a state variable (i.e. and instantaneous function of the system) as
a _noun_ and _heating_ and _working_ as _verbs_.
You can't take derivative of heating and working because they are processes,
not variables. You can, however, ask how much energy heating and working
contribute to the system over a very short time interval, and write
that contributions as $dbar q = q_t d t$ and $dbar w = w_t d t$, where
$q_t$ and $w_t$ are the _heating_ and _working_ rates, with
units of $"J" thin "kg"^(-1) "s"^(-1)$.

When in doubt, you can do any thermodynamic derivation in terms of
derivative instead of differentials, and write:

$ (d u)/(d t) = q_t - w_t $ <eq:first>

or alternatively:

$ d u = q_t d t - w_t d t $ <eq:firstb>

Note that $q_t$ and $w_t$ have the units of a rate (J/kg/s), and are functions.
Below, I'll use differentials to derive $c_v$ (see eq. (@eq:cv3)) and derivatives to derive $c_p$
(equation (@eq:hcp) following Bohren and Albecht),
so you can see the difference in approach.

Some definitions

#quote(block: true)[
  _$q_t$ is the rate of change of internal energy of the system as a consequence of
  a temperature difference between it and its surroundings_
]

#par(first-line-indent: 0em)[
and $w_t thick ("J" thin "kg" thin "s"^(-1))$ is the _working rate_:
]

#quote(block: true)[
  _rate of change of internal energy of the system as a consequence of
  of a force exerted through a distance (positive if work done by the system_
]

#par(first-line-indent: 0em)[
and in another text, ($Q thick ("J")$) similarly is defined as:
]

#quote(block: true)[
  _... any spontaneous flow of energy from one object to another caused by a difference
  in temperature between objects_
]

Again note the use of flow -- this is a process, not a quantity.

#par(first-line-indent: 0em)[
and work is also defined as a process or flow ($W thin ("J")$):
]

#quote(block: true)[
  _... any other transfer of energy into or out of the system.
  You do work on a system whenever you push on a piston, stir a cup
  of coffee, or run current through a resistor._
]

*Spoiler alert:* If the above seems a little fuzzy, you can
look up the statistical mechanics
definition of heat and work. Bottom line is
that heat is energy transfer between systems with no change to their
energy levels (just changes to the number distribution of particles
among those energy levels), where work involves some external change
to the systems that does affect the value of the energy levels
available to the the system.

= Heat capacity <sec:heat-capacity>

For the ideal gas discussed in the Day 2 temperature reading, we know that
with 3 translational ($1/2 m v_x^2 + 1/2 m v_y^2 + 1/2 m v_z^2$)
#link("http://en.wikipedia.org/wiki/Degrees_of_freedom_%28physics_and_chemistry%29")[degrees of freedom]
a monotomic or diatomic ideal gas has kinetic energy:

$ u_"monotomic" thick ("J" thin "kg"^(-1)) = "# of molecules/kg" times chevron.l "KE" chevron.r
  = N_A/M_d 3 (k T)/2 $ <eq:Umono>

where $M_d$ is the mean molecular weight of air as before, and we have
divided by $M_d$ to get the _specific internal energy, $u$ $"J" thin "kg"^(-1)$_.

A diatomic gas has additional vibrational and
rotational energy. There are two rotational degrees of freedom
($1/2 I_1 omega_1^2 + 1/2 I_2 omega_2^2$) (since
rotation about the molecular axis has such a small moment of inertia
($I_3$) that it doesn't contribute significant energy) and two
vibrational degrees of freedom (vibrational kinetic $1/2 m
1/4 ((d l)/(d t))^2$ and potential energy
$1/2 k (l - l_0)^2$ (see
#link("http://en.wikipedia.org/wiki/Equipartition_theorem")[this Wikipedia discussion]).

As the
web page at #link("http://en.wikipedia.org/wiki/Heat_capacity")[http://en.wikipedia.org/wiki/Heat_capacity] points out, for light
molecules like $N_2$ the vibrational energy is suppressed
(_frozen out_) at terrestrial temperatures because there is a
big jump to the first vibrational energy level for light molecules.
That leaves just the two rotational modes, contributing $2 times
N_A/M_d 1/2 k T$ so that the total energy for an
$N_2$ $O_2$ gas mixture in thermodynamic equilibrium is

$ u_"diatomic" thick ("J" thin "kg"^(-1)) = N_A/M_d 5 (k T)/2 = c_v T $ <eq:Udiam>

Plugging in
$N_A k = R^* = 8314 thick "J" thin "kg"^(-1) thin "K"^(-1)$, and $M_d = 28.97 thick "kg" thin "kmol"^(-1)$ I get
$c_v = 717 thick "J" thin "kg"^(-1) thin "K"^(-1)$, which agrees with the usual tabulated value.
Also, take a look a this this link (scroll down to
#link("http://en.wikipedia.org/wiki/Equipartition_theorem")[(Figure 4)]).

For dry air at 300 K I get $U = 717 times 300 = 2.15 times 10^5 thick "J" thin "kg"^(-1)$. This is about
the same energy possessed by a 1 kg weight moving at $656 thick "km" thin "hr"^(-1)$.

== First pass: deriving $c_v$ using differentials <sec:first-pass>

The constant $c_v$ in (@eq:Udiam) is is the heat capacity at constant volume.
To see how this is related to the first law and the state variables $rho$, T and p,
write the work done in time $d t$ as $w d t = p d v$, where
$v$ is the _specific volume_ (i.e. $1\/rho$), then (@eq:firstb)
becomes

$ q_t d t = d u + p d v $ <eq:cv1>

Switching to finite differences and assuming constant volume ($d v = 0$):

$ (q_t Delta t)/(Delta T) = (Delta u)/(Delta T) $ <eq:cv2>

and taking the limit as $Delta t, Delta T -> 0$

$ c_v = (partial u)/(partial T) $ <eq:cv3>

which is Thompkins 1.20

(_why the partial derivative?_). In words, $c_v$ is the amount of energy
required to raise the temperature of the gas by unit temperature, given
fixed volume.

Two subtle but important points:

+ $c_v$ is not a function of volume for an ideal gas,
  i.e.:

  $ (partial^2 u)/(partial v partial T) = 0 $ <eq:cv4>

+ From (@eq:Udiam) it's clear that $u$ depends only on temperature, so we can
  change the partial to a total derivative in (@eq:cv3) and write

  $ c_v = (d u)/(d T) $ <eq:cv5>

  or:

  $ u = c_v T $ <eq:cv6>

  which (to repeat) is true no matter whether the volume is changing or not.

= enthalpy

It's not often that we get to work with constant volume situations in
the atmosphere so $u$ is not conserved even when $q = 0$. Also the
specific volume $v$ is comparatively hard to measure.
More useful than the internal energy in atmospheric thermodynamics is
the _specific enthalpy_, $h thick ("J" thin "kg"^(-1))$, defined as:

$ h = u + p v $ <eq:enthalpy>

Note that the $p v$ term in (@eq:enthalpy) looks like pressure-volume
work, and can be interpreted as the work required at constant pressure $p$
to make room for the system with internal energy $u$ (Schroeder p.~149).

Using $h$ we can rewrite the first law ($d u \/ d t = q_t - p d v \/ d t$) as

$ (d h)/(d t) = q_t + v (d p)/(d t) $ <eq:entba>

This is Thompkins eq. 1.25

Taking $d p \/ d t = 0$ in (@eq:entba), we can say that the heating rate
$q_t$ is equal to the time rate of change of enthalpy at constant
pressure. Since evaporation and condensation occur at constant
pressure we will find $h$ useful when we deal with phase change.

Now expand $h$ in $p, T$ using calculus:

$ (d h)/(d t) = (partial h)/(partial T) (d T)/(d t) +
                (partial h)/(partial p) (d p)/(d t) $ <eq:Hchain>

and substitute (@eq:Hchain) into (@eq:entba) to get:

$ q_t = (partial h)/(partial T) (d T)/(d t) + ((partial h)/(partial p) - v) (d p)/(d t) $ <eq:firstH>

== Second pass: deriving $c_p$ using derivatives <sec:second-pass>

If the pressure is constant, then $d p \/ d t = 0$, and (@eq:firstH)
produces the definition of the _heat capacity at constant
pressure_:

$ q_t = c_p (partial T)/(partial t) thick "at constant pressure" $ <eq:hcp>

#par(first-line-indent: 0em)[where:]

$ c_p = (partial h)/(partial T) $

Which is Thompkins eq. 1.27.

If you don't like the hand-waving limits I took to get $c_v$ in terms of $u$
in Section @sec:heat-capacity, equation (@eq:cv2) above, you can redo it in the
same way as in (@eq:firstH) to get:

$ q_t = (partial u)/(partial T) (d T)/(d t) + ((partial u)/(partial v) + p) (d v)/(d t) $ <eq:firstU>

and taking constant volume ($d v \/ d t = 0$):

$ c_v &= (partial u)/(partial T) \
  q_t &= c_v (partial T)/(partial t) thick "at constant volume" $ <eq:ucv>

This derivation is a little longer than the one in Thompkins, but it doesn't rely on any
confusing combinations state variables and processes like this one in Thompkins eq. 1.17:

$ c_p = ((partial q)/(partial T))_P $ <eq:bizarre>

which tend to make mathematicians queasy, given what we've already said about $dbar q$ not being a perfect differential.

== Gibbs phase rule <sec:gibbs-phase-rule>

In the same way note from the definition of $h$ in (@eq:enthalpy) that it
also depends only on temperature for an ideal gas (_why?_).
We can also show that $c_p$ is roughly independent of temperature (and
pressure) so (@eq:hcp) can be integrated to obtain:

$ h approx c_p T $

How are $c_v$ and $c_p$ related? Recall the first law

$ q_t thin d t = d u + w d t $

and substituting in pressure work:

$ q_t thin d t = d u + p d v = c_v d T + p d v = c_v + d(p v) - v d p $

But also note that the intensive form of the ideal gas law is:

$ p v = R_d T $ <eq:eqstate>

which implies

$ d(p v) = R_d d T $ <eq:deqst>

Where $R_d = 287 thick "J" thin "K"^(-1) thin "kg"^(-1)$ as before.

This means:

$ q_t thin d t &= (c_v + R_d) (d T)/(d t) - v (d p)/(d t) #label("eq:firstlaw") \
  q_t thin d t &= c_p (d T)/(d t) - v (d p)/(d t) \
  q_t thin d t &= (d h)/(d t) - v (d p)/(d t) #label("eq:firstlawc") $

which implies that

$ c_p = (c_v + R_d) $ <eq:intengas>

Can you explain physically why $c_p > c_v$? For dry air, $c_p = 1004 thick
"J" thin "kg"^(-1) thin "K"^(-1)$, while $c_v = 717 thick "J" thin "kg"^(-1) thin "K"^(-1)$.

Note that I only need two independent coordinates (e.g. $T$ and $p$)
to specify this single-phase system as long as mass is conserved.

That's because I've got five quantities ($p$, $V$, $m$, $T$ and
$rho$) and three constraints:

$ m &= "constant" #label("eq:constraints") \
  rho &= m\/V \
  p &= f(V, T) quad italic("equation of state") $

This relationship between independent parameters (_degrees of
freedom_) and the number of phases/components in the system is known
as the _Gibb's phase rule_, and we'll discuss it in more detail below.

= Static energy and potential temperature <sec:static-energy>

Once again, recall the hydrostatic equation:

$ d p = -rho g d z $ <eq:hydro>

Using (@eq:hydro) we can go back to the first law and show why
enthalpy is a very useful quantity, especially to atmospheric
modelers. Inserting (@eq:hydro) into (@eq:firstlawc) gives:

$ q_t d t = d h + g d z $ <eq:firstlawh>

If there is no heating (i.e. the process is _adiabatic_ then $q = 0$
and we can integrate (@eq:firstlawh) to get a _conservation equation_
for the _dry static energy $h_d$_:

$ s_d = h_"dry air" + g z = "constant" $ <eq:cons>

(compare Thompkins eq. 1.43, p. 13). This conservation makes $h_d$
a useful tracer, since changes to $h_d$ have come come from some
diabatic process (radiation, evaporation), and can't come from simply
lifting or sinking air.

Note also that $g z$ is just the _potential energy per
kilogram_. So as the parcel decreases or increases its altitude,
energy is moving between potential and internal, while $h_d$ is
staying the same.

We can also take (@eq:cons) apart to get an equation for the
_dry adiabatic lapse rate_:

$ c_p (d T)/(d z) &= -g #label("eq:drylapse") \
  (d T)/(d z) &= Gamma_d = -g/c_p approx -9.8 thick "K" thin "km"^(-1) $

What if we want to work with pressure instead of height? Then rewrite
(@eq:firstlawc) using the equation of state to get:

$ q_t d t = c_p d T - (R_d T)/p d p $ <eq:poten1>

(note the lack of virtual temperature -- this is for dry air).

Again, if $q = 0$,

$ c_p (d T)/T &= R_d (d p)/p #label("eq:adiathet") \
  c_p d log T &= R_d d log p #label("eq:adiathetb") $

Integrating both sides of (@eq:adiathetb) from the
surface, with (temperature, pressure) given by $(theta, p_0)$
to a lower pressure $p$ and lower (why?) temperature $T$
gives _Poisson's equation_ (Thompkins 1.37):

$ c_p/R_d log(T/theta) = log(p/p_0) $ <eq:poisson>

Equation (@eq:poisson) defines the _potential temperature_, $theta$
which is conserved for adiabatic ascent/descent:

$ theta = T (p_0/p)^(R_d\/c_p) =
  T (p_0/p)^((c_p - c_v)\/c_p) =
  T (p_0/p)^((gamma - 1)/gamma) $ <eq:pottemp>

where $gamma = c_p \/ c_v$. Like $s_d$, $theta$ is constant for a dry adiabatic process.

Problem: show in the same way as the above that another conservation
relation exists for the specific volume, i.e.:

$ p v^gamma = "constant" $ <eq:specvol>

for adiabatic processes.
