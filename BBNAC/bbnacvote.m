%  [lab, score] = BBNACVOTE(ds, cl, b)
%
%   ds : dataset. The last two attributes are reserved to 
%   the cluster IDs and the thresholds, respectively.
%   cl : Cluster ID to which b belongs.
%   b : user behaviour
%   
%   lab : 1 normal, 0 anomalous
%   score: the normality score of b. It is computed as favourable #votes/total #votes
%   
% Executes the voting phase of BBNAC.
% 
%
% Written by Fen

function [ lab, score ] = bbnacvote(ds, cl, b)
lab = 0; 
sds= size(ds); 

ac=sds (2)-1; 
at =sds (2); 
ua= [1 2 3]; 

df=ds (ds (:,ac) == cl,:); 
sdf= size(df);

votes = 0; 
for i = 1 : sdf (1)
    ed = norm (b-df(i,ua),2);
    
    if ed <= ds (i,at)
        votes=votes+1;
    end
end

thresh = 0.5;
votes=votes/sdf (1);

if votes >= thresh
    lab = 1;
end

score= votes;

