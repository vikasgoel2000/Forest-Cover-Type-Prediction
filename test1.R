train<-read.csv("train.csv")
train1<-train[,(12:56)]
train1<-lapply(train1,factor)
train[,(12:56)]<-train1
# Remove column 22 as it has only one factor for all 

train<-train[,-22]
str(train)

# Remove column 29 as it has only one factor for all
train<-train[,-29]
str(train)

# Remove column 1 id not of any use

train<-train[,-1]
str(train)

fun<-function(x){
    x<-x/25
}

train[,7:9]<-sapply(train[,7:9],fun)

str(train)

library(psych)

pairs.panels(train[,1:10])

# this was to visualise the relationship between the vectors. 
#finding corelation between one and another... very imp part as 
#it help in eleminiating the multi collinearity in the dataframe and help in vector selection

library(randomForest)
# removed items with multicollinearity

mrf1<-randomForest(Cover_Type ~ Elevation+Aspect+Slope+Horizontal_Distance_To_Hydrology+Horizontal_Distance_To_Roadways+Horizontal_Distance_To_Fire_Points+Wilderness_Area1+Wilderness_Area2+Wilderness_Area3+Wilderness_Area4+Soil_Type1+Soil_Type2+Soil_Type3+Soil_Type4+Soil_Type5+Soil_Type6+Soil_Type8+Soil_Type9+Soil_Type10+Soil_Type11+Soil_Type12+Soil_Type13+Soil_Type14+Soil_Type16+Soil_Type17+Soil_Type18+Soil_Type19+Soil_Type20+Soil_Type21+Soil_Type22+Soil_Type23+Soil_Type24+Soil_Type25+Soil_Type26+Soil_Type27+Soil_Type28+Soil_Type29+Soil_Type30+Soil_Type31+Soil_Type32+Soil_Type33+Soil_Type34+Soil_Type35+Soil_Type36+Soil_Type37+Soil_Type38+Soil_Type39+Soil_Type40, data = train, ntree=600, mtry=18)

mrf1

mrf1$importance


test<-read.csv("test.csv")

str(test)

test1<-test[,(12:55)]
test1<-lapply(test1,factor)
test[,(12:55)]<-test1

# Remove column 22 as it has only one factor for all 

test<-test[,-22]
str(test)

# Remove column 29 as it has only one factor for all
test<-test[,-29]
str(test)

test1<-test[,1]

# Remove column 1 id not of any use

test<-test[,-1]
str(test)


test[,7:9]<-sapply(test[,7:9],fun)

str(test)

predict<-predict(mrf1,newdata=test)

predict<-as.data.frame(predict)

str(predict)

test1<-as.data.frame(test1)

colnames(test1)<-c("id")

str(test1)

test1$Cover_Type<-predict$predict

write.csv(test1,file="output.csv",row.names=F)

