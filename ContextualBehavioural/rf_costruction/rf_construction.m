% the labels are '0' and '1', which stand for normal and anomalous, respectively
% code for computing the accuracy is provided too

% random forest built from instances of both class 1 and 2
rf12 = TreeBagger(10,Dn (:, [1:3]),Dn (:, 4),'Method','classification');
prd =predict(rf12,T12(1: 500 ,  : ));
prd=cell2mat(prd);
sum(prd == '0')
prd =predict(rf12, T12( 501: 1150 ,  : ));
prd=cell2mat(prd);
sum(prd == '1')

% random forest built from instances of class 2
rf2 = TreeBagger(10,D2 (:, [1:3]),D2 (:, 4),'Method','classification');
prd =predict(rf2, T2(1:  200,  : ));
prd=cell2mat(prd);
sum(prd == '0')
prd =predict(rf2, T2(201: 500,  : ));
prd=cell2mat(prd);
sum(prd == '1')

% random forest built from instances of class 1
rf1 = TreeBagger(10,D1 (:, [1:3]),D1 (:, 4),'Method','classification');
prd =predict(rf1, T1(1:  300,  : ));
prd=cell2mat(prd);
sum(prd == '0')
prd =predict(rf1, T1(301: 650,  : ));
prd=cell2mat(prd);
sum(prd == '1')

% BBNAC (built from normal instances of both class 1 and 2)
[cl, Cn] = kmeans(Db( : ,1 : 3), 2);
th = bbnacboot(Db( : ,1 : 3), cl);
Db= [Db( : ,1 : 3),cl,th];
[acc,sc] = bbnacexec(Db,T12( 1: 500 ,:), T12( 501: 1150 ,:), Cn);

