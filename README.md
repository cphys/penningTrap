# Penning Trap
Wave function plots associated with geonium theory physics [[1]](https://journals.aps.org/rmp/abstract/10.1103/RevModPhys.58.233). 

## Included Files
* penningTrap.wl -- a mathematica package containing functions related to penning trap. Package can be [installed](https://support.wolfram.com/5648?src=mathematica) and used within mathematica notebooks by including the syntax ``<<"penningTrap`"`` at the beginning of the notebook.
* penningTrapPlots.wl -- mathematica functions which use [cmTix](https://github.com/cphys/cmPackages) to create and export 3d and 2d probability density plots specific to the penning trap.
* wfScript-noLegend.wls -- a wolfram language script used to create multiple plots for use in table
* Bscript_wf.sh -- an example bash script which can be used with wfScript-noLegend.wls
* imageTable.nb -- creates and exports [table of wave functions](/data/WFTable.png)

## penningTrap Package Examples
The following calculations can be carried out by simply importing the penningTrap package at the beginning of the Mathematica notebook.

### Analytical solution to the penning trap wave function
The Analytical solution to the penning trap wavefunction can be found using the penningTrap package using the function `penningTrapWaveFunction[n,l,k]`
* `n` is the cyclotron quantum number, `l` is the magnetron quantum number, and `k` is the axial quantum number.
#### Input
```Mathematica
<< "penningTrap`"
penningTrapWaveFunction[0, 2, 2]
```
#### Output
![n=0, l=2, k=2](/data/eqns/n0_l2_k2.png)

### Numerical solution to the penning trap wave function
The Numerical solution to the penning trap wavefunction can be found using the penningTrap package using the function `NpenningTrapWaveFunction[n,l,k,x,y,z]`
* `n` is the cyclotron quantum number, `l` is the magnetron quantum number, `k` is the axial quantum number, `x`, `y`, `z` are spacial coordinates in meters.
#### Input
```Mathematica
<< "penningTrap`"
NpenningTrapWaveFunction[0, 2, 2, 7*10^-8, 7*10^-8, 2.25*10^-6]
```
#### Output
```Mathematica
-3.48378*10^-27 + 2.22314*10^-10 I
```
### 3D plots
3d plots of a penning trap orbital can be easily created using the either of the above functions within Mathematica's built in [DensityPlot3D](https://reference.wolfram.com/language/ref/DensityPlot3D.html) function.

The included [penningTrapPlots.wl](https://github.com/cphys/penningTrap/blob/main/penningTrapPlots.wl) shows how [cmTix](https://github.com/cphys/cmPackages) package can be used to create better looking plots.

The following plots can be used by calling `plot3d[n,l,k]` within penningTrapPlots.wl
* `n` is the cyclotron quantum number, `l` is the magnetron quantum number, and `k` is the axial quantum number.
* In the below plots the wave function is defined ψ<sub>klns</sub> where s is the spin quantum number.
* Currently the package is written only for spin 1/2 particles (s=1), but this may be expanded in the future.

#### Input
```Mathematica
plot3d[0,2,2]
```

#### Output
![n=0, l=2, k=2](/data/figs3d/vc164.4GHz_vz64.42MHz/n0_l2_k2.png)

#### Input
```Mathematica
plot3d[1,2,2]
```

#### Output
![n=1, l=2, k=2](/data/figs3d/vc164.4GHz_vz64.42MHz/n1_l2_k2.png)

#### Input
```Mathematica
plot3d[0,2,5]
```

#### Output
![n=0, l=2, k=5](/data/figs3d/vc164.4GHz_vz64.42MHz/n0_l2_k5.png)

#### Input
```Mathematica
plot3d[1,2,5]
```
![n=1, l=2, k=5](/data/figs3d/vc164.4GHz_vz64.42MHz/n1_l2_k5.png)

### 2D plots
Here again 2D plots of a penning trap orbital can be easily created wrapping functions from the `penningTrap.wl` package within Mathematica's built in [DensityPlot2D](https://reference.wolfram.com/language/ref/DensityPlot2D.html) function, but we again use [cmTix](https://github.com/cphys/cmPackages) package to create better looking plots.

The following plots can be used by calling `plot2d[n,l,k]` within penningTrapPlots.wl
* `n` is the cyclotron quantum number, `l` is the magnetron quantum number, and `k` is the axial quantum number.
* In the below plots the wave function is defined ψ<sub>klns</sub> where s is the spin quantum number.
* Currently the package is written only for spin 1/2 particles (s=1), but this may be expanded in the future.
#### Input
```Mathematica
plot2d[0,2,2]
```

#### Output
![n=0, l=2, k=2](/data/figs2d/vc164.4GHz_vz64.42MHz/n0_l2_k2.png)

#### Input
```Mathematica
plot2d[1,2,2]
```

#### Output
![n=1, l=2, k=2](/data/figs2d/vc164.4GHz_vz64.42MHz/n1_l2_k2.png)

### Wave Function Table
A table of wave functions can be created using [imageTable.nb](https://github.com/cphys/penningTrap/blob/main/imageTable.nb).

We pre calculate probability plots by calling [wfScript-noLegend.wls](https://github.com/cphys/penningTrap/blob/main/wfScript-noLegend.wls) from the command line using the following notation
```
./wfScript-noLegend.wls n l k
```
* `n` is the cyclotron quantum number, `l` is the magnetron quantum number, and `k` is the axial quantum number.
* plots are stored in [data](https://github.com/cphys/penningTrap/tree/main/data) folder.
Plots are automatically imported and formatted into table using using [imageTable.nb](https://github.com/cphys/penningTrap/blob/main/imageTable.nb).

![Penning Trap Wave Functions](/data/WFTable.png)

## External References
[Brown, Lowell S., and Gerald Gabrielse.](https://journals.aps.org/rmp/abstract/10.1103/RevModPhys.58.233)
"Geonium theory: Physics of a single electron or ion in a Penning trap."
Reviews of Modern Physics 58, no. 1 (1986): 233.

## Potential Improvements
* Expand package for use with various spin values
* Unite with [atomic orbitals](https://github.com/cphys/atomicOrbitals) project to create a package for visualizing general wave functions. This is nearly done already, but maybe should be organized into it's own repository/module.
* It may be better to use DensityPlot3D rather than ListDensityPlot3D within cmTix plotting functions.
* parallelization was removed, maybe experiment with putting it back into cmTix function.
