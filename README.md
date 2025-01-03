# README: World Cup Database

## Overview
This project contains the PostgreSQL dump file for a database named **worldcup**, which tracks World Cup games and teams. The database includes information about matches, teams, and their respective performances.

---

## Database Details

### Tables

1. **games**
   - Stores data about each game, including its year, round, and the teams involved.
   - **Columns**:
     - `game_id` (integer, primary key)
     - `year` (integer)
     - `round` (varchar(30))
     - `winner_id` (integer, foreign key referencing `teams.team_id`)
     - `opponent_id` (integer, foreign key referencing `teams.team_id`)
     - `winner_goals` (integer)
     - `opponent_goals` (integer)

2. **teams**
   - Stores data about teams that participated in the games.
   - **Columns**:
     - `team_id` (integer, primary key)
     - `name` (varchar(30), unique)

---

### Sequences
- `games_game_id_seq`: Used to auto-increment the `game_id` column in the `games` table.
- `teams_team_id_seq`: Used to auto-increment the `team_id` column in the `teams` table.

---

### Constraints
- **Primary Keys**:
  - `games_pkey`: Ensures each `game_id` in `games` is unique.
  - `teams_pkey`: Ensures each `team_id` in `teams` is unique.
- **Unique Constraints**:
  - `teams_name_key`: Ensures each `name` in `teams` is unique.
- **Foreign Keys**:
  - `games_winner_id_fkey`: Links `winner_id` in `games` to `team_id` in `teams`.
  - `games_opponent_id_fkey`: Links `opponent_id` in `games` to `team_id` in `teams`.

---

### Sample Data

- **games**: 
  - Includes game results from 2014 and 2018 World Cups, such as finals, semi-finals, and more.
  - Example:  
    ```sql
    INSERT INTO public.games VALUES (1, 2018, 'Final', 91, 92, 4, 2);
    ```
    *(France defeated Croatia 4-2 in the 2018 final)*

- **teams**: 
  - Contains team names and their corresponding IDs.
  - Example:  
    ```sql
    INSERT INTO public.teams VALUES (91, 'France');
    ```

---

### Usage Instructions

1. **Setup Database**:
   - Restore the database using the provided dump file:  
     ```bash
     psql -U [username] -d [database_name] -f worldcup.sql
     ```

2. **Query Examples**:
   - Get all games in the final round:  
     ```sql
     SELECT * FROM games WHERE round = 'Final';
     ```
   - List all teams that participated in 2018:  
     ```sql
     SELECT DISTINCT t.name 
     FROM teams t 
     JOIN games g ON t.team_id IN (g.winner_id, g.opponent_id)
     WHERE g.year = 2018;
     ```

3. **Modify Data**:
   - Add a new team:  
     ```sql
     INSERT INTO teams (name) VALUES ('New Team');
     ```
   - Add a new game:  
     ```sql
     INSERT INTO games (year, round, winner_id, opponent_id, winner_goals, opponent_goals)
     VALUES (2022, 'Quarter-Final', 115, 116, 3, 1);
     ```

---

### Notes
- The database supports basic CRUD operations for teams and games.
- The `worldcup` database uses UTF-8 encoding and has collations set to `C.UTF-8` for case-insensitive operations.

---