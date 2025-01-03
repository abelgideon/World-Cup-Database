#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != year ]]
  then
    WINNER_TEAM_ID="$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")"
    OPPONENT_TEAM_ID="$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")"

    if [[ -z $WINNER_TEAM_ID ]]
    then
      INSERT_WINNER_RESULT="$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")"
    fi
    if [[ -z $OPPONENT_TEAM_ID ]]
    then
      INSERT_OPPONENT_RESULT="$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")"
    fi

    GET_WINNER_ID="$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")"
    GET_OPPONENT_ID="$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")"
    
    INSERT_GAMES_RESULT="$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $GET_WINNER_ID, $GET_OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")"
  fi
done