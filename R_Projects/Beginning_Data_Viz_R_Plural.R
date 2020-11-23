 
#################################################
### SUPER BASIC INTRO TO THE GRAPHING SYSTEMS ###
#################################################

### Base Plotting System ###

# create a dataframe
df <- data.frame(
  Name = c("a", "b", "c"),
  Value = c(1, 2, 3)
)
df

#plot the df using default parameters
plot(factor(df))
#using default parameter order
plot(factor(df$Name), df$Value)
#using named parameters
plot(
  x = factor(df$Name),
  y = df$Value
)
#create a bar chart
barplot(
  names = df$Name,
  height = df$Value,
  col = 'skyblue',
  main = 'Hello World',
  xlab = "name",
  ylab = "value"
)
?barplot

### Lattice Plotting System ###

library(lattice)
df

#plot with defaults
dotplot(
  x = Value ~ Name,
  data = df
)
#plot with parameters
dotplot(
  x = Value ~ Name,
  data = df,
  main = "Hello World",
  xlab = "name",
  ylab = "value"
)
#create a bar chart
barchart(
  x = Value ~ Name,
  data = df,
  col = 'skyblue',
  main = 'Hello World',
  xlab = "Name",
  ylab = "Value"
)

### Plotting with GGPLOT2 ###
library(ggplot2)
df

#plot with defaults
ggplot(
  data = df,
  aes(
    x = Name,
    y = Value)) +
  geom_point()

#plot with parameters
ggplot(
  data = df,
  aes(
    x = Name,
    y = Value)) +
  geom_point() +
  ggtitle("Hello World") +
  xlab("Name") +
  ylab("Value")

#create bar chart
ggplot(
  data = df,
  aes(
    x = Name,
    y = Value)) +
  geom_bar(
    stat = "identity",
    fill = "skyblue") +
  ggtitle("Hello World") +
  xlab("name") +
  ylab("value")

?ggplot
?aes

##############################
### UNIVARIATE QUALITATIVE ###
##############################

movies <- read.csv('Movies.csv')
head(movies)

### Base Plotting System ###

#create a frequency bar chart of movies by rating
plot(
  x = factor(movies$Rating),
  main = "Count of Movies by Rating",
  xlab = "Rating",
  ylab = "Count of Movies")

#create horizontal bar chart
plot(
  x = factor(movies$Rating),
  horiz = TRUE,
  main = "Count of Movies by Rating",
  ylab = "Rating",
  xlab = "Count of Movies")

#create Cleveland dot plot (default horizontal)
dotchart(
  x = table(movies$Rating),
  pch = 16,
  main = "Count of Movies by Rating",
  ylab = "Rating",
  xlab = "Count of Movies")

#create a pie chart of ratings
pie(
  x = table(movies$Rating),
  main = "Count of Movies by Rating")

#create a pie chart of Awards: Y/N
pie(
  x = table(movies$Awards),
  clockwise = TRUE,
  main = "Movies that Won Awards")

### Lattice Plotting System ###
library(lattice)

#create frequency table of ratings
table <- table(movies$Rating)
table

ratings <- as.data.frame(table)
ratings

#set column names in df
names(ratings)[1] <- "Rating"
names(ratings)[2] <- "Count"
ratings

#create frequency bar chart
barchart(
  x = Count ~ Rating,
  data = ratings,
  main = "Count of Movies by Rating",
  xlab = "Rating")

#create horizontal bar chart
barchart(
  x = Rating ~ Count,
  data = ratings,
  main = "Count of Movies by Rating",
  ylab = "Rating")

#Cleveland Dot Plot
dotplot(
  x = Rating ~ Count,
  data = ratings,
  main = "Count of Movies by Rating",
  ylab = "Rating")

#No pie charts in Lattice
#Create part-of-whole frequency bar chart
#does not work for me
histogram(
  x = ~Rating,
  data = movies,
  main = "Percent of Movies by Rating")
?histogram

### GGPlot2 Plotting System ###
library(ggplot2)

#Create a frequency bar chart for rating
movies
ggplot(
  data = movies,
  aes(x = Rating)) +
  geom_bar() +
  ggtitle("Count of Movies by Rating")

