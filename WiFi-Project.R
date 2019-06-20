##################################################################################################
#                                                                                                #
#     								Project Description                                          # 
#                                                                                                #
#           Many real world applications need to know the localization of a user in the world to # 
#           provide their services. So, automatic user localization has been a hot research topic# 
#			in the last years.																	 #	
#																								 #			
#			The goal of the project is to build an machine learning model  which will be able    #
#           to predict the location of an user inside the university Universitat Jaume, Spain.   # 
#           For that, the model will use RSSI signal strength received by mobile handsets of the #
#           users in 3 buildings. 															     #		
#           Total number of attributes : 529 													 #
#           1st 520 attributes are RSSI signal intensity. Rests are Longitude, Latitude, Floor,  #
#           Building ID, Space ID etc.                                                           #
#                                                    											 #	
#           This piece of code (1st module) will load the data and perform preprocessing.        #                                                                                      
#																								 #
#           Version: 1.0                                                                         #
#          																						 #
#		    Author : Ghazaleh Zamani															 #
#																								 #
#           Date:    12/10/2018 																 #
#																								 #
##################################################################################################											           

#CODE STRUCTURE###
#============================================================================#
#/////////LOADING LIBRARIES                                                  #
#============================================================================#
#/////////SET DIRECTORY, IMPORT DATA
#============================================================================#
#/////////DATA PREPROCESSING (Done on both original and validation datasets)
#         -Change 100 values to -105.
#         -Take out all columns and rows that have only -105 (missing RSSI).
#         -Removing Columns with Near Zero Variance
#         -Normalizing by rows.
#         -Doing PCA (we get 127 PCs).
#============================================================================#


### LOADING LIBRARIES  ###

library(plotly)                                                               # visualization 
library(ggplot2)                                                              # visualization
library(rworldmap)                                                            # mapping world map
library(anytime)                                                              # conversion of time
library(dplyr)                                                                # exploratory data analysis
library(scales)                                                               # map data to aesthetics
library(data.table)                                                           # subsetting row, column
library(caret)																  # data preprocessing	

### loading the Training/Validation data set ###

IndoorLoc <- read.csv("trainingData.csv")
IndoorVal <- read.csv("validationData.csv")

### Data exploration ###

summary(IndoorLoc)
str(IndoorLoc[ncol(IndoorLoc) - 8:ncol(IndoorLoc)])
str(IndoorVal[ncol(IndoorVal) - 8:ncol(IndoorVal)])

### Changing the attribute types ###

IndoorLoc$FLOOR <- as.factor(IndoorLoc$FLOOR)
IndoorVal$FLOOR <- as.factor(IndoorVal$FLOOR)
IndoorLoc$BUILDINGID <- as.factor(IndoorLoc$BUILDINGID)
IndoorVal$BUILDINGID <- as.factor(IndoorVal$BUILDINGID)
IndoorLoc$SPACEID <- as.factor(IndoorLoc$SPACEID)
IndoorVal$SPACEID <- as.factor(IndoorVal$SPACEID)
IndoorLoc$RELATIVEPOSITION <- as.factor(IndoorLoc$RELATIVEPOSITION)
IndoorVal$RELATIVEPOSITION <- as.factor(IndoorVal$RELATIVEPOSITION)
IndoorLoc$USERID <- as.factor(IndoorLoc$USERID)
IndoorVal$USERID <- as.factor(IndoorVal$USERID)
IndoorLoc$PHONEID <- as.factor(IndoorLoc$PHONEID)
IndoorVal$PHONEID <- as.factor(IndoorVal$PHONEID)
IndoorLoc$TIMESTAMP <- anytime(IndoorLoc$TIMESTAMP, tz = "GMT")
IndoorVal$TIMESTAMP <- anytime(IndoorVal$TIMESTAMP, tz = "GMT")



##############################################################################        
#                         PREPROCESSING                                      #
#                                                                            #
# The preprocessing has been applied to both training and validation set.    #
#																			 #
##############################################################################
 
