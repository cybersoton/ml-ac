% chv = OLI_CMPTCOHEV(cl,Cn,rcl,D,coh,ci)
%
%   cl : Clusters ID Vector
%   Cn : centroids Vector
%   rcl : hyper spheres' radius
%   D : Dataset containing the instances
%   coh : type of cohesion
%   ci : cluster ID
%   
%   chv: the cohesion of ci
%   
% Computes the cohesion of ci.
% D should not contain the class attribute.
% 
% Written by Fen

function [ chv ] = oli_cmptcoev(cl,Cn,rcl,D,coh,ci)

if coh == 0
    chv=oli_cmptdensity (cl,rcl,D,ci);
elseif coh == 1
    chv=oli_cmptss (cl,Cn,D,ci);
else
    chv=oli_cmptad (cl,Cn,D,ci);
end


% ***********************************************************************
function [ dth ] = oli_cmptdensity(cl,rcl,D,ci)
Dsz= size(D);
m=Dsz ( 2 ); 
g=oli_gammaf(m);

cid=cl ( ci ); 
S=D ( find(cl == cid) , : ); 
slen= size(S);
ni=slen ( 1 );
ri = rcl( ci ); 

voli = (pi^ (m/2) * ri^m) / g;
dth=ni/voli;

% ***********************************************************************
function [ ssth ] = oli_cmptss(cl,Cn,D,ci)

cid=ci;
S=D ( find(cl == cid) , : ); 
slen= size(S);
ni=slen ( 1 ); 

ssum = 0;
for j = 1 : slen(1)
    x = S( j , : ) - Cn ( cid,: );
    ssum = ssum + sum(x(:).^2);
end
ssth =ssum/ni;

% ***********************************************************************
function [ adth ] = oli_cmptad(cl,Cn,D,ci)

cid=ci;
S=D ( find(cl == cid) , : );
slen= size(S);
ni=slen ( 1 );

ssum = 0; 
for j = 1 : slen(1)
    x = S( j , : ) - Cn ( cid,: );
    ssum = ssum +  sum(abs (x(:)));
end
adth =ssum/ni;



















