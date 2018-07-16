# ML-AC: Adapting Access Control 

This repository contains the algorithm implementation of the ML-AC system presented in [this paper](https://eprints.soton.ac.uk/421536/).

 
The solution aims at making access control adaptive by refining at run-time access granted according to monitored behaviours. The solution is building the user profile with a Random Forest algorithm and using a clustering approach to prevent anomaly behaviours to be used in the learning.
 
## Structure of the repository

**Contextual Behaviour** contains the management of the Random Forest algorithm 

**Concept Drift** contains the clustering approach for handling concept drift

**BBNAC** contains the Matlab implementation of the approach we used in the experimental validation of ML-AC
