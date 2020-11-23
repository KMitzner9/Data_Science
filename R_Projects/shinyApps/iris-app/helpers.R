iris <- read.csv("Iris.csv")
data(iris)
head(iris)
?data

#inspect the different species 
unique(iris$Species)

str(iris)

class(iris)
#create tables for each species
setosa <- iris[iris$Species == "setosa",]
head(setosa)
versicolor <- iris[iris$Species == "versicolor",]
head(versicolor)
virginica <- iris[iris$Species == "virginica", ]

### SETOSA ###
#create some scatter plots to view sepal length vs width and petal LxW
plot(
  x = setosa$Sepal.Length,
  y = setosa$Sepal.Width,
  main = "Setosa: Sepal Length vs Sepal Width",
  xlab = "Sepal Length",
  ylab = "Sepal Width")

#draw regression line
model <- lm(setosa$Sepal.Width ~ setosa$Sepal.Length)
lines(
  x = setosa$Sepal.Length,
  y = model$fitted,
  col = "red",
  lwd = 3)

#petal length vs width
#create some scatter plots to view sepal length vs width and petal LxW
plot(
  x = setosa$Petal.Length,
  y = setosa$Petal.Width,
  main = "Setosa: Petal Length vs Petal Width",
  xlab = "Petal Length",
  ylab = "Petal Width")

#draw regression line
model <- lm(setosa$Petal.Width ~ setosa$Petal.Length)
lines(
  x = setosa$Petal.Length,
  y = model$fitted,
  col = "red",
  lwd = 3)
