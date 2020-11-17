#######################################
###### CLEAN AND TRANSFORM DATA #######
#######################################

setwd("~/GitHub/Data_Science/R_Projects")

#use read.table since its tab-delimited
movies <- read.table(
  file = "Movies.txt",
  sep = "\t",
  header = TRUE,
  quote = "\""
)
head(movies)
names(movies)

#rename a column
names(movies)[5] <- "Critic.Score"

#DEAL WITH MISSING VALUES
# count missing values
sum(is.na(movies))

#missing values were intentionally placed at end of set
tail(movies)

#exclude rows with NA values
movies <- na.omit(movies)
sum(is.na(movies))

#deal with runtime units (units listed with numbers, can't do math on strings)
head(movies$Runtime)

#determine class type
class(movies$Runtime)

#change from "factor" to string
runtimes <- as.character(movies$Runtime)

#eliminate the "min"
runtimes <- sub(" min", "", runtimes)
head(runtimes)

#change to integer
movies$Runtime <- as.integer(runtimes)
head(movies$Runtime)
class(movies$Runtime)

#make sure all units are the same
head(movies$Box.Office)
head(movies$Box.Office, n=20)

#create a function to fix all the issues with this unit (scale, $ sign, etc)
convertBoxOffice <- function(boxOffice) {
  stringBoxOffice <- as.character(boxOffice)
  replacedBoxOffice <- gsub("[$|k|M]", "", stringBoxOffice)
  numericBoxOffice <- as.numeric(replacedBoxOffice)
  if(grepl("M", boxOffice)) {
    numericBoxOffice
  }
  else if(grepl("k", boxOffice)) {
    numericBoxOffice * 0.001
  }
  else {
    numericBoxOffice * 0.000001
  }
}
#now apply the function
movies$Box.Office <- sapply(movies$Box.Office, convertBoxOffice)
head(movies$Box.Office)
class(movies$Box.Office)
mean(movies$Box.Office)

#save data into a csv file
write.csv(movies, "Movies.csv")

############################################
###### CALCULATING DESCRIPTIVE STATS #######
############################################

movies <- read.csv(
  file = "Movies.csv",
  quote = "\""
)

genres <- read.csv("Genres.csv", quote = "\"")

head(genres)
head(movies)

### Univariate Qualitative analysis ###
table(movies$Rating)
table(genres$Genre)

#Univariate Quantitative
mean(movies$Runtime)
median(movies$Runtime)
which.max(table(movies$Runtime))
#returns most frequent value and index it appears (?)

#analyze spread of variables
min(movies$Runtime)
max(movies$Runtime)
range(movies$Runtime)
diff(range(movies$Runtime))
quantile(movies$Runtime)
quantile(movies$Runtime, .25)
quantile(movies$Runtime, .9)
IQR(movies$Runtime)
var(movies$Runtime)
sd(movies$Runtime)

#Analyze shape of the data (skewness and kurtosis)
install.packages("moments")
library(moments)
skewness(movies$Runtime)
# positive = right skew, negative = left skew
kurtosis(movies$Runtime)
# 3 = normal, less = flatter, more = steeper
#plot it and take a look
plot(density(movies$Runtime))

#summarize a quantitative variable
summary(movies$Runtime)

### BiVariate Analysis ###

#for two Qualitative variables
table(genres$Genre, genres$Rating)

#for two Quantitative variables
#Covariance (can't be correlated)
cov(movies$Runtime, movies$Box.Office)
cov(movies$Critic.Score, movies$Box.Office)

#Correlation Coefficient
cor(movies$Runtime, movies$Box.Office)
cor(movies$Critic.Score, movies$Box.Office)
#runtime correlation is stronger (but both are small)

#BiVariate analysis for both a qualitative and quantitative variable
tapply(movies$Box.Office, movies$Rating, mean)
tapply(genres$Box.Office, genres$Genre, mean)

#summarize entire table
summary(movies)

#################################
###### DATA VISUALIZATION #######
#################################

head(movies)
head(genres)
tail(movies)

#Univariate Visualizations for qualitative variables

#bar graph of rating observations
plot(movies$Rating)    ###this is the section of code I cannot get to work

#create a pie chart of rating observations
pie(table(movies$Rating))

#univariate visualizations for quantitative variables

