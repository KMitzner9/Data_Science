#assign a character sting to variable
x <- "Hello World"
print(x)

x

#creating variables
l <- TRUE
i <- 123L
n <- 1.23
c <- "ABC 123"
d <- as.Date("2001-02-03")

#displaying variables
l
i
n
d
c

#creating a function
f<- function(x) {x + 1}

#invoke function
f(2)

#create a vector (1D array of elements with the same data type)
#c() is a concat function (?)
v <- c(1, 2, 3);
v

#creating a sequence
s <- 1:5
s

#creating a matrix
m <- matrix(
  data = 1:6,
  nrow = 2,
  ncol = 3)

m
#sort by row instead of column
m2 <- matrix(data=1:6, nrow=2, ncol=3, byrow=T)
m2

#multidimensional arrays
a <- array(
  data = 1:8,
  dim = c(2, 2, 2)
)
a

#lists can have different data types in the same object
l <- list(TRUE, 123L, 2.34, "abc")
l

#FACTORS
categories <- c("male", "female", "male", "male", "female")
factor <- factor(categories)
factor
levels(factor)
unclass(factor)

#creating a data frame
df <- data.frame(
  Name = c("cat", "dog", "cow", "pig"),
  HowMany = c(5, 10, 15, 20),
  IsPet = c(TRUE, TRUE, FALSE, FALSE))
df

#indexing by row and column
df[1, 2]

#by row
df[1,]

#by column
df[,2]

#double brackets for column name
df[["Name"]]
df$Name

#subsetting dataframes
df[c(2, 4),]
df[2:4,]
#uses logical values to indicate which rows we want returned (1 and 3 here)
df[c(TRUE, FALSE, TRUE, FALSE),]
df[df$IsPet == TRUE,]
df[df$HowMany > 10,]
df[df$Name %in% c("cat", "cow"),]

#R is a vectorized programming language
1 + 2
c(1, 2, 3) + c(2, 4, 6)

#named vs ordered parameters - 2 ways to structure arguments
m <- matrix(data = 1:6, nrow = 2, ncol = 3)
n <- matrix(1:6, 2, 3)
m == n             #returns matrix 
identical(m, n)    #returns single T or F

#installing packages
install.packages("dplyr")
library("dplyr")
#viewing help
?data.frame

#read tab-delimited data file
cars <- read.table(
  file = "Cars.txt",
  header = TRUE,
  sep = "\t",
  quote = "\"")

head(cars)

#select a subset of columns
temp <- select(
  .data = cars,
  Transmission,
  Cylinders,
  Fuel.Economy
)
head(temp)

#filter a subset of row
temp <- filter(
  .data = temp,
  Transmission == "Automatic"
)
head(temp)

#compute a new column - change mi/gal into metric
temp <- mutate(
  .data = temp,
  Consumption = Fuel.Economy * 0.425
)
head(temp)

#group by a column
temp <- group_by(
  .data = temp,
  Cylinders
)
head(temp)

#aggregate data based on groups (this may be outdated)
temp <- summarize(
  .data = temp,
  Avg.Consumption = mean(Consumption)
)
head(temp)

#arrange rows in descending order so that the most efficient is at the top
temp <- arrange(
  .data = temp,
  desc(Avg.Consumption)
)
head(temp)

#convert tibble back into dataframe
efficiency <- as.data.frame(temp)
print(efficiency)

#chain methods together using piping function: %>%
efficiency <- cars %>%
  select(Fuel.Economy, Cylinders, Transmission) %>%
  filter(Transmission == "Automatic") %>%
  mutate(Consumption = Fuel.Economy * 0.425) %>%
  group_by(Cylinders) %>%
  summarize(Avg.Consumption = mean(Consumption)) %>%
  arrange(desc(Avg.Consumption)) %>%
  as.data.frame()
print(efficiency)

#save results to a csv file
write.csv(
  x = efficiency,
  file = "Fuel_Efficiency.csv",
  row.names = FALSE
)

