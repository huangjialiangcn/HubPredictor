# HubPredictor v1.0 beta

**Overview**

HubPredictor is the R function to run Bayesian Additive Regression Trees (BART) model for predicting chromatin interactions hubs using histone marks information. HubPredictor can also be used to predict topologically associated domain (TAD) boundaries.

**Systems Requirements**

HubPredictor was written in R language. It required the R package bartMachine, which is available in http://cran.r-project.org/web/packages/bartMachine/index.html.

**Usage**

Unzip the package. Change the current directory in R to the folder containing the scripts.
HubPredictor.R is the R function to run BART model for predicting chromatin interactions hubs using histone marks information. HubPredictor contains two main steps: (1) read TrainingSet data & build BART regression model; (2) read input data & prediction using trained BART model. It takes three parameters: (1) file_in <required> is the input file containing histone marks density for each chromatin anchors; (2) file_out <required> is the output file, which generated the prediction information; (3) file_trainingset [optional] is an the dataset for training the BART model, which takes the file 'TrainingSet/Hub.txt' by default.

**Example**

> source("HubPredictor.R")

> HubPredictor(file_in='input.txt',file_out='output.txt',file_trainingset = 'TrainingSet/Hub.txt')

**File Format**

*(1) file_in*

A tab-delimited text file provides histone marks density for each chromatin anchors information, which were used as input for model prediction. Specifically, given a chromatin anchor, we summarized the local pattern for each histone mark by averaging the sequence reads over a 300kb window (about twice the average distance between an anchor and its target site) centered at the anchor location. It can be calculated  using Bedtools coverage. 
![image](https://cloud.githubusercontent.com/assets/13242871/8606605/b9311386-265a-11e5-91fb-5040ed6da366.png)

*(2) file_out*

A tab-delimited text file provides the prediciton information (in red), where group represents class predictions, and probability represents probability predictions.
![image](https://cloud.githubusercontent.com/assets/13242871/8606611/be8c17fe-265a-11e5-9185-b0aef3e41fc7.png)
 
*(3) file_trainingset*

A tab-delimited text file provides the training dataset to build BART model, which includes histone marks density of each chromatin anchor (same as file_in) and a column containing the group information. By default, the code will use the hubs defined based on the Hi-C dataset used in our paper ('TrainingSet/ Hub.txt'), which is used in our paper, to build BART model. User can define the hubs based on Hi-C dataset according to the method described in our paper. For TAD boundaries prediction, we also provided the TAD boundaries defined in the Hi-C dataset used in our paper ('TrainingSet/TADBoundary.txt'), to build BART model.
![image](https://cloud.githubusercontent.com/assets/13242871/8606617/c57cb190-265a-11e5-8c96-244d1afdae8e.png)

**Reference**

J. Huang, E. Marco, L. Pinello, G.C. Yuan. Predicting chromatin organization using histone marks. Genome Biology. 2015.

**Contact**

Jialiang Huang (jhuang at jimmy.harvard.edu or huangjialiangcn at gmail.com)





