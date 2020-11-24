housing <- read.csv("housing.csv")
head(housing)
plot(
  x = housing$total_bedrooms,
  y = housing$total_rooms,
  main = "Total Bedrooms vs. Total Rooms",
  xlab = "total bedrooms",
  ylab = "total rooms",
  pch = 20,
  col = rgb(0, 0, 0, 0.1)
)
library(hexbin)

hexbin <- hexbin(
  x = housing$total_bedrooms,
  y = housing$total_rooms,
  xbins = 50,
  xlab = "bedrooms",
  ylab = "rooms")

plot(hexbin)

plot(
  x = housing$population,
  y = housing$households,
  main = "Population vs. Households",
  xlab = "population",
  ylab = "households",
  xlim = c(0, 20000),
  pch = 20,
  col = as.numeric(housing$ocean_proximity)
)
?plot
?par