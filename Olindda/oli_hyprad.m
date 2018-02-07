% rcl = OLI_HYPRAD(cl,Cn,D)
%
%   cl : Clusters ID Vector
%   Cn : centroids Vector
%   D : Dataset containing the instances
%   
%   rcl: vector containing the radiuses computed for the clusters in cl
%   
% Computes the radius for each cluster in cl.
% D should not contain the class attribute.
%
% Written by Fen

function [ rcl ] = oli_hyprad(cl,Cn,D)

cnlen= size(Cn);
rcl = zeros (cnlen (1),1);

for i = 1 : cnlen (1) 
    cid=i;
    S=D ( find(cl == cid) , : ); 
    slen= size(S);
    
    dsts = zeros (slen(1), 1);
    for j = 1 : slen(1)
        dsts( j ) = norm (S( j , : ) - Cn ( cid,: ), 2);
    end
    
    rcl( cid ) = max (dsts);
end

