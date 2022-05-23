(* ::Package:: *)

ClearAll["Global`*"]

<< "penningTrap`"
<< "cmTix`"
ParallelNeeds["cmTix`"]
ParallelNeeds["penningTrap`"]

(* bohr radius in meters *)
aoM = 5.2917699999999994`*^-11;
(* cyclotron frequency in GHz *)
vc = 164.4;
(* axial frequency in GHz *)
vz = 64.42;

(* numerical evaluation of penning trap wave function *)
WF[n_, l_, k_, xv_, yv_, zv_] := 
 WF[n, l, k, xv, yv, zv] = 
  NpenningTrapWaveFunction[n, l, k, xv, yv, zv]
  
(* A function for adding text labels to plots *)
txtLab[txt_, pos_] :=
 Graphics[
  Text[Style[
    txt,
    FontFamily -> "TeX Gyre Heros",
    FontSize -> 22,
    FontColor -> White],
   pos],
  ImageSize -> 1100]

(* A function for adding text labels to plots *)
legLab[n_, l_, k_] :=
 "|" <> ToString@TraditionalForm[Subscript[
     \[Psi],
     ToString[k]
      <> ToString[l]
      <> ToString[n] <> "1"]] <>  
  "\!\(\*SuperscriptBox[\(|\), \(2\)]\)  \
[\!\(\*SuperscriptBox[\(nm\), \(-3\)]\)]"

plot3d[n_, l_, k_] :=
(* 3d plot of probability wave function for pennig trap
   inputs:
      n:    (int) cyclotron quantum number
      l:    (int) magnetron quantum number
      k:    (int) axial quantum number" *)
  plotLabels3D[
   cmDensityPlot3D[
    Evaluate[WF[n, l, k, xx, yy, zz]],
    {xx, -7*10^-8, 7*10^-8},
    {yy, -7*10^-8, 7*10^-8},
    {zz, -2.25*10^-6, 2.25*10^-6},
    labelingFunction -> (ScientificForm[
        (aoM*10^9)^-3*#1, {64, 1},
        NumberPadding -> {"", "0"}] &),
    ticks -> {
      linTixScAlt[-90*10^-9, 90*10^-9, 30*10^-9, 10^9, 1][[1]],
      linTixScAlt[-90*10^-9, 90*10^-9, 30*10^-9, 10^9, 1][[1]],
      linTixScAlt[-2*10^-6, 2*10^-6, 1*10^-6, 10^6, 1][[1]]},
    legendLabel -> legLab[n, l, k],
    canvasColor -> GrayLevel[0, 0.25]],
   {"y  [nm]", "x  [nm]", "z  [\[Mu]m]"},
   {{0.59, .14}, {0.25, .14}, {0.1, .55}},
   {0.11*\[Pi], -.150*\[Pi], .5*\[Pi]},
   14,
   {{35, None}, {20, None}}];
   
plot2d[nn_, ll_, kk_, minMaxs_ : {7*10^-8, 7*10^-8, 2.25*10^-6}] := 
 With[{
   n = nn, (*cyclotron quantum number*)
   l = ll, (*magneton quantum number*)
   k = kk, (*axial quantum number*)
   mx = minMaxs[[1]],(*absolute value of min/max x coordinate*)
   my = minMaxs[[2]],(*absolute value of min/max y coordinate*)
   mz = minMaxs[[3]]},(*absolute value of min/max z coordinate*)
  Show[{
    GraphicsRow[{
      cmDensityPlot2D[
       Evaluate[
        WF[n, l, k, xx, 0, zz]],
       {xx, -mx, mx},
       {zz, -mz, mz},
       frameLabel -> {"x  [nm]", "z  [\[Mu]m]"},
       labelingFunction -> (
         ScientificForm[
           (aoM*10^9)^-3*#1, {64, 1},
           NumberPadding -> {"", "0"}] &),
       legendLayout -> "Row",
       imageSize -> 483,
       ticks -> {
         linTixScAlt[-2*10^-6, 2*10^-6, 1*10^-6, 10^6, 1],
         linTixScAlt[-90*10^-9, 90*10^-9, 30*10^-9, 10^9, 1]},
       legendLabel -> legLab[n, l, k]],
      cmDensityPlot2D[
       Evaluate[
        WF[n, l, k, xx, yy, 0]],
       {xx, -mx, mx},
       {yy, -my, my},
       frameLabel -> {"x  [nm]", "y  [nm]"},
       labelingFunction -> (
         ScientificForm[
           (aoM*10^9)^-3*#1, {64, 1},
           NumberPadding -> {"", "0"}] &),
       legendLayout -> "Row",
       ticks -> {
         linTixScAlt[-90*10^-9, 90*10^-9, 30*10^-9, 10^9, 1],
         linTixScAlt[-90*10^-9, 90*10^-9, 30*10^-9, 10^9, 1]},
       legendLabel -> legLab[n, l, k]]},
     ImageSize -> 1100,
     Background -> Black,
     Alignment -> Bottom],
    txtLab["y = 0", {160, -145}],
    txtLab["z = 0", {715, -145}],
    txtLab[
     "\!\(\*SubscriptBox[\(\[Nu]\), \(c\)]\) = " <> ToString[vc] <> 
      " GHz", {765, -490}],
    txtLab[
     "\!\(\*SubscriptBox[\(\[Nu]\), \(z\)]\) = " <> ToString[vz] <> 
      " MHz", {980, -490}],
    txtLab[
     "\!\(\*SubscriptBox[\(\[Nu]\), \(c\)]\) = " <> ToString[vc] <> 
      " GHz", {210, -490}],
    txtLab[
     "\!\(\*SubscriptBox[\(\[Nu]\), \(z\)]\) = " <> ToString[vz] <> 
      " MHz", {425, -490}]}]]
      
export2d[n_, l_, k_] := 
 Export[
  FileNameJoin[{
    NotebookDirectory[], 
    "data",
    "figs2d",
    "vc" <> ToString[vc] <> "GHz_vz" <> ToString[vz] <> "MHz",
    "n" <> ToString[n] <> "_l" <> ToString[l] <> "_k" <> 
     ToString[k] <> ".png"}],
  ImageCrop[
   Rasterize[
    plot2d[n, l, k],
    ImageResolution -> 810,
    Background -> Black],
   {.97*12375, .95*7213}],
  ImagePadding -> 20,
  Padding -> Black,
  ImageResolution -> 810,
  Background -> Black]

export3d[n_, l_, k_] := 
  Export[
  FileNameJoin[{
    NotebookDirectory[],
      "data",
      "figs3d",
      "vc"<>ToString[vc]<>"GHz_vz"<>ToString[vz]<>"MHz",
      "n" <> ToString[n] <> "_l" <> ToString[l] <> "_k" <> ToString[k] <> ".png"}],
    Rasterize[
      plot3d[n,l,k],
      ImageResolution->1080],
      Background->White,
      ImagePadding->None];   
   



