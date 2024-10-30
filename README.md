## The CodeR-Sessions

The home base for the CodeR-Sessions project.

> **NOTE:** This project is in early development and not yet ready 
for users. Please feel free to explore the codebase and make suggestions! 

#
The CodeR-Sessions is an open sourced project to help people practice statistics and coding in R. 

The website will scrape the web for data sets and 
automatically generate a number of research questions (RQ) about the dataset so that the user has some direction. Once a combination of data and RQ's is found and satisfied, the website will save it as a query. This is essentially a question prompt that has both a dataset and RQ's, and is ready to be practiced with!  

An example query could be as follows... 

```
Analyzing NFL Rushing Performance                                          pqn:45968
```


| Player ID  | Yards | Play Number | Run Direction | Defense Formation | Result Type   |
|------------|-------|-------------|---------------|-------------------|---------------|
| player1    | 45    | 12          | left          | 4-3               | First Down    |
| player2    | 30    | 8           | right         | Nickel            | No Gain       |
| player3    | 50    | 15          | center        | 3-4               | Touchdown     |
| player4    | 15    | 20          | left          | Dime              | First Down    |
| player5    | 5     | 25          | right         | 4-3               | No Gain       |
```
Research Questions:
- Explore the relationship between temperature and yards gained. What temperature results in the most yards?
- Can we predict the expected yards gained (`yards`) based on the running direction (`runDir`) and the number of plays (`playNum`)? What statistical model best fits the data?
- Is there a correlation between the running direction (`runDir`) and average yards gained?

```

A page like the one above will be titled and assigned a problem query number (PQN) that allows users to quickly find the same problem set. 

Once a user has coded their solution, they will have the option to post it to the problems page. The query page will then be a place for others to compare answers or ask for help.  

Additionally, users may upload their own datasets and create custom queries from a template to challenge other users. User generated queries will also be assigned a problem query number and saved to the database for others to try out! 

#

> ### Contact me! 📝
> This project is open to any help, suggestions, or collaboration.  
> Email: chish071@umn.edu

