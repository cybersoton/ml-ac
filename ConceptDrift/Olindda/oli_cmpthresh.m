% [ cth, rth ] = OLI_CMPTHRESH(cl,Cn,rcl,D,coh)
%
%   cl : Clusters ID Vector
%   Cn : centroids Vector
%   rcl : hyper spheres' radius
%   D : Dataset containing the instances
%   coh : type of cohesion
%   
%   cth: cohesion threshold
%   rth: representativeness threshold
%   
% Computes the cohesion and representativeness thresholds.
% D should not contain the class attribute.
% 
% Written by Fen

function [ cth, rth ] = oli_cmpthresh(cl,Cn,rcl,D,coh)
rth=5;

if coh == 0
    cth=oli_densityth (cl,Cn,rcl,D);
elseif coh == 1
    cth=oli_ssth (cl,Cn,D);
else
    cth=oli_adtyth (cl,Cn,D);
end


% ***********************************************************************
function [ dth ] = oli_densityth(cl,Cn,rcl,D)
cnlen= size(Cn);
dcl = zeros (cnlen (1),1);
Dsz= size(D);
m=Dsz ( 2 ); 
g=oli_gammaf(m);

for i = 1 : cnlen (1) 
    cid=i; 
    S=D ( find(cl == cid) , : );
    slen= size(S);
    ni=slen ( 1 ); 
    ri = rcl( cid ); 
    
    voli = (pi^ (m/2) * ri^m) / g;
    dcl ( cid )=ni/voli;
end

dth = max (dcl);


% ***********************************************************************
function [ ssth ] = oli_ssth(cl,Cn,D)
cnlen= size(Cn);
sums = zeros (cnlen (1),1); 

for i = 1 : cnlen (1) 
    cid=i;
    S=D ( find(cl == cid) , : ); 
    slen= size(S);
    ni=slen ( 1 );
    
    ssum = 0; 
    for j = 1 : slen(1)
        x = S( j , : ) - Cn ( cid,: );
        ssum = ssum + sum(x(:).^2);
    end
    sums ( cid ) =ssum/ni;
end

ssth = max (sums);

% ***********************************************************************
function [ adth ] = oli_adtyth(cl,Cn,D)
cnlen= size(Cn);
sums = zeros (cnlen (1),1); 

for i = 1 : cnlen (1) 
    cid=i;
    S=D ( find(cl == cid) , : );
    slen= size(S);
    ni=slen ( 1 );
    
    ssum = 0; 
    for j = 1 : slen(1)
        x = S( j , : ) - Cn ( cid,: );
        ssum = ssum +  sum(abs (x(:)));
    end
    sums ( cid ) =ssum/ni;
end

adth = max (sums);



