#create horizontal frequency bar chart
ggplot(
  data = movies,
  aes(x = Rating)) +
  geom_bar() +
  coord_flip() +
  ggtitle('Count of Movies by Rating')

#Cleveland Dot Plot
ggplot(
  data = movies,
  aes(x = Rating)) +
  geom_point(stat = "count") +
  coord_flip() +
  ggtitle('Count of Movies by Rating')

#Pie Chart
ggplot(
  data = movies,
  aes(x = "", fill = Rating)) +
  geom_bar() +
  coord_polar(theta = "y") +
  ggtitle("Count of Movies by Rating") +
  ylab("")

#create pie chart of awards
ggplot(
  data = movies,
  aes(x = "", fill = Awards)) +
  geom_bar() +
  coord_polar(theta = "y") + 
  ggtitle("Movies with Awards") +
  ylab("")

###############################
### UNIVARIATE QUAntITATIVE ###
###############################

### Base Plotting System ###

#create dot plot
plot(x = movies$Runtime,
     y = rep(0, nrow(movies)),
     main = "Distribution of Movies Run Times",
     xlab = "Runtime (min)",
     ylab = "",
     yaxt = "n")

#add alpha transparency
plot(x = movies$Runtime,
     y = rep(0, nrow(movies)),
     main = "Distribution of Movies Run Times",
     xlab = "Runtime (min)",
     ylab = "",
     yaxt = "n",
     pch = 16,
     col = rgb(0, 0, 0, 0.1))

#add jitter
plot(x = movies$Runtime,
     y = jitter(rep(0, nrow(movies))),
     main = "Distribution of Movies Run Times",
     xlab = "Runtime (min)",
     ylab = "",
     yaxt = "n")

plot(x = movies$Runtime,
     y = jitter(rep(0, nrow(movies))),
     main = "Distribution of Movies Run Times",
     xlab = "Runtime (min)",
     ylab = "",
     yaxt = "n",
     pch = 16,
     col = rgb(0, 0, 0, 0.1))

#create boxplot
boxplot(
  x = movies$Runtime,
  horizontal = TRUE,
  main = "Distribution of Movies Runtimes",
  xlab = "Runtime (min)",
  pch = 16,
  col = rgb(0, 0, 0, 0.3))  #doesnt change the dots now, changes the box

#create histogram with default 20 bins
hist(
  x = movies$Runtime,
  main = "Distribution of Movie Runtimes",
  xlab = "Runtime (min)")

#change # of bins
hist(
  x = movies$Runtime,
  breaks = 10,
  main = "Distribution of Movie Runtimes",
  xlab = "Runtime (min)")

hist(
  x = movies$Runtime,
  breaks = 30,
  main = "Distribution of Movie Runtimes",
  xlab = "Runtime (min)")

#create density plot
plot(
  x = density(movies$Runtime),
  main = "Distribution of Movie Runtimes",
  xlab = "Runtime (min)")

#create small multiples of all four
par(mfrow = c(4, 1))

plot(
  x = movies$Runtime,
  y = jitter(rep(0, nrow(movies))),
  xlim = c(0,250),
  main = "Distribution of Movie Runtimes",
  xlab = "",
  ylab = "",
  yaxt = "n",
  pch = 16,
  col = rgb(0, 0, 0, 0.1))

boxplot(
  x = movies$Runtime,
  ylim = c(0, 250),
  horizontal = TRUE)

hist(
  x = movies$Runtime,
  xlim = c(0, 250),
  main = "",
  xlab = "",
  ylab = "",
  yaxt = "n")

plot(
  x = density(movies$Runtime),
  xlim = c(0, 250),
  main = "",
  xlab = "Runtime (minutes)",
  ylab = "",
  yaxt = "n")

#reset multirow display
par(mfrow = c(1, 1))

### Lattice Plotting System ###

#create dot plot
stripplot(
  x = ~ Runtime,
  data = movies,
  main = "Distribution of Movie Runtimes",
  xlab = "Runtime (minutes)")

#add jitter
stripplot(
  x = ~ Runtime,
  data = movies,
  jitter = TRUE,
  amount = 0.5,
  main = "Distribution of Movies Runtimes",
  xlab = "Runtime(minutes)")

#create box plot
bwplot(
  x = ~ Runtime,
  data = movies,
  main = "Distribution of Movie Runtimes",
  xlab = "Runtime (minutes)")

