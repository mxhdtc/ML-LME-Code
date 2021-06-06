%Macro_average
% input: testPredictions,testResponse
% output: Macro_F is macro average
function [Macro_F]=Macro_average(testPredictions,testResponse)
Predictions=testPredictions;
Response=testResponse;
[num,m]=size(Predictions);
TP=zeros(1,3);
FP=zeros(1,3);
TN=zeros(1,3);
FN=zeros(1,3);
Pre=Predictions;
Res=Response;
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

F_1=zeros(1,3);
P=zeros(1,3);
R=zeros(1,3);
for i=1:3
    P(i)=TP(i)/(TP(i)+FP(i));
    R(i)=TP(i)/(TP(i)+FN(i));
end
macro_P=0;
macro_R=0;
for i=1:3
    macro_P=macro_P+P(i);
    macro_R=macro_R+R(i);
end
macro_P=macro_P/3;
macro_R=macro_R/3;
Macro_F=2*macro_P*macro_R/(macro_P+macro_R);

end


