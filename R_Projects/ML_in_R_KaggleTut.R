#############################
### MACHINE LEARNING IN R ###
#############################

library(tidyverse)
library(reshape2)
housing = read.csv('housing.csv')
head(housing)

#check the summary to make sure #s are #s and categoricals are categoricals
summary(housing)

### from this we can see...
# NAs in total_bedrooms that need to be addressed
# Feature encoding for ocean_proximity (even though R can often handle this)
# make total_bedrooms and total_rooms into mean columns instead

par(mfrow=c(2,5))
colnames(housing)

#take a look at the variables
ggplot(data = melt(housing), mapping = aes(x = value)) +
  geom_histogram(bins = 30) + facet_wrap(~variable, scales = 'free_x')

### from this we can see...
# some housing blocks have old age homes
# there is a cap on the median house value that may affect the data
# we need to standardize numeric scales for an non-tree based methods


                  ##### CLEANING THE DATA #####

#impute missing values
#fill with median bc less influenced by outliers
housing$total_bedrooms[is.na(housing$total_bedrooms)] = 
  median(housing$total_bedrooms, na.rm = TRUE)
summary(housing)

#change total columns to mean columns
housing$mean_bedrooms = housing$total_bedrooms/housing$households
housing$mean_rooms = housing$total_rooms/housing$households
#drop the old columns, create variables drops with the column names
drops = c('total_bedrooms', 'total_rooms')
#update housing such that it excludes those columns
housing = housing[ , !(names(housing) %in% drops)]
head(housing)

#turn categoricals into booleans
#get a list of all the categories in ocean_proximity col
categories = unique(housing$ocean_proximity)
categories
#split the categories off
#create a new df which is a list of all the values in col ocean_prox
cat_housing = data.frame(ocean_proximity = housing$ocean_proximity)
cat_housing
#use for loop to populate the df with columns and 0 values
for(cat in categories) {
  cat_housing[,cat] = rep(0, times = nrow(cat_housing))
}
head(cat_housing)
#use for loop to populate df with binary values
for(i in 1:length(cat_housing$ocean_proximity)) {
  cat = as.character(cat_housing$ocean_proximity[i])
  cat_housing[,cat][i] = 1
}
head(cat_housing)
tail(cat_housing)
#dropping the OG column
cat_columns = names(cat_housing)
keep_columns = cat_columns[cat_columns != 'ocean_proximity']
cat_housing = select(cat_housing, one_of(keep_columns))
tail(cat_housing)

### Followup tasks here:
# coded with a python accent, more effective route for R?
# can you make a function that could be used to split any categorical column?

#scale numerical values
#do not scale median_house_value as that will be our y variable

colnames(housing)
drops = c('ocean_proximity', 'median_house_value')
housing_num = housing[ , !(names(housing) %in% drops)]
head(housing_num)
scaled_housing_num = scale(housing_num)
head(scaled_housing_num)

#merge our altered dataframes
cleaned_housing = cbind(
  cat_housing, 
  scaled_housing_num, 
  median_house_value=housing$median_house_value)
head(cleaned_housing)


                ##### CREATE A TEST SET OF DATA #####

set.seed(1738)
sample = sample.int(
  n = nrow(cleaned_housing),
  size = floor(.8*nrow(cleaned_housing)),
  replace = F)
train = cleaned_housing[sample, ] #just the sample (80%)
test = cleaned_housing[-sample, ] #everything but sample set (20%)

#some quick checks to make sure we actually have what we want
head(train)
#check that we have the right columns and indexes are jumbled
#this checks that the length of the two sets = length of dataset
nrow(train) + nrow(test) == nrow(cleaned_housing)

              ##### TEST SOME PREDICTIVE MODELS #####

# Generalized Linear Model with cross-validation, k-folds = 5
library(boot)
?cv.glm
?glm
glm_house = glm(median_house_value ~ median_income + mean_rooms + population,
                data = cleaned_housing)
k_fold_cv_error = cv.glm(cleaned_housing, glm_house, K=5)
k_fold_cv_error$delta

glm_cv_rmse = sqrt(k_fold_cv_error$delta)[1]
glm_cv_rmse
names(glm_house) #which parts of this model can we call on?
glm_house$coefficients
#seems median income has the biggest effect

# Random Forest model
library(randomForest)
?randomForest
names(train)
set.seed(1738)

train_y = train[, 'median_house_value']
train_x = train[, names(train) != 'median_house_value']
head(train_y)
head(train_x)

#create the model (2 ways)
rf_model = randomForest(train_x,
                        y = train_y,
                        ntree = 1000,  ### HERE I CHANGED NTREE TO 1000 from 500
                        importance = TRUE)

#rf_model = randomForest(median_house_value ~ .,
                        #data = train, ntree = 500, importance = TRUE)


names(rf_model)
rf_model$importance
# %IncMSE = percent increase mean squared error
# higher this number, the more important the variable

#get out of the bag error estimate
sqrt(mean(rf_model$mse))
oob_prediction = predict(rf_model)
train_mse = mean(as.numeric((oob_prediction - train_y)^2))
oob_rmse = sqrt(train_mse)
oob_rmse # = 49,126

#now $49,126 is our benchmark for predictions, can we get smaller error?

# new value = 49,010. Slightly lower not much of a meaningful change

#how well does the model do on the test set?
test_y = test[, 'median_house_value']
test_x = test[, names(test) != 'median_house_value']

y_pred = predict(rf_model, test_x)
test_mse = mean(((y_pred - test_y)^2))
test_rmse = sqrt(test_mse)
test_rmse
#our model scored roughly the same on the test data


