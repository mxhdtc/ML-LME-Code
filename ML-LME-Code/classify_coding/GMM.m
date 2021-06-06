%������Psi��Ӧ��ά��˹���������е�(x-��)����ת�õ�˳���������ᵽ�ĸ�˹������ͬ��������Ϊ�˱�֤����ɳ��ԣ���Ӱ����.
%Gamma Ϊ��������ֵ��Gamma(i,j)�����i���������ڵ�j��ģ�͵ĸ��ʡ�
%MuΪ������SigmaΪЭ�������%PiΪ��ģ�͵�Ȩֵϵ��%����2����ά��̬����
%����2����ά��̬����
%{
MU1 = [1 2];
SIGMA1 = [1 0; 0 0.5];
MU2 = [-1 -1];
SIGMA2 = [1 0; 0 1];
%}
%����1000��2��(Ĭ��)��ֵΪmu��׼��Ϊsigma����̬�ֲ������
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
%��ʾ
   c=data(:,20);
end

%%��һ��
if batch==1
   X=[data(1:423,12),data(1:423,9)];
%��ʾ
   c=data(1:423,20);
end

%%�ڶ���
if batch==2
   X=[data(424:825,12),data(424:825,9)];
%��ʾ
   c=data(424:825,20);
end

%%������
if batch==3
   X=[data(826:1094,12),data(826:1094,9)];
%��ʾ
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
%ѡ�������������������Ϊ����������ֵ
Mu(1,:)=X(randi([1 N],1,1),:);

%{
Mu(1,:)=X(randi([1 fix(N/3)],1,1),:);
Mu(2,:)=X(randi([fix(N/3) fix(2*N/3)],1,1),:);
Mu(3,:)=X(randi([fix(2*N/3) N],1,1),:);
%}

%�������ݵ�Э������ΪЭ�����ֵ
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
  Psi(:,k) = (2*pi)^(-D/2)*det(Sigma(:,:,k))^(-1/2)*diag(exp(-1/2*Y/(Sigma(:,:,k))*(Y')));      %Psi��һ�д����һ����˹�ֲ����������ݵ�ȡֵ
end
Gamma_SUM=zeros(D,D);
for j = 1:N
  for k=1:K
  Gamma(j,k) = Pi(1,k)*Psi(j,k)/sum(Psi(j,:)*Pi');                                               %Psi�ĵ�һ�зֱ����������˹�ֲ��Ե�һ�����ݵ�ȡֵ
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
    disp('����');
    disp(Mu);
    disp('Э�������');
    disp(Sigma);
    disp('Ȩֵϵ��');
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