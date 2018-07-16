function [ g ] = oli_gammaf(m)
if rem(m,2) == 0
    g=factorial (m/2);
else
    g=sqrt(pi) *(doublefact(m)/(2^ ((m+1)/2)));
end