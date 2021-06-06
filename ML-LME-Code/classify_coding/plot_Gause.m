% 先限定三维图中的 x,y 轴坐标范围
X =1.5: 0.001 :1.8;
Y =1.3: 0.001 :1.6;
% 标准差
Mu;Sigma;Pi;
[ XX, YY ] = meshgrid( X, Y );
[a,b]=size(X);

i=1;
Mu_1=[1.5759    1.4046];
Sigma_1=[    0.0029    0.0018
    0.0018    0.0025];
Z_1 = (XX-Mu_1(1,1)).^2./ ( 2 * Sigma_1(1,1)^2 )+ ( YY-Mu_1(1,2)).^2./( 2 * Sigma_1(2,2)^2 ); % 均值为（0,0）
Z_1 = -Z_1 ;
Z_1 = exp(Z_1)/(2 * pi * Sigma_1(1,1)* Sigma_1(2,2)*sqrt(1- Sigma_1(1,2).^2));

i=2;
Mu_2=[ 1.6560    1.5190];
Sigma_2=[    0.0015    0.0012
    0.0012    0.0021];
Z_2 = (XX-Mu_2(1,1)).^2./ ( 2 * Sigma_2(1,1)^2 )+ ( YY-Mu_2(1,2)).^2./( 2 * Sigma_2(2,2)^2 ); % 均值为（0,0）
Z_2 = -Z_2 ;
Z_2 = exp(Z_2)/(2 * pi * Sigma_2(1,1)* Sigma_2(2,2)*sqrt(1- Sigma_2(1,2).^2));

i=3;
Mu_3=[1.6681    1.5383];
Sigma_3=[    0.0023    0.0012
    0.0012    0.0022];
Z_3 = (XX-Mu_3(1,1)).^2./ ( 2 * Sigma_3(1,1)^2 )+ ( YY-Mu_3(1,2)).^2./( 2 * Sigma_3(2,2)^2 ); % 均值为（0,0）
Z_3 = -Z_3;
Z_3 = exp(Z_3)/(2 * pi * Sigma_3(1,1)* Sigma_3(2,2)*sqrt(1- Sigma_3(1,2).^2));
%{
i=1;
Z_1 = (XX-Mu(i,1)).^2./ ( 2 * Sigma(1,1,i)^2 )+ ( YY-Mu(i,2)).^2./( 2 * Sigma(2,2,i)^2 ); % 均值为（0,0）
Z_1 = -Z_1 ;
Z_1 = exp(Z_1)/(2 * pi * Sigma(1,1,i)* Sigma(2,2,i)*sqrt(1- Sigma(1,2,i).^2));
i=2;
Z_2 = (XX-Mu(i,1)).^2./ ( 2 * Sigma(1,1,i)^2 )+ ( YY-Mu(i,2)).^2./( 2 * Sigma(2,2,i)^2 ); % 均值为（0,0）
Z_2 = -Z_2 ;
Z_2 = exp(Z_2)/(2 * pi * Sigma(1,1,i)* Sigma(2,2,i)*sqrt(1- Sigma(1,2,i).^2));
i=3;
Z_3 = (XX-Mu(i,1)).^2./ ( 2 * Sigma(1,1,i)^2 )+ ( YY-Mu(i,2)).^2./( 2 * Sigma(2,2,i)^2 ); % 均值为（0,0）
Z_3 = -Z_3 ;
Z_3 = exp(Z_3)/(2 * pi * Sigma(1,1,i)* Sigma(2,2,i)*sqrt(1- Sigma(1,2,i).^2));
ZZ=Pi(1).*Z_1+Pi(2).*Z_2+Pi(3).*Z_3;
%}
% 显示高斯函数的三维图
figure, mesh(X, Y, Z_1); % 线框图
xlabel('sandbox');
ylabel('SFD');
zlabel('Gaussian-value');
hold on;
mesh(X,Y,Z_2);
hold on;
mesh(X,Y,Z_3);