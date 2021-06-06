%%%%
%{
This function is to use LLE algrithm to calculate the LLE dimension
input:K ,d
output:Y and Y's picture
%}

K = 12 ;%(��������) number of neighborhood points
d = 3;%���Ƕ��ά�� maximum embedding dimension
x1=data(:,8);
x2=data(:,9);
x3=data(:,10);
x4=data(:,11);
x5=data(:,12);
c=data(:,18);
scatter3(x1,x2,x5,10,c,'filled');
xlabel('FBC');
ylabel('SFD');
zlabel('sandbox');
hold on;
X=[x1';x2';x3';x4';x5'];
%��lle��ά ues LLE reduce dimension
Y=LLE(X,K,d);
figure
scatter3(Y(1,:),Y(2,:),Y(3,:),10,c','filled')
scatter(Y(1,:),Y(2,:),10,c','filled')
xlabel('LLE1');
ylabel('LLE2');
Y=Y';