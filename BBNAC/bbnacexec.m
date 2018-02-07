% [ acc, sc ] = BBNACEXEC(ds,nds, pds, Cn)
%
%   ds : The original dataset. The last two attributes are reserved to 
%    the cluster IDs and the thresholds, respectively.
%   nds : dataset containing the negative samples
%   pds : dataset containing the positive samples
%   Cn : centroids vector
%   
%   acc: accuracy of the classifier
%   sc: vector containing the anomaly scores
%   
% Returns the accuracy and the scores.
% 
%
% Written by Fen

function [ acc, sc ] = bbnacexec(ds,nds, pds, Cn)

num = 0;

nsz= size(nds);
psz= size(pds);

sc = zeros (1,nsz ( 1 )+psz ( 1 ));
isc = 1;

for i = 1 : nsz( 1 )
    b = nds ( i , : );
    indx = bbnaclosestcl(Cn, b);
    [lab, score] = bbnacvote(ds, indx, b);
    sc( isc ) = 1-score; 
    isc =isc+1;
    
    if lab == 1
        num=num +1;
    end
end

num
acc=num;
num = 0;

for i = 1 : psz( 1 )
    b = pds ( i , : );
    indx = bbnaclosestcl(Cn, b);
    [lab, score] = bbnacvote(ds, indx, b);
    sc( isc ) = 1-score; 
    isc =isc+1;
    
    if lab == 0
        num=num +1;
    end
end

num
acc=acc+num;

acc=acc/(nsz( 1 )+psz( 1 ));