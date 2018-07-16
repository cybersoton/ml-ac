% [ df ] = DOUBLEFACT(n) 
%   
% Computes the double factorial of n.
% 
% Written by Fen

function [ df ] = doublefact(n)
df = 1;
b = 1;
if mod (n,2) == 0
    b=2;
end
for i = n : -2 : b
    df =df *i;
end
