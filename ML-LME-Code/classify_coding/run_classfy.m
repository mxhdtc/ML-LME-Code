%% this is coding set for classification
lastresult=zeros(4,5);
totalnum=10;
for i=1:totalnum
[BP_testAccuracy,BP_Micro_F,BP_Macro_F,BP_K,BP_precision,trainTargets,valTargets,testTargets]=BPnet(A1,d);
lastresult(1,:)=lastresult(1,:)+[BP_testAccuracy,BP_Micro_F,BP_Macro_F,BP_K,BP_precision];
[trainpredictors,trainresponses,valpredictors,valresponses,testpredictors,testresponses]=train_val_test_setget(trainTargets,valTargets,testTargets,A1,d);
[Tree_testAccuracy,Tree_Micro_F,Tree_Macro_F,Tree_K,Tree_precision]=trainClassifierTree(trainpredictors,trainresponses,valpredictors,valresponses,testpredictors,testresponses);
lastresult(2,:)=lastresult(2,:)+[Tree_testAccuracy,Tree_Micro_F,Tree_Macro_F,Tree_K,Tree_precision];
[SVM_testAccuracy,SVM_Micro_F,SVM_Macro_F,SVM_K,SVM_prcision]=trainClassifierSVM(trainpredictors,trainresponses,valpredictors,valresponses,testpredictors,testresponses);
lastresult(3,:)=lastresult(3,:)+[SVM_testAccuracy,SVM_Micro_F,SVM_Macro_F,SVM_K,SVM_prcision];
[KNN_testAccuracy,KNN_Micro_F,KNN_Macro_F,KNN_K,KNN_precision]=trainClassifier_KNN(trainpredictors,trainresponses,valpredictors,valresponses,testpredictors,testresponses);
lastresult(4,:)=lastresult(4,:)+[KNN_testAccuracy,KNN_Micro_F,KNN_Macro_F,KNN_K,KNN_precision];
end
lastresult=lastresult./totalnum;