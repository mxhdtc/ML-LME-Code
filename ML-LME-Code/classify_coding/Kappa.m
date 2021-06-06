%kappa coefficient
%input: testPredictions,testResponse
%output: k is kappa coefficient
function [k]=Kappa(testPredictions,testResponse)
Predictions=testPredictions;
Response=testResponse;
[num,m]=size(Predictions);
P_0=sum(Predictions==Response)/length(Predictions);
a=zeros(1,3);
b=zeros(1,3);
Sum=0;
for i=1:3
    a(i)=sum(Response==i);
    b(i)=sum(Predictions==i);
    Sum=Sum+a(i)*b(i);
end
P_e=Sum/(num*num);
k=(P_0-P_e)/(1-P_e);
end