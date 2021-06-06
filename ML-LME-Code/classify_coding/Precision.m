%Precision¾«È·¶È
function [precision]=Precision(testPredictions,testResponse)
Predictions=testPredictions;
Response=testResponse;
[num,m]=size(Predictions);
Pre_1=Predictions;Pre_2=Predictions;Pre_3=Predictions;
Res_1=Response;Res_2=Response;Res_3=Response;
Pre=Predictions;
Res=Response;

for i=1:num
    if Predictions(i)~=1
        Pre_1(i)=0;
    end
    if Response(i)~=1
        Res_1(i)=0;
    end
    if Predictions(i)~=2
        Pre_2(i)=0;
    end
    if Response(i)~=2
        Res_2(i)=0;
    end
    if Predictions(i)~=3
        Pre_3(i)=0;
    end
    if Response(i)~=3
        Res_3(i)=0;
    end
end
TP=zeros(1,3);
FP=zeros(1,3);
TN=zeros(1,3);
FN=zeros(1,3);
%colum 1 is 12;colum 2 is 13;colum 3 is 23
for i=1:num
    if Pre(i)==1 && Res(i)==1
        TP(1)=TP(1)+1;
    end
    if Pre(i)==2 && Res(i)==1
        FN(1)=FN(1)+1;
    end
    if Pre(i)==1 && Res(i)==2
        FP(1)=FP(1)+1;
    end
    if Pre(i)==2 && Res(i)==2
        TN(1)=TN(1)+1;
    end
end
for i=1:num
    if Pre(i)==1 && Res(i)==1
        TP(2)=TP(2)+1;
    end
    if Pre(i)==3 && Res(i)==1
        FN(2)=FN(2)+1;
    end
    if Pre(i)==1 && Res(i)==3
        FP(2)=FP(2)+1;
    end
    if Pre(i)==3 && Res(i)==3
        TN(2)=TN(2)+1;
    end
end
for i=1:num
    if Pre(i)==2 && Res(i)==2
        TP(3)=TP(3)+1;
    end
    if Pre(i)==3 && Res(i)==2
        FN(3)=FN(3)+1;
    end
    if Pre(i)==2 && Res(i)==3
        FP(3)=FP(3)+1;
    end
    if Pre(i)==3 && Res(i)==3
        TN(3)=TN(3)+1;
    end
end
TP_avg=(TP(1)+TP(2)+TP(3))/3;
FN_avg=(FN(1)+FN(2)+FN(3))/3;
FP_avg=(FP(1)+FP(2)+FP(3))/3;
TN_avg=(TN(1)+TN(2)+TN(3))/3;
precision=TP_avg/(TP_avg+FP_avg);
end