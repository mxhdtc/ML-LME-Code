clc;
%%load data;
%this is the firt to run 
W=[];
data=importdata('C:\Users\12417\Desktop\new_new_data.txt'); 
[m,n]=size(data);
data=data(1:m,:);
pre_name=[12,3,4,5,6,7];
%inputTable=array2table(data, 'VariableNames', {'PW','PHV','PHV_PW','PH','PH_PW','SA','SA_PHV_PW','FBM','SFD','DBCS','DBCG','sandbox','PCA_T_1','PCA_T_2','PCA_T_3','LLE_1','LLE_2','PCA_F_1','PCA_F_2','label'});
A1=data(:,pre_name);%自变量 independent variable
d=data(:,n);%因变量 dependent variable
[m,n]=size(A1);
%normalize data
for i=1:n-1
    A1(:,i)=zscore(A1(:,i), 0, 1);
end

%plot parallelcoords
%{
labels={'LLE_1','LLE_2','PCA_1','PCA_2'};
species={'label_1','label_2','label_3'};
parallelcoords(A1(:,16:19),'Group',data(:,20),'Labels',labels','LineWidth',0.0002)
%}