#create histogram
histogram(
  x = ~Runtime,
  data = movies, 
  main = 'Distribution of Movie Runtimes',
  xlab = "Runtime (minutes)")

#density plot
densityplot(
  x = ~Runtime,
  data = movies,
  main = "Distribution of Movie Runtimes",
  xlab = "Runtime (minutes)")

#create a multichart layout
dot <- dotplot(
  x = ~Runtime,
  data = movies,
  main = "Distribution of Movie Runtimes",
  xlab = "")

print(
  x = dot,
  position = c(0, 0.75, 1, 1),
  more = TRUE)

box <- bwplot(
  x = ~ Runtime,
  data = movies,
  xlab = "")

print(
  x = box,
  position = c(0, .5, 1, 0.75),
  more = TRUE)

hist <- histogram(
  x = ~Runtime,
  data = movies, 
  xlab = "",
  ylab = "",
  scales = list(y = list(draw = FALSE)))

print(
  x = hist,
  position = c(0, 0.25, 1, 0.5),
  more = TRUE)

density <- densityplot(
  x = ~Runtime,
  data = movies,
  ylab = "",
  scales = list(y = list(draw = FALSE)))

print(
  x = density,
  position = c(0, 0, 1, 0.25))

### GGPlot2 Plotting System ###

#create dot plot
ggplot(
  data = movies,
  aes(x = Runtime, stat = 'count')) +
  geom_dotplot(binwidth = 1) +
  ggtitle("Distribution of Movie Runtimes") +
  xlab("Runtime")

#violin style dot plot
ggplot(
  data = movies,
  aes(x = Runtime, stat = 'count')) +
  geom_dotplot(
    binwidth = 1,
    stackdir = "center") +
  ggtitle("Distribution of Movie Runtimes") +
  xlab("Runtime")

#create box plot

ggplot(
  data = movies,
  aes(x = Runtime, y = Runtime)) +
  geom_boxplot() +
  coord_flip() +
  ggtitle("Distribution of Movie Runtimes") +
  xlab("") +
  theme(
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank())

#create histogram
ggplot(
  data = movies,
  aes(x = Runtime)) +
  geom_histogram(binwidth = 10) +
  ggtitle("Distribution of Movie Runtimes") +
  xlab("Runtime")

#create density plot
ggplot(
  data = movies,
  aes(x = Runtime)) +
  geom_density() +
  ggtitle("Distribution of Movie Runtimes") +
  xlab("Runtimes")

#plot multi-chart layout
dev.off()
library(grid)
viewport <- viewport(
  layout = grid.layout(4,1))
pushViewport(viewport)

dot <- ggplot(
  data = movies,
  aes(x = Runtime, ..count..)) +
  geom_dotplot(binwidth = .25) +
  scale_x_continuous(limits = c(0, 250))
  ggtitle("Distribution of Movie Runtimes") +
  xlab("")
  
print(
  x = dot,
  vp = viewport(
    layout.pos.row = 1,
    layout.pos.col = 1))

box <- ggplot(
  data = movies,
  aes(x = Runtime, y = Runtime)) +
  geom_boxplot() +
  coord_flip() +
  scale_y_continuous(limits = c(0, 250))
  xlab("")
  
print(
  x = box,
  vp = viewport(
    layout.pos.row = 2,
    layout.pos.col = 1))

hist <- ggplot(
  data = movies,
  aes(x = Runtime)) +
  geom_histogram(binwidth = 10) +
  scale_x_continuous(limits = c(0, 250)) +
  xlab("")

print(
  x = hist,
  vp = viewport(
    layout.pos.row = 3,
    layout.pos.col = 1))

density <- ggplot(
  data = movies,
  aes(x = Runtime)) +
  geom_density() +
  scale_x_continuous(limits = c(0, 250)) +
  xlab("Runtimes")

print(
  x = density,
  vp = viewport(
    layout.pos.row = 4,
    layout.pos.col = 1))


#############################
### BIVARIATE QUALITATIVE ###
#############################

### Base Plotting System ###

#create a contingency table first
awards <- table(
  movies$Award,
  movies$Rating)
awards

