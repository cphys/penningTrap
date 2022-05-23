# Penning Trap
## Included files
* penningTrap.wl -- a mathematica package containing functions related to penning trap.
* penningTrapPlots.wl -- mathematica functions which use [cmTix](https://github.com/cphys/cmPackages) to create and export 3d and 2d probability density plots specific to the penning trap.


## Example outputs

#### Input

* The Analytical solution to the penning trap wavefunction can be found using the penningTrap package using the unction `penningTrapWaveFunction[n,l,k]`

```Mathematica
<< "penningTrap`"
penningTrapWaveFunction[0, 2, 2]
```
#### Output
![n=0, l=2, k=2](/data/eqns/n0_l2_k2.png)

#### Input

* The Numerical solution to the penning trap wavefunction can be found using the penningTrap package using the unction `NpenningTrapWaveFunction[n,l,k,x,y,z]`

```Mathematica
<< "penningTrap`"
NpenningTrapWaveFunction[0, 2, 2, 7*10^-8, 7*10^-8, 2.25*10^-6]
```
#### Output
```Mathematica
-3.48378*10^-27 + 2.22314*10^-10 I
```

* A 3d plot of a penning trap orbital can be created using `plot3d[n,l,k]`

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
