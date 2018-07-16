## Random Forest 

This folder contains implementation of the Random Forest (RF) algorithm. 

### Training

The files in *rf_construction* report the creation and training in Matlab of a RF for the reported dataset. 


### Merging Algorithm

The files in *rf_merging* define a procedure to merge RF branches (hence to reduce its width). 

To run this algorithm the following commands can be used

``` python rules_merging.py <dataset file path>, <rules file sparse>, <set file path>, <destination file path>```

Example

``` python rules_merging.py ex_input/d1.txt ex_input/c1_rules.txt ex_input/d2.txt ex_input/md1rls.txt ```

