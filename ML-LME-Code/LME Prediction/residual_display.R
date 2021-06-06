######
# title: "R Notebook::using LME to predict fresh weight of rice "
#output: "LME fitting results"
#html_document:
#  df_print: paged
######
  
#  This is an [R Markdown](http://rmarkdown.rstudio.com) Notebook. When you execute code within the notebook, the results appear beneath the code. 

#Try executing this chunk by clicking the *Run* button within the chunk or by placing your cursor inside it and pressing *Cmd+Shift+Enter*. 

#  loading required  packages
library(readr)
library(PerformanceAnalytics)
library(lmerTest)
library(MuMIn)
library(car)
attach(iris)
library(ISLR) 
library(leaps)
library(ggplot2)

#  import rice phenotype and fractal dimensions data
data<-read_csv("~/Desktop/rice_phenotype/rice_data.CSV")
data1 <- data[, c('PW','PH(V)','PH(V)/PW', 'PH', 'PH/PW', 'SA', 'IFD', 'SFD', 'G_g', 'f1', 'f2', 'f3', 'f4', 'f5', 'f6', 'f7', 'f8', 'f9', 'f10', 'f11', 'f12', 'LD1', 'LD2', 'LD3', 'LD4', 'LD5', 'LD6', '鲜重(g)', '干重(g)', '株高(cm)', '绿叶面积(mm2)')]
names(data1) <- c('PW','PH(V)','PH(V)/PW', 'PH', 'PH/PW', 'SA', 'IFD', 'SFD', 'G_g', 'f1', 'f2', 'f3', 'f4', 'f5', 'f6', 'f7', 'f8', 'f9', 'f10', 'f11', 'f12', 'LD1', 'LD2', 'LD3', 'LD4', 'LD5', 'LD6', 'fresh_weight', 'dry_weight', 'plant height', 'green_leaf_area')  # translate the variable name into English

#  translate the variable name into English
fresh_weight = data$`鲜重(g)`
dry_weight = data$`干重(g)`
plant_height = data$`株高(cm)`
green_leaf_area = data$`绿叶面积(mm2)`
PH_V = data$`PH(V)`
data1 <- data.frame(
  ID = c(1:length(data$ID)),
  fresh_weight = dry_weight,
  dry_weight = dry_weight,
  plant_height = plant_height,
  green_leaf_area = green_leaf_area,
  stage = data$stage, 
  frac = data$frac, 
  frac_stage = data$frac_stage,
  PH_V = PH_V, 
  SA = data$SA,
  G_g = data$G_g, 
  PH = data$PH,
  PH_PW = data$`PH/PW`,
  f1 = data$f1,
  LD1 = data$LD1,
  PW = data$PW, 
  SFD = data$SFD,
  SandBox = data$SandBox,
  D1 = data$D1, 
  D2 = data$D2,
  RFD = data$RFD,
  frac_SFD = data$frac_SFD,
  frac_SandBox = data$frac_SandBox,
  frac_D1 = data$frac_D1,
  frac_D2 = data$frac_D2,
  frac_RFD = data$frac_RFD,
  stringsAsFactors=TRUE
)

# fitting rice fresh weight using RFD hierarchies
# using LME with random slope fitting rice data
# using LME only considering random Intercept
modelzero=lmer(formula = log(fresh_weight)~log(PH_V)+log(SA)+log(G_g)+log(f1)+log(LD1)+log(PW)+log(RFD)+(1|frac_RFD),data=data1)
r.squaredLR(modelzero)
res_RFD <- residuals(modelzero)
OutVals = boxplot(res_RFD)$out
which(res_RFD %in% OutVals)
res_RFD <- res_RFD[!res_RFD %in% OutVals]  # Remove outliers


