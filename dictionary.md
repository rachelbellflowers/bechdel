# `raw_bechdel.csv`

| variable | class     | description                                                            |
|----------|-----------|------------------------------------------------------------------------|
| year     | integer   | Year of release                                                        |
| id       | integer   | ID of film                                                             |
| imdb_id  | character | IMDB ID                                                                |
| title    | character | Title of film                                                          |
| rating   | integer   | Rating (0-3), 0 = unscored, 1. It has to have at least                 
                        two [named] women in it, 2. Who talk to each other, 3. About something  
                        besides a man                                                           |

# `movies.csv`

| variable      | class     | description                            |
|---------------|-----------|----------------------------------------|
| year          | double    | Year                                   |
| imdb          | character | IMDB                                   |
| title         | character | Title of movie                         |
| test          | character | Bechdel Test outcome                   |
| clean_test    | character | Bechdel Test cleaned                   |
| binary        | character | Binary pass/fail of bechdel            |
| budget        | double    | Budget as of release year              |
| domgross      | character | Domestic gross in release year         |
| intgross      | character | International gross in release year    |
| code          | character | Code                                   |
| budget_2013   | double    | Budget normalized to 2013              |
| domgross_2013 | character | Domestic gross normalized to 2013      |
| intgross_2013 | character | International gross normalized to 2013 |
| period_code   | double    | Period code                            |
| decade_code   | double    | Decade Code                            |
| imdb_id       | character | IMDB ID                                |
| plot          | character | Plot of movie                          |
| rated         | character | Rating of movie                        |
| response      | character | Response?                              |
| language      | character | Language of film                       |
| country       | character | Country produced in                    |
| writer        | character | Writer of film                         |
| metascore     | double    | Metascore rating (0-100)               |
| imdb_rating   | double    | IMDB Rating 0-10                       |
| director      | character | Director of movie                      |
| released      | character | Released date                          |
| actors        | character | Actors                                 |
| genre         | character | Genre                                  |
| awards        | character | Awards                                 |
| runtime       | character | Runtime                                |
| type          | character | Type of film                           |
| poster        | character | Poster image                           |
| imdb_votes    | character | IMDB Votes                             |
| error         | character | Error?                                 |
