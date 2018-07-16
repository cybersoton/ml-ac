% [ ri, Cni ] = OLI_UPDATESTATS(cl,Cn,D,ci)
%
%   cl : Clusters ID Vector
%   Cn : centroids Vector
%   D : Dataset containing the instances
%   ci : ID of the cluster to update
%   
%   ri : the new hyper sphere's radius
%   Cni : the new centroid
%   
% Updates the statistics of ci's hyper sphere, after the addition of new instances
% Tthe instances are contained in D.
% D should not contain the class attribute.
% Returns the new hyper sphere's radius and the new centroid.
% 
% Written by Fen

function [ ri, Cni ] = oli_updatestats(cl,Cn,D,ci)
S=D ( find(cl == ci) , : ); 
slen= size(S);

cnlen= size(Cn);
ncn = zeros (1,cnlen ( 2 ));
for j = 1 : slen(1)
    ncn = ncn + S( j , : );
end
Cni = ncn./ slen(1);

dsts = zeros (slen(1), 1);
for j = 1 : slen(1)
    dsts( j ) = norm (S( j , : ) - Cni, 2);
end


ri = max (dsts);