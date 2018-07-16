% cid = OLI_EXPLAIN(cl,Cn,rcl,u)
%
%   cl : Clusters ID Vector
%   Cn : centroids Vector
%   rcl : Hyper spheres' radius
%   u : instance to explain
%   
%   cid: the cluster ID to which u belongs
%   
% Explains the instance u. In other words, it controls if there exist a cluster
% to which u belongs. 
%
% Returns the cluster ID if the outcome is positive, -1 otherwise.
%
% Written by Fen

function [ cid ] = oli_explain(cl,Cn,rcl,u)

cnlen= size(Cn);
cid = -1;

for i = 1 : cnlen (1)
    udst = norm (Cn( i,: ) - u, 2);
    if udst <= rcl( i )
        cid = i;
        break;
    end
end