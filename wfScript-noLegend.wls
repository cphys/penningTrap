#!/usr/bin/env wolframscript
(* ::Package:: *)

ClearAll["Global`*"]

<< "penningTrap`"
<< "cmTix`"
(*ParallelNeeds["cmTix`"]
ParallelNeeds["penningTrap`"]*)

nVar = ToExpression[$ScriptCommandLine[[2]]];
lVar = ToExpression[$ScriptCommandLine[[3]]];
kVar = ToExpression[$ScriptCommandLine[[4]]];

xmmin = 7*10^-8;
ymmin = xmmin;
zmmin = 2.25*10^-6;

(* numerical evaluation of penning trap wave function *)
WF[n_, l_, k_, xv_, yv_, zv_] := 
 WF[n, l, k, xv, yv, zv] = 
  NpenningTrapWaveFunction[n, l, k, xv, yv, zv]
  
plotWaveFunctionP[n_, l_, k_] :=
 cmDensityPlot3D[
  Evaluate[WF[n, l, k, xx, yy, zz]],
  {xx, -xmmin, xmmin},
  {yy, -ymmin, ymmin},
  {zz, -zmmin, zmmin},
    colorFunction -> "AvocadoColors",
         plotTheme -> "Scientific",
  background -> RGBColor["#eee8d5"],
  plotPoints -> {75, 75, 50},
  colorFunctionScaling -> False,
  plotLegends -> None,
  imageSize -> 500,
  boxed -> False,
  axes -> False];
  
exportPlot[n_, l_, k_] := 
    Export[
     FileNameJoin[{Directory[], 
       "data", 
       "figs",
       "n" <> ToString[n] <> "_l" <> ToString[l] <> "_k" <> 
            ToString[k] <> ".pdf"}],
            plotWaveFunctionP[n, l, k],
         ImagePadding -> None];

exportPlot[nVar,lVar,kVar];

CloseKernels[] 
Exit[]
