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
