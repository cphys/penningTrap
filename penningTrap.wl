(* ::Package:: *)

BeginPackage["penningTrap`"];
 
penningTrapWaveFunction::usage
  "penningTrapWaveFunction[n, l, k]
      A function giving the radial wave function for the
      penning trap atom.
      inputs:
      n:    (int) cyclotron quantum number
      l:    (int) magnetron quantum number
      k:    (int) axial quantum number";
      
      
NpenningTrapWaveFunction::usage
  "NpenningTrapWaveFunction[n, l, k, x, y, z]
      A function giving the radial wave function for the
      penning trap atom.
      inputs:
      n:    (int) cyclotron quantum number
      l:    (int) magnetron quantum number
      k:    (int) axial quantum number
      x:    (float) x-position in meters
      y:    (float) y-position in meters
      z:    (float) z-position in meters";
      
      
 \[HBar]::usage (* Plank's Constant *);
 m::usage (* Plank's Constant *); 
 \[Rho]y::usage (* y coordinate *);
 z::usage (* z coordinate *);
 \[Rho]x::usage (* x coordinate *);
 \[Omega]c::usage (* cyclotron frequency *);
 \[Omega]z::usage (* axial frequency *);
 \[Alpha]c::usage (* \[Alpha]c *);


Begin["`Private`"]

penningTrapWaveFunction[
  nNumb_,
  lNumb_,
  kNumb_,
  OptionsPattern[{
    hbar -> \[HBar],
    mass -> m,
    xVal -> \[Rho]x,
    yVal -> \[Rho]y,
    zVal -> z,
    omegac -> \[Omega]c,
    omegaz -> \[Omega]z,
    alphac -> \[Alpha]c}]] :=
 Module[{
   \[Psi], \[HBar], pz , m , Vxp ,
   Vyp , Vxm , Vym ,
   z , \[Rho]x , \[Rho]y ,
   \[Rho]dotx , \[Rho]doty ,
   Vzp , Vzm ,
   \[Omega]z , \[Omega]c, \[Omega]p , \[Omega]m , \[Alpha]c,
   a,
   \[Rho]Val , VpVal , VmVal ,
   azOp , azdOp ,
   VxpOp, VxmOp, VypOp, VymOp,
   apOp, amOp, apdOp , amdOp ,
   coeff, assums, pSubs,
   \[Psi]o1, norm, \[Psi]o,
   n = nNumb,
   l = lNumb,
   k = kNumb,
   hb = OptionValue[hbar],
   mV = OptionValue[mass],
   xv = OptionValue[xVal],
   yv = OptionValue[yVal],
   zv = OptionValue[zVal],
   \[Omega]cV = OptionValue[omegac],
   \[Omega]zV = OptionValue[omegaz],
   \[Alpha]cV = OptionValue[alphac]},
  
  assums = {
    pz > 0, \[Omega]z > 0, m > 0, \[HBar] > 0, Vxp > 0,
    Vyp > 0, \[Omega]p >= \[Omega]m >= 0, Vxm > 0, Vym > 0,
    n >= 0,k >= 0, l >= 0,
    \[Omega]c > 0, \[Rho]x \[Element] Reals, \[Rho]y \[Element] Reals,
    \[Rho]dotx \[Element] Reals, \[Rho]doty \[Element] Reals, 
    Vzp > 0, Vzm > 0,
    z \[Element] Reals, 
    m \[Element] Reals, \[Omega]z \[Element] Reals, 
    \[Omega]z < \[Omega]c/Sqrt[2], \[Omega]c > Sqrt[2] \[Omega]z, 
    a \[Element] Reals, Sqrt[\[Omega]c^2 - 2 \[Omega]z^2] != 0};
  
  \[Omega]p = 1/2*(\[Omega]c + Sqrt[\[Omega]c^2 - 2*\[Omega]z^2]);
  \[Omega]m = 1/2*(\[Omega]c - Sqrt[\[Omega]c^2 - 2*\[Omega]z^2]);
  
  \[Rho]Val = {\[Rho]x, \[Rho]y, 0}; 
  VpVal = {\[Rho]dotx, \[Rho]doty, 0} - Cross[{0, 0, \[Omega]m}, \[Rho]Val]; 
  VmVal = {\[Rho]dotx, \[Rho]doty, 0} - Cross[{0, 0, \[Omega]p}, \[Rho]Val];
  
  azOp = (((m*\[Omega]z)/(2*\[HBar]))^(1/2)*z*# + 
      I*(1/(2*m*\[HBar]*\[Omega]z))^(1/2)*(-I*\[HBar]) D[#, z]) &;
  
  azdOp = (((m*\[Omega]z)/(2*\[HBar]))^(1/2)*z*# - 
      I*(1/(2*m*\[HBar]*\[Omega]z))^(1/2)*(-I*\[HBar]) D[#, z]) &;
  
  VxpOp = (-(I*\[HBar])/m D[#, \[Rho]x] - 
      1/2*(Sqrt[\[Omega]c^2 - 2*\[Omega]z^2])*\[Rho]y*#) &;
  
  VxmOp = (-(I*\[HBar])/m D[#, \[Rho]x] + 
      1/2*(Sqrt[\[Omega]c^2 - 2*\[Omega]z^2])*\[Rho]y*#) &;
  
  VypOp = (-(I*\[HBar])/m D[#, \[Rho]y] + 
      1/2*(Sqrt[\[Omega]c^2 - 2*\[Omega]z^2])*\[Rho]x*#) &;
  
  VymOp = (-(I*\[HBar])/m D[#, \[Rho]y] - 
      1/2*(Sqrt[\[Omega]c^2 - 2*\[Omega]z^2])*\[Rho]x*#) &;
  
  coeff = (m/(2*\[HBar] (\[Omega]p - \[Omega]m)))^(1/2);
  
  apOp = Simplify[coeff*(VxpOp[#] - I*VypOp[#])] &; 
  amOp = Simplify[coeff*(VxmOp[#] + I*VymOp[#])] &; 
  apdOp = Simplify[coeff*(VxpOp[#] + I*VypOp[#])] &; 
  amdOp = Simplify[coeff*(VxmOp[#] - I*VymOp[#])] &;
  
  \[Psi]o1 = 
   FullSimplify[
    Exp[-m/(4*\[HBar])*(\[Omega]p - \[Omega]m)*(\[Rho]x^2 + \[Rho]y^2)]
     *Exp[-(m/(2*\[HBar]))*\[Omega]z *z^2], assums];
  
  norm = Values[Flatten[
      FullSimplify[
       Solve[Assuming[assums, 
          a^2*Integrate[
            Conjugate[\[Psi]o1]*\[Psi]o1,
            {\[Rho]x, -\[Infinity],\[Infinity]},
            {\[Rho]y, -\[Infinity], \[Infinity]},
            {z,  -\[Infinity], \[Infinity]}]] == 1, a], 
       assums]]][[-1]];
  
  pSubs = {\[HBar] -> hb, m -> mV, \[Rho]x -> xv, \[Rho]y -> yv, 
    z -> zv,\[Omega]c -> \[Omega]cV, \[Omega]z -> \[Omega]zV, \[Alpha]c -> \[Alpha]cV};
  
  \[Psi]o = Simplify[norm*\[Psi]o1, assums];
  Return[Simplify[
     1/Sqrt[n!]*Nest[apdOp,
       1/Sqrt[l!]*Nest[amdOp,
         1/Sqrt[k!]*Nest[azdOp,
           \[Psi]o, k], l], n], assums] /. pSubs
   ]]
   
NpenningTrapWaveFunction[
  nNumb_,
  lNumb_,
  kNumb_,
  xMeters_,
  yMeters_,
  zMeters_,
  OptionsPattern[{
    cyclotronFrequencyHz -> 1.644`*^11,
    axialFrequencyHz -> 6.442`*^7}]] :=
  Module[{
      cM, hbeVs, freqToeV, hb, mV,
      n = nNumb,
      l = lNumb,
      k = kNumb,
      x = xMeters,
      y = yMeters,
      z = zMeters,
      vc = OptionValue[cyclotronFrequencyHz],
      vz = OptionValue[axialFrequencyHz]},
      
      hb = 1;
      mV = 1/2*10^6;
      cM = 3*10^8;
      hbeVs = 6.582119568999999`*^-16;
      freqToeV = (2*\[Pi] (#))*hbeVs &;
      
      penningTrapWaveFunction[
        n, l, k,
        xVal -> x/(hbeVs*cM),
        yVal -> y/(hbeVs*cM),
        zVal -> z/(hbeVs*cM),
        omegac -> freqToeV[vc],
        omegaz -> freqToeV[vz],
        alphac ->  Sqrt[(2* freqToeV[vc*10^9])/10^6],
        hbar -> hb,
        mass -> mV]]
   
   
End[]
EndPackage[]
