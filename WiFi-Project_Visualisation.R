##################################################################################################
#                                                                                                #
#     				    Project Description                                                      # 
#                                                                                                #
#           Many real world applications need to know the localization of a user in the world to # 
#           provide their services. So, automatic user localization has been a hot research topic# 
#	        in the last years.		                                                             #															                 
#												                                                 #												                             			
#	        The goal of the project is to build an machine learning model  which will be able    #
#           to predict the location of an user inside the university Universitat Jaume, Spain.   # 
#           For that, the model will use RSSI signal strength received by mobile handsets of the #
#           users in 3 buildings. 	                                                             #														                     
#           Total number of attributes : 529 							                         #				
#                                                                                                #
#           1st 520 attributes are RSSI signal intensity. Rests are Longitude, Latitude, Floor,  #
#           Building ID, Space ID etc.                                                           #
#                                                    						                     #					 	
#           This piece of code (2nd module) will load the preprocessed data and perform          #                                                                                      
#           Visualisation.    																	 #
#           												 					                 #
#           Version: 1.0                                                                         #
#          											 											 #
#           Author : Ghazaleh Zamani	                            				             #										 
#																								 #
#           Date:    15/10/2018 							                                     #									 
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
library(caret)								      							                            # data preprocessing		





########## plotting the locations #############
LocationPlot <- ggplot(IndoorLoc, aes(x=LONGITUDE, y=LATITUDE, color = BUILDINGID)) + geom_point()
LocationPlot 


	