# fitting rice fresh weight using DBC2 hierarchies
# using LME with random slope fitting rice data
# using LME only considering random Intercept
modelzero=lmer(formula = log(fresh_weight)~log(PH_V)+log(SA)+log(G_g)+log(f1)+log(LD1)+log(PW)+log(D2)+(1|frac_D2),data=data1)
r.squaredLR(modelzero)
res_DBC2 <- residuals(modelzero)
OutVals = boxplot(res_DBC2)$out
which(res_DBC2 %in% OutVals)
res_DBC2 <- res_DBC2[!res_DBC2 %in% OutVals]  # Remove outliers


# fitting rice fresh weight using DBC1 hierarchies
# using LME with random slope fitting rice data
# using LME only considering random Intercept
modelzero=lmer(formula = log(fresh_weight)~log(PH_V)+log(SA)+log(G_g)+log(f1)+log(LD1)+log(PW)+log(D1)+(1|frac_D1),data=data1)
r.squaredLR(modelzero)
res_DBC1 <- residuals(modelzero)
OutVals = boxplot(res_DBC1)$out
which(res_DBC1 %in% OutVals)
res_DBC1 <- res_DBC1[!res_DBC1 %in% OutVals]  # Remove outliers


# fitting rice fresh weight using SFD hierarchies
# using LME with random slope fitting rice data
# using LME only considering random Intercept
modelzero=lmer(formula = log(fresh_weight)~log(PH_V)+log(SA)+log(G_g)+log(f1)+log(LD1)+log(PW)+log(SFD)+(1|frac_SFD),data=data1)
r.squaredLR(modelzero)
res_SFD <- residuals(modelzero)
OutVals = boxplot(res_SFD)$out
which(res_SFD %in% OutVals)
res_SFD <- res_SFD[!res_SFD %in% OutVals]  # Remove outliers

# fitting rice fresh weight using SandBox hierarchies
# using LME with random slope fitting rice data
# using LME only considering random Intercept
modelzero=lmer(formula = log(fresh_weight)~log(PH_V)+log(SA)+log(G_g)+log(f1)+log(LD1)+log(PW)+log(SandBox)+(1|frac_SandBox),data=data1)
r.squaredLR(modelzero)
res_SandBox <- residuals(modelzero)
OutVals = boxplot(res_SandBox)$out
which(res_SandBox %in% OutVals)
res_SandBox <- res_SandBox[!res_SandBox %in% OutVals]  # Remove outliers

linear_model=lm(formula = log(fresh_weight)~log(PH_V)+log(SA)+log(G_g)+log(f1)+log(LD1)+log(PW), data=data1)
r.squaredLR(linear_model)
res_Linear <- residuals(linear_model)
OutVals = boxplot(res_Linear)$out
which(res_Linear %in% OutVals)
res_Linear <- res_Linear[!res_Linear %in% OutVals]  # Remove outliers


res_fram <- data.frame(Resduals = c(res_SFD, res_SandBox, res_DBC1, res_DBC2, res_RFD, res_Linear), 
                       Model=c(rep('Mixed Model: SS2', times=length(res_SFD)),
                               rep('Mixed Model: SS1', times=length(res_SandBox)),  rep('Mixed Model: SD2', times=length(res_DBC1)), 
                               rep('Mixed Model: SD1', times=length(res_DBC2)), rep('Mixed Model: SR', times=length(res_RFD)), rep('Model: Linear', times=length(res_Linear))))
res_fram.names <- c('Resduals', 'Model')
head(res_fram)

#p <- ggplot(data = res_fram, mapping = aes(
#  x = Model, y = Resduals))
#p + geom_jitter(width = 0.06, height = 0.05, alpha = 0.15)
#p+ geom_boxplot() + theme(axis.text = element_text(size = 8)) + scale_y_continuous(limits=c(-0.4, 0.4), breaks=NULL)


p <- ggplot(data = res_fram, mapping = aes(
  x = Resduals, color = Model, fill = Model))
p + geom_density(alpha = 0.4)


shapiro.test(res_Linear)
shapiro.test(res_SandBox)