#create grouped frequency bar chart
barplot(
  height = awards,    #sets y-axis to table we created: awards
  beside = TRUE,      #sets orientation of bars
  main = "Count of Movies by Rating and Awards",
  xlab = "Rating",
  ylab = "Count of Movies",
  legend = c("No", "Yes"),
  args.legend = list(
    x = "topleft",
    title = "Awards"))

#create stacked frequency bar chart
barplot(
  height = awards,
  main = "Count of Movies by Rating and Awards",
  xlab = "Rating",
  ylab = "Count of Movies",
  legend = c("No", "Yes"),
  args.legend = list(
    x="topleft",
    title = "Awards"))

#create proportional frequency table
#first change the numbers to proportions by applying a function on columns
#second parameter (2) tells us to apply it by column; (1) by row
proportions <- apply(awards, 2, function(x){x/sum(x)})
head(awards)
head(proportions)

#create 100% stacked frequency bar chart
#better for comparing proportions, shows a balance in each category
barplot(
  height = proportions,
  main = "Proportion of Movies by Rating and Awards",
  xlab = "Rating",
  ylab = "Proportion of Movies",
  legend = c("No", "Yes"),
  args.legend = list(
    x = "topleft",
    title = "Awards"))

#create a flipped contingency table
awards <- table(
  movies$Rating,
  movies$Awards)

head(awards)
#change the column names
colnames(awards) <- c("No", "Yes")
awards

#create spine plot
spineplot(
  x = awards, 
  main = "Proportion of Movies by Rating and Awards",
  xlab = "Rating",
  ylab = "Awards")

#create mosaic plot
mosaicplot(
  x = awards,
  main = "Proportion of Movies by Rating and Awards",
  xlab = "Rating",
  ylab = "Awards")

### Lattice Plotting System ###

#grouped frequency bar chart
barchart(
  x = awards,
  stack = FALSE,
  horizontal = FALSE,
  main = "Count of Movies by Rating and Awards",
  xlab = "Rating",
  ylab = "Count of Movies",
  auto.key = list(
    x = 0.05,
    y = 0.95,
    title = "Awards",
    text = c("No", "Yes")))

#create stacked frequency bar chart
barchart(
  x = awards,
  stack = TRUE,
  horizontal = FALSE,
  main = "Count of Movies by Rating and Awards",
  xlab = "Rating",
  ylab = "Count of Movies",
  auto.key = list(
    x = 0.05,
    y = 0.95,
    title = "Awards",
    text = c("No", "Yes")))

#create 100% stacked frequency bar chart
#create proportional frequency table
matrix <- apply(awards, 1, function(x){x/sum(x)})
#transpose matrix
proportions <- t(matrix)
proportions

#create chart
barchart(
  x = proportions,
  stack = TRUE,
  horizontal = FALSE,
  main = "Proportion of Movies by Rating and Awards",
  xlab = "Rating",
  ylab = "Proportion of Movies",
  auto.key = list(
    x = 0.60,
    y = 1.05,
    title = "Awards",
    columns = 2,
    text = c("No", "Yes"),
    background = "white"))

#NO spine or mosaic plots in lattice

### GGPlot2 Plotting System ###

#Grouped frequency bar chart
ggplot(
  data = movies,
  aes(x = Rating, fill = Awards)) +
  geom_bar(position = "dodge") +
  ggtitle("Count of Movies by Rating and Awards") +
  scale_fill_discrete(labels = c("no", "yes"))

#stacked frequency bar chart
ggplot(
  data = movies,
  aes(x = Rating, fill = Awards)) +
  geom_bar() +
  ggtitle("Count of Movies by Rating and Awards") +
  scale_fill_discrete(labels = c("no", "yes"))

#100% stacked frequency bar chart
ggplot(
  data = movies,
  aes(x = Rating, fill = Awards)) +
  geom_bar(position = "fill") +
  ggtitle("Proportion of Movies by Rating and Awards") +
  ylab("Proportion of Movies") +
  scale_fill_discrete(labels = c("no", "yes"))

#NOTE: ggplot2 does not require the creation of a frequency table
#No spine or mosaic plots in ggplot2


##############################
### BIVARIATE QUANTITATIVE ###
##############################

### Base Plotting System ###

#create scatter plot
plot(
  x = movies$Runtime,
  y = movies$Box.Office,
  main = "Runtime vs. Box Office Revenue",
  xlab = "Runtime",
  ylab = "Revenue ($M)")

