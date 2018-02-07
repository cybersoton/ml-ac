% T = BBNACBOOT(ds, cl)
%
%   ds : dataset (Without the class attribute)
%   cl : clusters ID vector
%   
%   T : threshold vector
%   
%  Executes the Bootstrap phase of BBNAC
% 
%
% Written by Fen

function [ T ] = bbnacboot(ds, cl)
sds= size(ds); 

ucls = unique (cl); 
sucls= size(ucls);

T = zeros (sds (1),1);
rw = 1;

for i = 1 : sucls(1) 
    usm = ds(find(cl == ucls(i)),:); 
    susm =size(usm);
    
    for j = 1 : susm (1) 
        max=0;
        vj =usm (j,:); 
        for k = 1 : susm (1)
            if k ~= j
                vk =usm (k,:);
                ed=norm (vj-vk,2);
                if ed > max
                    max = ed;
                end
            end
        end
        T (rw) = max;
        rw=rw +1;
    end
    
end






