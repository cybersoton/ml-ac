% prd: vector of predicted labels
% sc_i: vector of anomaly scores

ps = 1; % used by compute_AUC

% anomaly scores of the normal instances
[prd, sc1] = predict(rf1, T1(1:  300,  : ));
% anomaly scores of the anomalous instances
[prd, sc2] = predict(rf1, T1(301: 650,  : ));
scall1 = [sc1( : , 2 ); sc2( : , 2 )];
%nl = 300;
%na= 350;
ps = 1;
scall1 =scall1';

% anomaly scores of the normal instances
[prd, sc1] = predict(rf2, T2(1:  200,  : ));
% anomaly scores of the anomalous instances
[prd, sc2] = predict(rf2, T2(201: 500,  : ));
scall2 = [sc1( : , 2 ), sc2( : , 2 )];
scall2 = [sc1( : , 2 ); sc2( : , 2 )];
%nl = 200;
%na= 300;
ps = 1;
scall2 =scall2';
% rf1 and rf2 are part of the same classification model
scall=[scall1( 1: 300, 2 ); scall2(1 : 200, 2 );scall1(301: 650, 2 ); scall2(201 : 500, 2 )];
nl = 500;
na= 650;
figure
[ X,Y,T,AUC ] = compute_AUC( sc,nl,na,ps );

% anomaly scores of the normal instances
[prd,sc1]=predict(rf12,T12(1: 500 ,  : ));
% anomaly scores of the anomalous instances
[prd,sc2] =predict(rf12, T12( 501: 1150 ,  : ));
sc1=sc1';
sc2=sc2';
sc= [sc1( 2 , : ), sc2( 2 , : )];
nl = 500;
na= 650;
figure
[ X,Y,T,AUC ] = compute_AUC( sc,nl,na,ps );

% sc is a vector containing the anomaly scores
[acc,sc] = bbnacexec(Db,T12( 1: 500 ,:), T12( 501: 1150 ,:), Cn);
nl = 500;
na= 650;
figure
[ X,Y,T,AUC ] = compute_AUC( sc,nl,na,ps );