#create linear regression model
model <- lm(movies$Box.Office ~ movies$Runtime)
#draw regression line
lines(
  x = movies$Runtime,
  y = model$fitted,
  col = "red",
  lwd = 3)
#weak correlation here

#hexagonal bin frequency heat map
library(hexbin)

hexbin <- hexbin(
  x = movies$Runtime,
  y = movies$Box.Office,
  xbins = 30,
  xlab = "Runtime",
  ylab = "Revenue ($M)")

plot(
  x = hexbin,
  main = "Runtime vs Box Office Revenue")

# 2D Kernel Density Plots
library(MASS)

#create 2d kernel density estimation
density2d <- kde2d(
  x = movies$Runtime,
  y = movies$Box.Office,
  n = 50)
density2d

#create countour plot
contour(
  x = density2d$x,
  y = density2d$y,
  z = density2d$z,
  main = "Runtime vs Box Office Revenue",
  xlab = "Runtime",
  ylab = "Box Office ($M)")
#not great for this data set

#create a level plot of density
image(
  x = density2d$x,
  y = density2d$y,
  z = density2d$z,
  col = topo.colors(100),
  main = "Runtime vs Box Office Revenue",
  xlab = "Runtime",
  ylab = "Box Office ($M)")

#create mesh plot of density
persp(
  x = density2d$x,
  y = density2d$y,
  z = density2d$z,
  main = "Runtime vs Box Office Revenue",
  xlab = "Runtime",
  ylab = "Box Office ($M)",
  zlab = "Density")

#drape color on the mesh plot
palette(topo.colors(100))
persp(
  x = density2d$x,
  y = density2d$y,
  z = density2d$z,
  col = cut(density2d$z, 100),
  main = "Runtime vs Box Office Revenue",
  xlab = "Runtime",
  ylab = "Box Office ($M)",
  zlab = "Density")

palette("default")

#Plotting Time Series
timeSeries <- read.csv("Timeseries.csv")
head(timeSeries)

#create step chart
plot(
  x = timeSeries,
  type = "s",
  ylim = c(0, max(timeSeries$Box.Office)),
  main = "Average Box Office Revenue by Year",
  xlab = "Year",
  ylab = "Revenue ($M)")

#create line chart
plot(
  x = timeSeries,
  type = "l",
  ylim = c(0, max(timeSeries$Box.Office)),
  main = "Average Box Office Revenue by Year",
  xlab = "Year",
  ylab = "Revenue ($M)")

#Area charts are difficult to create in base plotting system


### Lattice Plotting System ###

#create scatter plot
xyplot(
  x = Box.Office ~ Runtime,
  data = movies,
  main = "Runtime vs Box Office Revenue",
  xlab = "Runtime (minutes)",
  ylab = "Revenue ($M)")

#add linear regression line
xyplot(
  x = Box.Office ~ Runtime,
  data = movies,
  type = c("p", "r"),
  main = "Runtime vs Box Office Revenue",
  xlab = "Runtime (minutes)",
  ylab = "Revenue ($M)")

#hexagonal binned frequency heatmap
library(hexbin)
hexbinplot(
  x = Box.Office ~ Runtime,
  data = movies,
  xbins = 30,
  main = "Runtime vs Box Office Revenue",
  xlab = "Runtime (minutes)",
  ylab = "Revenue ($M)")

# @D Kernel Density Plots

#create grid from our 2d kernel density estimates
grid <- expand.grid(
  x = density2d$x,
  y = density2d$y)
head(grid)
#add z column from the density function as well
grid$z <- as.vector(density2d$z)

#create contour plot
# NOTE:  the * here is not multiplication, 
#        it tells the function to determine z
#        based on every combination of x and y
contourplot(
  x = z ~ x * y,
  data = grid,
  main = "Runtime vs Box Office Revenue",
  xlab = "Runtime (minutes)",
  ylab = "Revenue ($M)")

#Create Level Plot
levelplot(
  x = z ~ x * y,
  data = grid,
  main = "Runtime vs Box Office Revenue",
  xlab = "Runtime (minutes)",
  ylab = "Revenue ($M)")

