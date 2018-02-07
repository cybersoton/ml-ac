%   T : contains the instances that have been processed (+ training set)
%   STM : short-term memory
%   D : contains the unseen observations

unknown = 0;
s = 1;
rep = 0;
cvs = 0; 
vc = 0;
for i = sp : ep
    u= D ( i ,1 :2 );
    cid = oli_explain(cl,Cn,rcl,u);
    if cid ~= -1
        T= [T; D( i ,: )]; 
        cl= [cl; cid];
        [rcid, Cncid]= oli_updatestats(cl,Cn,T( : ,1 :2 ),cid);
        Cn( cid,: ) = Cncid;
        rcl( cid ) = rcid;
    else
       
        unknown=unknown+1;
        STM ( s,: ) = D( i ,: );
        s=s +1;
        nk = 0;
        if s >= minexcl * k 
            
            [stmcl, stmCn] = kmeans(STM (:, 1: 2), k);
            [ cth, rth ] = oli_cmpthresh(cl,Cn,rcl,T( : ,1 :2 ),coh);
            stmrcl=oli_hyprad (stmcl, stmCn,STM( : ,1 :2 ));
            for j = 1 : k
                chv = oli_cmptcoev(stmcl, stmCn,stmrcl,STM( : ,1 :2 ),coh,j);
                subs = STM ( find(stmcl == k), : );
                subslen= size(subs);
                
                
                if subslen ( 1 ) >= rth && chv >= cth
                    
                     nat = oli_detnature(Cn,stmCn( k, : ));
                     if nat == 1
                        T= [T; subs];
                        
                        Cnlen= size(Cn);
                        newcl = zeros (Cnlen (1), 1);
                        newcl( : ) = Cnlen (1) +1;
                        cl= [cl; newcl];
                        Cn= [Cn; stmCn( k, : )];
                     end
                     nk =nk+1; 
                     vc=vc +1;
                end
            end
            
            
            if vc == 0
                nk = oli_adaptk(stmcl,stmCn,stmrcl,STM ( : , 1:2 ),T ( : , 1:2 ),coh,k);
                k=nk;
            else
                k=nk;
                vc = 0;
            end
            
        end
    end
end

clearvars i rcid s rep cvs nk vc Cnlen newcl