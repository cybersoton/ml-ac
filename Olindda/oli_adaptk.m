% nk = OLI_ADAPTK(cl,Cn,rcl,STM,D,coh,k)
%
%   cl : Candidate clusters ID Vector
%   Cn : centroids Vector
%   rcl : hyper spheres' radius
%   D : Dataset containing the instances
%   coh : type of cohesion
%   ci : cluster ID
%   STM : short-term memory
%   k : kmeans parameter
%   
%   nk : the updated parameter k
%   
% Updates the parameter k based on the candidate clusters.
% D should not contain the class attribute.
% 
% Written by Fen

function [ nk ] = oli_adaptk(cl,Cn,rcl,STM,D,coh,k)
cnlen= size(Cn);

cntcoh = 0;
cntrep = 0;

[ cth, rth ] = oli_cmpthresh(cl,Cn,rcl,D,coh);

for i = 1 : cnlen (1)
    cid=i;
    S=STM ( find(cl == cid) , : ); 
    slen= size(S);
    ni=slen ( 1 ); 

    chv = oli_cmptcoev(cl,Cn,rcl,STM,coh,i);
    
    if chv < cth
        cntcoh=cntcoh+1;
    end
    
    if ni < rth
        cntrep=cntrep+1;
    end
end


if cntcoh > cntrep
    nk= k+1;
else
    nk= k-1;
end

