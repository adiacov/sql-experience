-- level 1
CREATE TABLE player (
    id INT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    status VARCHAR(50),
    debt INT,
    age INT,
    vice VARCHAR(50),
    has_close_family BOOLEAN
);

-- level 1, 2
CREATE TABLE rations (
    amount INT PRIMARY KEY
);

-- level 3
CREATE TABLE monthly_temperatures (
    month SMALLINT PRIMARY KEY,
    avg_temperature DECIMAL(5,2)
);

-- level 3
CREATE TABLE honeycomb_game (
    id INT PRIMARY KEY,
    shape VARCHAR(50),
    average_completion_time DECIMAL(10,2),
    date DATE
);

-- level 4
-- note 1: the schema name is changed not to clash with the former schemas
-- note 2: for the queries I still use the real table name `player`
CREATE TABLE player_level_4 (
    id INT PRIMARY KEY,
    team_id INT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    age INT,
    status varchar(20)
);

-- level 5
CREATE TABLE daily_interactions (
    id INT PRIMARY KEY,
    player1_id INT REFERENCES player_level_5 (id),
    player2_id INT REFERENCES player_level_5 (id),
    type VARCHAR(50),
    date DATE
);

-- level 5
CREATE TABLE player_level_5 (
    id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    age SMALLINT,
    status VARCHAR(20)
);

-- level 6
CREATE TABLE suppliers (
    id BIGINT PRIMARY KEY,
    name VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE equipment (
    id INT PRIMARY KEY,
    supplier_id INT REFERENCES suppliers (id),
    game_type VARCHAR(20),
    installation_date DATE
);

CREATE TABLE failure_incidents (
    id BIGINT PRIMARY KEY,
    failed_equipment_id BIGINT REFERENCES equipment (id),
    failure_type VARCHAR(20),
    failure_date DATE
);

-- level 7
CREATE TABLE guard (
    id INT PRIMARY KEY,
    assigned_room_id INT REFERENCES room (id),
    code_name VARCHAR(50),
    status VARCHAR(20)
);

CREATE TABLE room (
    id INT PRIMARY KEY,
    floor SMALLINT,
    isVacant BOOLEAN,
    last_check_time TIME
);

CREATE TABLE camera (
    id BIGINT PRIMARY KEY,
    location VARCHAR(30),
    movement_detected BOOLEAN,
    guard_spotted_id INT REFERENCES guard (id),
    movement_detected_time TIME
);

-- level 8
CREATE TABLE player_level_8 (
    id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    game_id INT REFERENCES glass_bridge (id),
    survived BOOLEAN,
    death_description TEXT,
    last_modified_time_seconds INT
);

CREATE TABLE glass_bridge (
    id INT PRIMARY KEY,
    date DATE
);

-- level 9
CREATE TABLE guard (
    id INT PRIMARY KEY,
    assigned_post VARCHAR(50),
    shift_start TIME,
    shift_end TIME
);

CREATE TABLE daily_door_access_logs (
    id INT PRIMARY KEY,
    guard_id INT REFERENCES guard (id),
    access_time TIME,
    door_location VARCHAR(255)
);

CREATE TABLE game_schedule (
    id INT PRIMARY KEY,
    type VARCHAR(50),
    date DATE,
    start_time TIME,
    end_time TIME
);