function [trainpredictors,trainresponses,valpredictors,valresponses,testpredictors,testresponses]=train_val_test_setget(trainTargets,valTargets,testTargets,A1,d)
%%
%{
this function is to divide train,val,test set 
input:trainTargets,valTargets,testTargets (these are from BPnet.m :we need run BPnet.m ahead ) A1,d (the two indexes are from load_data.m)
output:trainpredictors,trainresponses,valpredictors,valresponses,testpredictors,testresponses
%}
step=1;
for i=1:1094
    if trainTargets(i)==1 ||trainTargets(i)==2||trainTargets(i)==3
        TrainSet(step,:)=[A1(i,:),d(i,:)];
        step=step+1;
    end
end
[m,n]=size(TrainSet);
trainpredictors=TrainSet(:,1:n-1);
trainresponses=TrainSet(:,n);
trainnum=step-1;
step=1;
for i=1:1094
    if valTargets(i)==1 ||valTargets(i)==2||valTargets(i)==3
        valSet(step,:)=[A1(i,:),d(i,:)];
        step=step+1;
    end
end
[m,n]=size(valSet);
valpredictors=valSet(:,1:n-1);
valresponses=valSet(:,n);
valnum=step-1;
step=1;
for i=1:1094
    if testTargets(i)==1 ||testTargets(i)==2||testTargets(i)==3
        testSet(step,:)=[A1(i,:),d(i,:)];
        step=step+1;
    end
end
[m,n]=size(testSet);
testpredictors=testSet(:,1:n-1);
testresponses=testSet(:,n);
testnum=step-1;
end
