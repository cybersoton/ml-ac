% indx = BBNACLOSESTCL(Cl, b)
%
%   Cl : centroids vector
%   b : user behaviour
%   
%   indx: index of the closest cluster
%   
% Computes the closest centre to b. It uses the Euclidean distance.
% 
%
% Written by Fen

function [ indx ] = bbnaclosestcl(Cl, b)
scl= size(Cl);

min=intmax;
indx = 0;

for i = 1 : scl(1) 
    ed=norm (Cl (i,:)-b,2); 
    
    if ed < min
        min = ed;
        indx = i;
    end
    
end