####### DESCRIPTIVE STATISTICS IN R ########

#read csv
cars <- read.csv("Cars.csv")
head(cars)

#how many cars of each transmission type - create frequency table
table(cars$Transmission)

## fuel economy dispersion characteristics
#get minimum value
min(cars$Fuel.Economy)

#get max values
max(cars$Fuel.Economy)

#get average value
mean(cars$Fuel.Economy)

#get median
median(cars$Fuel.Economy)

#get quartiles
quantile(cars$Fuel.Economy)

#get standard deviation
sd(cars$Fuel.Economy)

#sum of values
sum(cars$Fuel.Economy)

#get correlation coefficient
cor(
  x = cars$Cylinders,
  y = cars$Fuel.Economy
)

#summarize an entire table of values (i get different output)
summary(cars)
summary(cars$Transmission)


####### CREATING DATA VISUALIZATIONS ########

#load ggplot2 library
#install.packages("ggplot2")
library(ggplot2)
cars <- read.csv("Cars.csv")
head(cars)

#create a frequency bar chart
ggplot(
  data = cars,
  aes(x = Transmission)) +
  geom_bar() +
  ggtitle("Count of Cars by Transmission Type") +
  xlab("Transmission Type") +
  ylab("Count")

head(cars)
#create histogram - distribution of fuel economy
ggplot(
  data = cars,
  aes(x = Fuel.Economy)) +
  geom_histogram(bins = 20) +
  ggtitle("Distribution of Fuel Economy") +
  xlab("Fuel Economy (mpg)") +
  ylab("Count of Cars")


#create a density plot
ggplot(
  data = cars,
  aes(x = Fuel.Economy)) +
  geom_density() +
  ggtitle("Distribution of Fuel Economy") +
  xlab("Fuel Economy (mpg)") +
  ylab("Density")

cars
#create a scatter plot
ggplot(
  data = cars,
  aes(x = Cylinders,
      y = Fuel.Economy)) +
  geom_point() +
  ggtitle("Fuel Economy by Cylinders") +
  xlab("Number of Cylinders") +
  ylab("Fuel Economy (mpg)")
cars  


###### CREATING STATISTICAL MODELS #######

iris = read.csv('Iris.csv')
head(iris)
data(iris)
head(iris)

#create scatter plot of petal length and petal width
plot(
  x = iris$Petal.Length,
  y = iris$Petal.Width,
  main = "Iris Petal Length vs. Width",
  xlab = "Petal Length (cm)",
  ylab = "Petal Width (cm)"
)

#create linear regression model
#formula = y ~ x (y as a function of x)
model <- lm(
  formula = Petal.Width ~ Petal.Length,
  data = iris)
#use this function to get the slope (0.416) and intercept (-0.363)
summary(model)

#draw the line on the graph
lines(
  x = iris$Petal.Length,
  y = model$fitted,
  col = 'red',
  lwd = 3
)

#get correlation coefficient (0.963)
cor(
  x = iris$Petal.Length,
  y = iris$Petal.Width
)

#Correlation is high so we can use it to predict new values
#predict new values
predict(
  object = model,
  newdata = data.frame(
    Petal.Length = c(2, 5, 7)
  )
)

###### HANDLING BIG DATA #######
#install.packages("ff")
library(ff)

#doesnt read it into memory, creates a pointer to the file
#so it can be read piece by piece instead of all stored
irisff <- read.table.ffdf(
  file = "Iris.csv",
  FUN = "read.csv"
)
#inspect class
class(irisff)
#inspect column names
names(irisff)
#view first five rows
irisff[1:5,]

#install and load biglm
#install.packages("biglm")
library(biglm)

#create linear regression model
model <- biglm(
  formula = Petal.Width ~ Petal.Length,
  data = irisff
)
#summarize the model
summary(model)