#create a dot plot of runtime
plot(
  x = movies$Runtime,
  y = rep(0, nrow(movies)), #set all y to 0 so all values on a line
  ylab = "",
  yaxt = "n")     #turns off axis labels and tick marks

#create a box plot of the same data
boxplot(
  x = movies$Runtime,
  xlab = "Runtime (minutes)",
  horizontal = TRUE)

#Create a histogram of runtimes
hist(movies$Runtime)
hist(
  x = movies$Runtime,
  breaks = 10) #change number of bins
hist(
  x = movies$Runtime,
  breaks = 30)

#create density plot
plot(density(movies$Runtime))

#add the dot plot to this graph
points(                 #adds points of interest to graph
  x = movies$Runtime,
  y = rep(-0.0005, nrow(movies))
)

#bivariate visualizations for qualitative variables

#Create a spine plot of genre and rating
#this does not work for me
spineplot(
  x = factor(genres$Genre),
  y = factor(genres$Rating))

#create a mosaic plot of genre and rating
mosaicplot(
  x = table(
    genres$Genre,
    genres$Rating),
  las = 3)

#Bivariate visualizations for quantitative variables

#create scatter plot of runtime and box office
plot(
  x = movies$Runtime,
  y = movies$Box.Office)

#create scatter plot of critic score and box office
plot(
  x = movies$Critic.Score,
  y = movies$Box.Office)
#neither seem to have a very strong correlation

#plot a line graph of count of movies by year
plot(
  #set x = the frequency table of movies by year
  x = table(movies$Year),
  type = "l")
#sharp drop off is bc some arent included in the data set

#bivariate viz for one qualitative and one quantitative variable

#create a bar graph of average box office by rating
barplot(tapply(movies$Box.Office, movies$Rating, mean))

#create a bar graph of avg box office by genre
barplot(
  height = tapply(genres$Box.Office, genres$Genre, mean),
  las = 3)

#plot bivariate box plots of box office by rating
plot(
  x = factor(movies$Rating),
  y = factor(movies$Box.Office))
#should see multiple box and whiskers plot but this one also does not work

#summarizing and entire table

#create a scatterplot matrix
plot(movies)

#cleaning up data visualizations
#create bar chart with defaults
plot(factor(movies$Rating))

#clean up the bar chart
plot(
  x = factor(movies$Rating),
  main = "Count of Movies by Rating",
  xlab = "Rating Category",
  ylab = "Count of Movies",
  col = "#b3cde3")

###############################
###### BEYOND R AND EDA #######
###############################

#Linear Regression Analysis
data(iris)
head(iris)

#look at unique species
unique(iris$Species)

#create scatterplot matrix
plot(iris[1:4])

plot(
  x = iris$Petal.Length,
  y = iris$Petal.Width)

#create linear regression model
x <- iris$Petal.Length
y <- iris$Petal.Width
model <- lm(y ~ x)
#draw linear regression on plot
lines(
  x = iris$Petal.Length,
  y = model$fitted,
  col = "red",
  lwd = 3)
#get correlation coefficients
cor(
  x = iris$Petal.Length,
  y = iris$Petal.Width)
#coefficient is very high
#summarize the model
summary(model)

#predict new unknown values from model
predict(
  object = model,
  newdata = data.frame(x = c(2, 5, 7))
)
#name of the predictor variable here (x) must be the same as in model formula

### ML - Cluster Analysis - K-means ###

#create scatter plot with species differentiated by color
plot(
  x = iris[1:4],
  col = as.integer(iris$Species))

#view scatterplot of petal length vs width
plot(
  x = iris$Petal.Length,
  y = iris$Petal.Width,
  col = as.numeric(iris$Species)
)
#create k-means clusters
clusters <- kmeans(
  x = iris[, 1:4],
  centers = 3,     #number of clusters is already known here
  nstart = 10)     #restarts 10 times

#plot each cluster as a shape
plot(
  x = iris$Petal.Length,
  y = iris$Petal.Width,
  col = as.numeric(iris$Species),
  pch = clusters$cluster      #this plots a dif shape for the predicted values
)
#plot the centroids
points(
  x = clusters$centers[, "Petal.Length"],
  y = clusters$centers[, "Petal.Width"],
  pch = 4,
  lwd = 4,
  col = "blue"
)
#view a table of the clusters
table(
  x = clusters$cluster,
  y = iris$Species
)
