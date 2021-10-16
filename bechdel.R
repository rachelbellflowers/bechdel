library(pacman)
p_load(data.table, tidyverse, corrplot, sqldf, DT, reactable, flexdashboard, htmlwidgets, bslib, lubridate)

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2021/2021-03-09/readme.md

#factors

# Import

raw_bechdel <- fread('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-09/raw_bechdel.csv')

movies <- fread('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-09/movies.csv', select = c(1:33))

# Cleaning

movies[movies=="N/A"] <- NA

movies <- movies[!is.na(rated)][order(title)]

movies$title <- gsub("&amp;", "&", movies$title)

movies$title <- gsub("&#39;", "'", movies$title)

movies$title <- gsub("&agrave;","à", movies$title)

movies$title <- gsub("&auml;","ä", movies$title)

movies$title <- gsub("&aring;","å", movies$title)

movies$title <- gsub("&uuml;","ü", movies$title)

###

raw_bechdel <- raw_bechdel[year < 2014][order(title)]

raw_bechdel$title <- gsub("&amp;", "&", raw_bechdel$title)

raw_bechdel$title <- gsub("&#39;|â€™", "'", raw_bechdel$title)

raw_bechdel$title <- gsub("&quot;","\"", raw_bechdel$title)

###

# Joins and New Columns
movbech <- raw_bechdel[movies, on = .(title, year)][order(title)]

movbech[, budget_2013_mean := mean(budget_2013), by = binary]

movbech$imdb_votes <- gsub(",", "", movbech$imdb_votes)

movbech[, imdb_votes:=as.integer(imdb_votes)]

movbech$released <- dmy(movbech$released)
# New Numerical Columns

# Graphs

eval_order <- factor(movbech$rated, level = c("G", "PG", "PG-13", "TV-PG", "TV-14", "R", "NC-17", "X", "Not Rated", "Unrated"))


############################

movbech[year %between% c(1970, 1979), decade:="70s"]
movbech[year %between% c(1980, 1989), decade:="80s"]
movbech[year %between% c(1990, 1999), decade:="90s"]
movbech[year %between% c(2000, 2009), decade:="00s"]
movbech[year %between% c(2010, 2019), decade:="10s"]

ggplot(movbech, aes(year, fill=decade)) +
  geom_bar() +
  scale_fill_manual(values=c("#CE6693FF", "#A059A0FF", "#FAC484FF", "#F8A07EFF", "#EB7F86FF")) +
  theme_minimal()

##################################
ggplot(movbech, aes(eval_order))+
  geom_bar() +
  labs(title="Movie Ratings", x="Rating", y="Count")

ggplot(movbech, aes(budget_2013, domgross_2013)) +
  geom_smooth(color="red", se=FALSE) +
  geom_line()


## Bechdel Pass Rate Based on Decade

ggplot(movbech, aes(binary)) +
  geom_bar() +
  labs(title="Bechdel Pass Rate", x="Rating", y="Count")