#Create Mesh Plot
wireframe(
  x = z ~ x * y,
  data = grid,
  main = "Runtime vs Box Office Revenue",
  xlab = "Runtime (minutes)",
  ylab = "Revenue ($M)",
  zlab = "Density")
#this one looks much nicer than base system

#create Surface Plot
wireframe(
  x = z ~ x * y,
  data = grid,
  drape = TRUE,
  main = "Runtime vs Box Office Revenue",
  xlab = "Runtime (minutes)",
  ylab = "Revenue ($M)",
  zlab = "Density")

# Time Series Plots

#step chart
xyplot(
  x = Box.Office ~ Year,
  data = timeSeries,
  type = "s",
  ylim = c(0, max(timeSeries$Box.Office)),
  main = "Average Box Office Revenue by Year",
  xlab = "Year",
  ylab = "Box Office ($M)")

#line chart
xyplot(
  x = Box.Office ~ Year,
  data = timeSeries,
  type = "l",
  ylim = c(0, max(timeSeries$Box.Office)),
  main = "Average Box Office Revenue by Year",
  xlab = "Year",
  ylab = "Box Office ($M)")

#Create Area Chart
library(latticeExtra)

xyplot(
  x = Box.Office ~ Year,
  data = timeSeries,
  panel = panel.xyarea,
  ylim = c(0, max(timeSeries$Box.Office)),
  main = "Average Box Office Revenue by Year",
  xlab = "Year",
  ylab = "Box Office ($M)")



### GGPlot2 Plotting System ###
library(ggplot2)

# Scatter Plot
ggplot(
  data = movies,
  aes(x = Runtime, y = Box.Office)) +
  geom_point() +
  ggtitle("Runtime vs Box Office Revenue") +
  xlab("Runtime") +
  ylab("Box Office")

