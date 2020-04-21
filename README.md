# Simulation-of-diffraction-effects-in-ultrasound

In this repository, simulations focused on analyzing diffraction effects are carried out using the k-Wave toolbox in MATLAB.

To run the scripts k-Wave toolbox needs to be installed, all information can be found at http://www.k-wave.org/ 
k-Wave is an open source acoustic toolbox for use in MATLAB and C++. It uses the k-space pseudospectral method and solves an extended version of the first-order continuum equations. It introduces replacement expressions for the temporal derivative, obtained by comparing with exact solutions of a homogeneous
wave equation, in order to have exact numerical solutions for arbitrarily large time-steps. The toolbox enables to compute simulations in 1-D, 2-D, and 3-D, modeling pressure sources and allowing to setup arbitrary detection areas to record acoustic pressure, particle velocity,
and acoustic intensity.

The cases set up as examples simulate diffraction through a small slit in a wall-like geometry. This is a standard example for diffraction which can be difficult to model especially when the slit width approaches the size of the wavelength.
Two cases are simulated, one in which the slit is larger, the second with a width comparable to the wavelength in which a more tricky to model behaviour of the waves comes into play. The result is analyzed on a 2-dimensional plane.

