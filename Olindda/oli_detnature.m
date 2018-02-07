% nat = OLI_DETNATURE(Cn,ncn)
%
%   Cn : centroids Vector
%   ncn : centroid of the new cluster
%   
%   nat: 1 if the outcome is positive, 0 otherwise
%   
% Checks whether the new cluster is inside the hyper sphere defined by the global
% centroid. 
% Returns 1 if the outcome is positive, 0 otherwise.
% 
% Written by Fen

function [ nat ] = oli_detnature(Cn,ncn)

cnsz= size(Cn);
gcn = zeros (1,cnsz (2)); 


for i = 1 : cnsz (1)
    gcn = gcn + Cn ( i,: );
end
gcn =gcn / cnsz (1);


hsdst = zeros (cnsz (1),1);
for i = 1 : cnsz (1)
    hsdst ( i ) = norm (gcn - Cn ( i,: ),2);
end
grad = max (hsdst); 

nat = 0;
if norm (ncn - gcn,2) <= grad
    nat = 1;
end
