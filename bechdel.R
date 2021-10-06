library(pacman)
p_load(data.table, tidyverse, sqldf, DT, reactable, flexdashboard, htmlwidgets, bslib)

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


# New Numerical Columns

## Pass/Fail

movbech$binary_num <- fifelse(movbech$binary=="FAIL", 0, 1)

## Ratings

movbech$G <- fifelse(movbech$rated=="G", 1, 0)
movbech$PG <- fifelse(movbech$rated=="PG" | movbech$rated=="TV-PG", 1, 0)
movbech$R <- fifelse(movbech$rated=="R", 1, 0)
movbech$NC_17 <- fifelse(movbech$rated=="NC-17", 1, 0)
movbech$X <- fifelse(movbech$rated=="X", 1, 0)
movbech$Not_Rated <- fifelse(movbech$rated=="Not Rated", 1, 0)
movbech$Unrated <- fifelse(movbech$rated=="Unrated", 1, 0)

ratings <- movbech[, c(38:45)]


## Genres

movbech$action <- fifelse(grepl("Action",movbech$genre, ignore.case = TRUE),1, 0)
movbech$adventure <- fifelse(grepl("Adventure",movbech$genre, ignore.case = TRUE),1, 0)
movbech$animation <- fifelse(grepl("Animation",movbech$genre, ignore.case = TRUE),1, 0)
movbech$comedy <- fifelse(grepl("Comedy",movbech$genre, ignore.case = TRUE),1, 0)
movbech$horror <- fifelse(grepl("Horror",movbech$genre, ignore.case = TRUE),1, 0)
movbech$drama <- fifelse(grepl("Drama",movbech$genre, ignore.case = TRUE),1, 0)
movbech$music <- fifelse(grepl("Music",movbech$genre, ignore.case = TRUE),1, 0)
movbech$sci_Fi <- fifelse(grepl("Sci/-Fi",movbech$genre, ignore.case = TRUE),1, 0)
movbech$crime <- fifelse(grepl("Crime",movbech$genre, ignore.case = TRUE),1, 0)
movbech$romance <- fifelse(grepl("Romance",movbech$genre, ignore.case = TRUE),1, 0)
movbech$fantasy <- fifelse(grepl("Fantasy",movbech$genre, ignore.case = TRUE),1, 0)
movbech$thriller <- fifelse(grepl("Thriller",movbech$genre, ignore.case = TRUE),1, 0)
movbech$family <- fifelse(grepl("Family",movbech$genre, ignore.case = TRUE),1, 0)
movbech$war <- fifelse(grepl("War",movbech$genre, ignore.case = TRUE),1, 0)
movbech$history <- fifelse(grepl("History",movbech$genre, ignore.case = TRUE),1, 0)
movbech$musical <- fifelse(grepl("Musical",movbech$genre, ignore.case = TRUE),1, 0)



genre <- movbech[,c(38, 46:61)]

cor.test(genre$binary_num, genre$action)
cor.test(genre$binary_num, genre$romance)
cor.test(genre$binary_num, genre$crime)
## 

# Bechdel score relation to country, language


# Graphs

eval_order <- factor(movbech$rated, level = c("G", "PG", "PG-13", "TV-PG", "TV-14", "R", "NC-17", "X", "Not Rated", "Unrated"))


ggplot(movbech, aes(eval_order))+
  geom_bar() +
  labs(title="Movie Ratings", x="Rating", y="Count")

ggplot(movbech, aes(binary)) +
  geom_bar() +
  labs(title="Bechdel Pass Rate", x="Rating", y="Count")

ggplot(movbech, aes(budget_2013, domgross_2013)) +
  geom_smooth(color="red", se=FALSE) +
  geom_line()