#create scatter plot
plot(
  x = irisff$Petal.Length[],
  y = irisff$Petal.Width[],
  main = "Iris Petal Length vs Width",
  xlab = "Petal Length",
  ylab = "Petal Width"
)
#get y intercept from model
b <- summary(model)$mat[1,1]
#get slope from model
m <- summary(model)$mat[2,1]
#draw regression line
lines(
  x = irisff$Petal.Length[],
  y = m*irisff$Petal.Length[] + b,
  col = 'red',
  lwd = 3
)
#predict new values with the model
#note that a location for the calculated values must be created first
predict(
  object = model,
  newdata = data.frame(
    Petal.Length = c(2, 5, 7),
    Petal.Width = c(0, 0, 0)
  )
)

####### MACHINE LEARNING #######

## Decision Tree Classifier ##

data(iris)

#set a random seed
set.seed(42)

#randomly sample 100 of 150 row indexes
#create an vector of 100 random index numbers
#from which we create the test and train sets
indexes <- sample(
  x = 1:150,
  size = 100
)
print(indexes)

#assign the test and train set
train <- iris[indexes, ]
test <- iris[-indexes, ]

#load decision tree package
#install.packages("tree")
library(tree)

#train a decision tree model
model <- tree(
  formula = Species ~ Petal.Length + Petal.Width,  #dot includes all columns
  data = train
)
summary(model)

#visualize the model
plot(model)
text(model)

library(RColorBrewer)

#create a color palette
palette <- brewer.pal(3, "Set2")

#create scatter plot
plot(
  x = iris$Petal.Length,
  y = iris$Petal.Width,
  pch = 19,
  col = palette[as.numeric(iris$Species)],
  main = "Iris Petal Length vs Width",
  xlab = "Petal Length",
  ylab = "Petal Width"
)
#plot the decision boundaries
partition.tree(
  tree = model,
  label = "Species",
  add = TRUE
)
#predict with the model
predictions <- predict(
  object = model,
  newdata = test,
  type = "class"
)
#create a confusion matrix
table(
  x = predictions,
  y = test$Species
)
#install.packages("caret")
library(caret)
#install.packages("e1071")
library(e1071)
#evaluate prediction results
confusionMatrix(
  data = predictions,
  reference = test$Species
)
save(model, file = "Tree.RData")

#create a shiny app with the decision tree model we created earlier
load("Tree.RData")
library(RColorBrewer)
library(tree)
library(shiny)

#create color palette
palette <- brewer.pal(3, "Set2")

#create UI
ui <- fluidPage(
  titlePanel("Iris Species Predictor"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(
        inputId = "petal.length",
        label = "Petal Length (cm)",
        min = 1,
        max = 7,
        value = 4),
      sliderInput(
        inputId = "petal.width",
        label = "Petal Width (cm)",
        min = 0.0,
        max = 2.5,
        step = 0.5,
        value = 1.5)),
    mainPanel(
      textOutput(outputId = "text"),
      plotOutput(outputId = "plot"))))

#create server code
server <- function(input, output) {
  output$text = renderText({
    
    #create predictors
    predictors <- data.frame(
      Petal.Length = input$petal.length,
      Petal.Width = input$petal.width,
      Sepal.Length = 0,
      Sepal.Width = 0)
    
    #make prediction
    prediction = predict(
      object = model, 
      newdata = predictors,
      type = "class")
    
    #create prediction text
    paste("The predicted species is ", as.character(prediction))
    
  })
  output$plot = renderPlot({
    
    #create scatter plot
    plot(
      x = iris$Petal.Length,
      y = iris$Petal.Width,
      pch = 19,
      col = palette[as.numeric(iris$Species)],
      main = "Iris Petal Length vs Width",
      xlab = "Petal Length",
      ylab = "Petal Width")
    #plot decision tree boundaries
    partition.tree(model,
                   label = "Species",
                   add = TRUE)
    #Draw predictor on plot
    points(
      x = input$petal.length,
      y = input$petal.width,
      col = "red",
      pch = 4,
      cex = 2,
      lwd = 2)
  })
}

shinyApp(ui = ui,
         server = server)
