 
#################################################
### SUPER BASIC INTRO TO THE GRAPHING SYSTEMS ###
#################################################

# create a dataframe
df <- data.frame(
  Name = c("a", "b", "c"),
  Value = c(1, 2, 3)
)
df

#plot the df using default parameters
plot(factor(df))
plot(factor(df$Name), df$Value)
