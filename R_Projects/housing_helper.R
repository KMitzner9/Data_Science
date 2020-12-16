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
unique(housing$ocean_proximity)
housing$ocean_proximity

color <- switch(housing$ocean_proximity,
                "NEAR BAY" = "tomato1",
                "<1H OCEAN" = "turqoise",
                "INLAND" = "violetred4",
                "NEAR OCEAN" = "yellowgreen",
                "ISLAND" = "aliceblue")

plot(
  x = housing$population,
  y = housing$households,
  main = "Population vs. Households",
  xlab = "population",
  ylab = "households",
  xlim = c(0, 20000),
  pch = 20,
  col = rgb(0, 0, 0, 0.1)
)
?plot
?par
colors(
)
?switch

library(ggplot2)

# Scatter Plot
ggplot(
  data = housing,
  aes(x = population, y = households)) +
  geom_point(aes(color = ocean_proximity)) +
  ggtitle("Population vs Households") +
  xlab("Population") +
  ylab("Households")

ggplot(
  data = housing,
  aes(x = total_rooms, y = total_bedrooms)) +
  geom_point(aes(color = ocean_proximity)) +
  ggtitle("Total Rooms vs Total Bedrooms") +
  xlab("Rooms") +
  ylab("Bedrooms")

