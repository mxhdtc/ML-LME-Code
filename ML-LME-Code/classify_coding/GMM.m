%程序中Psi对应二维高斯函数，其中的(x-μ)与其转置的顺序与上述提到的高斯函数不同，这样是为了保证矩阵可乘性，不影响结果.
%Gamma 为隐变量的值，Gamma(i,j)代表第i个样本属于第j个模型的概率。
%Mu为期望，Sigma为协方差矩阵%Pi为各模型的权值系数%产生2个二维正态数据
%产生2个二维正态数据
%{
MU1 = [1 2];
SIGMA1 = [1 0; 0 0.5];
MU2 = [-1 -1];
SIGMA2 = [1 0; 0 1];
%}
%生成1000行2列(默认)均值为mu标准差为sigma的正态分布随机数
%X = [mvnrnd(MU1, SIGMA1, 1000);mvnrnd(MU2, SIGMA2, 1000)];
%X = mvnrnd(MU1, SIGMA1, 1000);
%X1=[data(1:422,8),data(1:422,9)];
%X2=[data(424:824,8),data(424:824,9)];
%X3=[data(826:1094,8),data(826:1094,9)];
%X2=[data(424:847,9),data(424:847,13)];
%X=[X1;X2;X3];
batch=0;

if batch==0
   X=[data(:,18),data(:,19)];
%显示
   c=data(:,20);
end

%%第一批
if batch==1
   X=[data(1:423,12),data(1:423,9)];
%显示
   c=data(1:423,20);
end

%%第二批
if batch==2
   X=[data(424:825,12),data(424:825,9)];
%显示
   c=data(424:825,20);
end

%%第三批
if batch==3
   X=[data(826:1094,12),data(826:1094,9)];
%显示
   c=data(826:1094,20);
end


scatter(X(:,1),X(:,2),10,c,'filled');
xlabel('PCA_1');
ylabel('PCA_2');
%====================
K=1;
[N,D]=size(X);
Gamma=zeros(N,K);
Psi=zeros(N,K);
Mu=zeros(K,D);
LM=zeros(K,D);
Sigma =zeros(D, D, K); 
Pi=zeros(1,K);
%选择随机的两个样本点作为期望迭代初值
Mu(1,:)=X(randi([1 N],1,1),:);

%{
Mu(1,:)=X(randi([1 fix(N/3)],1,1),:);
Mu(2,:)=X(randi([fix(N/3) fix(2*N/3)],1,1),:);
Mu(3,:)=X(randi([fix(2*N/3) N],1,1),:);
%}

%所有数据的协方差作为协方差初值
for k=1:K
  Pi(k)=1/K;
  Sigma(:, :, k)=cov(X);
end
LMu=Mu;
LSigma=Sigma;
LPi=Pi;
while true
%Estimation Step  
for k = 1:K
  Y = X - repmat(Mu(k,:),N,1);
  Psi(:,k) = (2*pi)^(-D/2)*det(Sigma(:,:,k))^(-1/2)*diag(exp(-1/2*Y/(Sigma(:,:,k))*(Y')));      %Psi第一列代表第一个高斯分布对所有数据的取值
end
Gamma_SUM=zeros(D,D);
for j = 1:N
  for k=1:K
  Gamma(j,k) = Pi(1,k)*Psi(j,k)/sum(Psi(j,:)*Pi');                                               %Psi的第一行分别代表两个高斯分布对第一个数据的取值
  end
end
%Maximization Step
for k = 1:K
%update Mu
  Mu_SUM= zeros(1,D);
  for j=1:N
     Mu_SUM=Mu_SUM+Gamma(j,k)*X(j,:);   
  end
  Mu(k,:)= Mu_SUM/sum(Gamma(:,k));
%update Sigma
 Sigma_SUM= zeros(D,D);
 for j = 1:N
   Sigma_SUM = Sigma_SUM+ Gamma(j,k)*(X(j,:)-Mu(k,:))'*(X(j,:)-Mu(k,:));
 end
 Sigma(:,:,k)= Sigma_SUM/sum(Gamma(:,k));
 %update Pi
 Pi_SUM=0;
 for j=1:N
   Pi_SUM=Pi_SUM+Gamma(j,k);
 end
 Pi(1,k)=Pi_SUM/N;
end

R_Mu=sum(sum(abs(LMu- Mu)));
R_Sigma=sum(sum(abs(LSigma- Sigma)));
R_Pi=sum(sum(abs(LPi- Pi)));
R=R_Mu+R_Sigma+R_Pi;
if ( R<1e-5)
    disp('期望');
    disp(Mu);
    disp('协方差矩阵');
    disp(Sigma);
    disp('权值系数');
    disp(Pi);
 %   obj=gmdistribution(Mu,Sigma);
 %   figure,h = ezmesh(@(x,y)pdf(obj,[x,y]),[1 1.8], [0 0.5]);
    break;
end

 LMu=Mu;
 LSigma=Sigma;
 LPi=Pi;
end
%=====================