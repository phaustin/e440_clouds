"""
Saturation vapor pressure (Bolton 1980 form) and its analytic temperature
derivative, derived with sympy:

    e_s(T) = 6.112 exp(17.67 T / (T + 243.5))

    de_s/dT = e_s(T) * 17.67 * 243.5 / (T + 243.5)**2

T is in degrees Celsius, e_s in hPa, de_s/dT in hPa/K.
"""

import numpy as np

A = 6.112  # hPa
B = 17.67
C = 243.5  # deg C


def esat(T):
    """Saturation vapor pressure (hPa) over liquid water, T in deg C."""
    return A * np.exp(B * T / (T + C))


def desdT(T):
    """Analytic derivative de_s/dT (hPa/K), T in deg C.

    Equivalent sympy form:
        328722078*exp(1767*T/(100*T + 24350)) / (3125*(2*T + 487)**2)
    """
    return A * B * C / (T + C) ** 2 * np.exp(B * T / (T + C))


if __name__ == "__main__":
    T = 20.0
    print(f"e_s({T}) = {esat(T):.4f} hPa")
    print(f"de_s/dT({T}) = {desdT(T):.4f} hPa/K")
    # finite-difference check
    h = 1.0e-4
    fd = (esat(T + h) - esat(T - h)) / (2 * h)
    print(f"finite difference = {fd:.4f} hPa/K")