### RSSI signal strength '100' means there is no signal
### Therefore RSSI signal values are changed from '100' to '-105' dBm

IndoorLoc[IndoorLoc==100]<- -105
IndoorVal[IndoorVal==100]<- -105



#Taking columns that contain only -105 out.

# Training DataSet

noSignal <- (as.data.frame(lapply((apply(IndoorLoc, 2, max)), function(x)
  {ifelse (x == -105, TRUE, FALSE)})))
  
IndoorLoc <- IndoorLoc[,!noSignal]

# Validation DataSet

noSignal <- NULL
noSignal <- (as.data.frame(lapply((apply(IndoorVal, 2, max)), function(x)
  {ifelse (x == -105, TRUE, FALSE)})))
  
IndoorVal <- IndoorVal[,!noSignal]


#Taking out rows that have no WAP measurements

# Training DataSet

IndoorLoc <- IndoorLoc[apply(IndoorLoc[,1:(ncol(IndoorLoc)-9)], 1, function(x) 
  {ifelse(max(x) == -105, FALSE, TRUE)}),]

# Validation DataSet

IndoorVal <- IndoorVal[apply(IndoorVal[,1:(ncol(IndoorVal)-9)], 1, function(x) 
  {ifelse(max(x) == -105, FALSE, TRUE)}),]
  
  



### Remove columns with Near Zero variance

# Number of columns with near zero variance 

sum(nearZeroVar(IndoorLoc[,1:(ncol(IndoorLoc) - 9)], 
+                         saveMetrics = TRUE, uniqueCut = 0.015)$nzv)

IndoorLoc <- IndoorLoc[ ,  (nearZeroVar(IndoorLoc[,1:(ncol(IndoorLoc) - 9)], 
										saveMetrics = TRUE, uniqueCut = 0.01)$nzv)]

training1<- IndoorLoc[-(which(apply(IndoorLoc[,1:ncol(IndoorLoc) - 9],2,var)==0))]
validation1<- IndoorVal[-(which(apply(IndoorVal[,1:520],2,var)==0))]
str(training1[466:475])
str(validation1[368:376])

## Eliminating meaningless_wap data & USER 6
training2<- training1[which(training1$USERID !=6),]
train2$BUILDINGID<- as.factor(train2$BUILDINGID)

training2<- training2%>% mutate(WAP_105to30=apply(training2[,1:465], 1, function(x) !(TRUE %in% (x > -30 & x <= 0))))
training2<- training2[which(training2$WAP_105to30 == "TRUE"),]

#WAP_train3<- train3[,1:520]

## UNique rows
training2<- unique(training2)

#creating df to normalize without the rows with standard deviation = 0, so it doesn't get NaNs
training2 <- training2[which(apply(training2[, 1:465], 1, sd) != 0),]

validation2<- validation1
validation2<- validation2[which(apply(validation2[,1:367],1,sd)!=0),]

### Matching validation data with training data, vice versa and create new dfs
training2 <- training2[, which(names(training2) %in% names(validation2))]
validation2<- validation2[, which(names(validation2)%in% names(training2))]


### Eliminating not needed columns for Machine Learning
# just use Building ID
trainsetBI<- training2
trainsetBI<- trainsetBI[,1:316]

trainsetBI$LONGITUDE<- NULL
trainsetBI$LATITUDE<- NULL
trainsetBI$FLOOR<- NULL

testsetBI<- validation2
testsetBI<- validation2[,1:316]

testsetBI$LONGITUDE<- NULL
testsetBI$LATITUDE<- NULL
testsetBI$FLOOR<- NULL

#### Normalizing trainset and testsets in rows ####

trainsetBI[,1:312]<-t(apply(trainsetBI[,1:312],1, function(x)((x)- min(x))/(max(x)- min(x))))
testsetBI[,1:312]<- t(apply(testsetBI[,1:312],1,function(x)((x)- min(x))/(max(x)- min(x))))


sum(is.na(trainsetBI))
summary(trainsetBI)
