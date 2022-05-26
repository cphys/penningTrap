#!/bin/bash

for n in {0..3..1}
do
for l in {0..3..1}
do
for k in {0..5..1}
do
./wfScript-noLegend.wls $n $l $k 
done
done
done
exit 0
