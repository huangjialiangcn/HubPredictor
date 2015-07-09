##############################################################################
# HubPredictor v1.0 beta
# HubPredictor is a R function to run Bayesian Additive Regression Trees (BART) model for predicting chromatin interactions hubs using histone marks information. 
# It can also be used to predict topologically associated domain (TAD) boundaries.
# Reference J. Huang, E. Marco, L. Pinello, G.C. Yuan. Predicting chromatin organization using histone marks. Genome Biology. 2015.
# Contact Jialiang Huang (jhuang at jimmy.harvard.edu or huangjialiangcn at gmail.com)
###############################################################################

# setwd("/Volumes/Jialiang/Project/Jialiang_3D/Work/Github/HubPredictor_v2/");  #Set Working Directory
# source("HubPredictor.R")
# HubPredictor(file_in='input.txt',file_out='output.txt',file_trainingset = 'TrainingSet/Hub.txt')

HubPredictor <- function(file_in, file_out, file_trainingset = 'TrainingSet/Hub.txt'){
  
  ### load required packages
  library("bartMachine")        
  set_bart_machine_memory(4000)

  ## part 1. read TrainingSet data & build BART regression model
  data_train <- read.delim(file=file_trainingset, skip=0, header=TRUE, check.names = FALSE,sep = "\t");
  bart_machine = bartMachine(data_train[,5:ncol(data_train)], data_train[,4])
  
  ## part 2. read input data & prediction using trained BART model
  data <- read.delim(file=file_in, skip=0, header=TRUE, check.names = FALSE,sep = "\t");
  group = predict(bart_machine, data[,4:ncol(data)], type = "class")
  probality = 1-predict(bart_machine, data[,4:ncol(data)], type = "prob")
  prediction = cbind(data,group,probality);
  write.table(prediction,file=paste(file_out,sep=''),sep='\t',quote=F,row.names = F)
  
  # destroy BART model
  destroy_bart_machine(bart_machine)
}