#add linear regression line
ggplot(
  data = movies,
  aes(x = Runtime, y = Box.Office)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  ggtitle("Runtime vs Box Office Revenue") +
  xlab("Runtime") +
  ylab("Box Office")

#create frequency heat map
ggplot(
  data = movies,
  aes(x = Runtime, y = Box.Office)) +
  stat_bin2d() +
  ggtitle("Runtime vs Box Office Revenue") +
  xlab("Runtime") +
  ylab("Box Office")

#Hexagonal binned frequency heat map
ggplot(
  data = movies,
  aes(x = Runtime, y = Box.Office)) +
  stat_binhex() +
  ggtitle("Runtime vs Box Office Revenue") +
  xlab("Runtime") +
  ylab("Box Office")

#Contour Density Plot
ggplot(
  data = movies,
  aes(x = Runtime, y = Box.Office)) +
  geom_density2d() +
  ggtitle("Runtime vs Box Office Revenue") +
  xlab("Runtime") +
  ylab("Box Office")

#Level plot of density
#NOTE:      the syntax ..level.. is unique to ggplot2
#           it denotes a statistic not found in the OG data,
#           but computed by the function itself
ggplot(
  data = movies,
  aes(x = Runtime, y = Box.Office)) +
  stat_density2d(aes(fill = ..level..), geom = "polygon") +
  ggtitle("Runtime vs Box Office Revenue") +
  xlab("Runtime") +
  ylab("Box Office")

# 3D visualizations do not exist in ggplot2

# Time Series Plots

#step chart
ggplot(
  data = timeSeries,
  aes(x = Year, y = Box.Office)) +
  geom_step() +
  expand_limits(y = 0) +
  ggtitle("Box Office Revenue by Year") +
  xlab("Year") +
  ylab("Revenue ($M)")

#Line Chart
ggplot(
  data = timeSeries,
  aes(x = Year, y = Box.Office)) +
  geom_line() +
  expand_limits(y = 0) +
  ggtitle("Box Office Revenue by Year") +
  xlab("Year") +
  ylab("Revenue ($M)")

#Create an Area Chart
ggplot(
  data = timeSeries,
  aes(x = Year, y = Box.Office)) +
  geom_area() +
  ggtitle("Box Office Revenue by Year") +
  xlab("Year") +
  ylab("Revenue ($M)")


############################################################################
### BIVARIATE ANALYSIS FOR ONE QUALITATIVE AND ONE QUANTITATIVE VARIABLE ###
############################################################################

### Base Graphing System ###

# Bivariate Bar Chart
#create an array that has the average revenue based on category
#  tapply(numeric variable, grouped variable, aggregation type)
average <- tapply(
  movies$Box.Office,
  movies$Rating,
  mean)
average

barplot(
  height = average,
  main = "Average Revenue by Rating",
  xlab = "Rating",
  ylab = "Box Office ($M)")

#create Bivariate Box Plot
plot(
  x = factor(movies$Rating),
  y = movies$Box.Office,
  main = "Box Office Revenue by Rating",
  xlab = "Rating",
  ylab = "Box Office ($M)")

#Create notched box plot
plot(
  x = factor(movies$Rating),
  y = movies$Box.Office,
  notch = TRUE,
  main = "Box Office Revenue by Rating",
  xlab = "Rating",
  ylab = "Box Office ($M)")


### Lattice Plotting System ###
library(dplyr)

#create table of average box office by rating
average <- movies %>%
  select(Rating, Box.Office) %>%
  group_by(Rating) %>%
  summarize(Box.Office = mean(Box.Office)) %>%
  as.data.frame()
average

#Bivariate Bar Chart
barchart(
  x = Box.Office ~ Rating,
  data = average,
  main = "Box Office Revenue by Rating",
  xlab = "Rating",
  ylab = "Box Office ($M)")

#bivariate box plot
bwplot(
  x = Box.Office ~ Rating,
  data = movies,
  main = "Box Office Revenue by Rating",
  xlab = "Rating",
  ylab = "Box Office ($M)")

#notched box plot
bwplot(
  x = Box.Office ~ Rating,
  data = movies,
  notch = TRUE,
  main = "Box Office Revenue by Rating",
  xlab = "Rating",
  ylab = "Box Office ($M)")

#violin plot
bwplot(
  x = Box.Office ~ Rating,
  data = movies,
  panel = panel.violin,
  main = "Box Office Revenue by Rating",
  xlab = "Rating",
  ylab = "Box Office ($M)")


### GGPlot2 System ###

#Bivariate bar chart
ggplot(
  data = average,
  aes(x = Rating, y = Box.Office)) +
  geom_bar(stat = "identity") +
  ggtitle("Average Box Office Revenue by Rating") +
  xlab("Rating") +
  ylab("Revenue ($M)")

#Bivariate box plot
ggplot(
  data = movies,
  aes(x = Rating, y = Box.Office)) +
  geom_boxplot() +
  ggtitle("Average Box Office Revenue by Rating") +
  xlab("Rating") +
  ylab("Revenue ($M)")

#notched box plot
ggplot(
  data = movies,
  aes(x = Rating, y = Box.Office)) +
  geom_boxplot(notch = TRUE) +
  ggtitle("Average Box Office Revenue by Rating") +
  xlab("Rating") +
  ylab("Revenue ($M)")

#Violin plot
ggplot(
  data = movies,
  aes(x = Rating, y = Box.Office)) +
  geom_violin() +
  ggtitle("Average Box Office Revenue by Rating") +
  xlab("Rating") +
  ylab("Revenue ($M)")
#cuts density function off abruptly at zero, can be useful


#########################
### BEYOND THE BASICS ###
#########################
 
#Cleaning up data visualizations
#state our Question: How many movies created in each rating category?
#frequency bar chart with defaults
plot(factor(movies$Rating))

#add context
plot(
  x = factor(movies$Rating),
  main = "Count of Movies by MPAA Rating Category",
  xlab = "MPAA Rating Category",
  ylab = "Count of Movies")

#Create a color palette
library(RColorBrewer)
palette <- brewer.pal(9, "Pastel1")
palette

#clean up the bar chart
plot(
  x = factor(movies$Rating),
  col = palette[2],
  border = NA,
  main = "Count of Movies by MPAA Rating Category",
  xlab = "MPAA Rating Category",
  ylab = "Count of Movies")

#make sure to check for information distortion
#save file as PNG
png(
  filename = "Movies_by_Rating.png",
  width = 640,
  height = 480)

plot(
  x = factor(movies$Rating),
  col = palette[2],
  border = NA,
  main = "Count of Movies by MPAA Rating Category",
  xlab = "MPAA Rating Category",
  ylab = "Count of Movies")

dev.off()
?ggsave
