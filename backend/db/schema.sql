DROP DATABASE IF EXISTS giftune_db;

CREATE DATABASE giftune_db;

\c giftune_db

DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id SERIAL PRIMARY KEY NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    dob DATE NOT NULL,
    email VARCHAR(255) NOT NULL
);

INSERT INTO users(user_name, first_name, last_name, dob, email) VALUES
('SysGrl', 'Naomi', 'Pate', '07/19/1995', 'naomi.pate@example.com'),
('CSGoBoy', 'Akira', 'Brown', '09/18/1999', 'akira.brown@example.com'),
('Johnno', 'John', 'Doe', '2000-05-15', 'john.doe@example.com'),
('MaryJ', 'Jane', 'Smith', '1995-08-23', 'jane.smith@example.com'),
('Mikey', 'Michael', 'Johnson', '1988-12-10', 'michael.johnson@example.com'),
('DaisyMay', 'Emily', 'Brown', '1992-07-28', 'emily.brown@example.com'),
('EvilDave', 'David', 'Martinez', '1984-04-03', 'david.martinez@example.com'),
('SaRah', 'Sarah', 'Anderson', '1998-09-17', 'sarah.anderson@example.com'),
('Matteww', 'Matthew', 'Wilson', '1990-03-20', 'matthew.wilson@example.com'),
('JessyJ', 'Jessica', 'Taylor', '1986-06-12', 'jessica.taylor@example.com'),
('ChrisT', 'Christopher', 'Thomas', '1993-11-08', 'christopher.thomas@example.com'),
('AmanR', 'Amanda', 'Roberts', '1982-02-25', 'amanda.roberts@example.com'),
('Andy', 'Andrew', 'Jackson', '1997-07-05', 'andrew.jackson@example.com'),
('ElizaHmm', 'Elizabeth', 'Hernandez', '1989-10-30', 'elizabeth.hernandez@example.com'),
('DannyPhntm', 'Daniel', 'Young', '1991-01-18', 'daniel.young@example.com'),
('MegLey', 'Megan', 'Lee', '1994-04-12', 'megan.lee@example.com'),
('KevGG', 'Kevin', 'Garcia', '1987-08-09', 'kevin.garcia@example.com'),
('RachLey', 'Rachel', 'Lewis', '1996-12-04', 'rachel.lewis@example.com'),
('AllJay', 'Jason', 'Hall', '1985-05-22', 'jason.hall@example.com'),
('QueenyL', 'Lauren', 'King', '1999-02-14', 'lauren.king@example.com');

DROP TABLE IF EXISTS friends_list;
CREATE TABLE friends_list (
    id SERIAL PRIMARY KEY NOT NULL,
    curr_user_id INTEGER REFERENCES users(id),
    other_user_id INTEGER REFERENCES users(id),
    curr_status VARCHAR(255) NOT NULL
);
INSERT INTO friends_list(curr_user_id, other_user_id, curr_status) VALUES
(1, 2, 'friends'),
(2, 1, 'friends');

DROP TABLE IF EXISTS wishlist;
CREATE TABLE wishlist (
    id SERIAL PRIMARY KEY NOT NULL,
    user_id INTEGER REFERENCES users(id),
    is_bought BOOLEAN NOT NULL,
    item_name VARCHAR(255),
    item_price NUMERIC(10, 2),
    link TEXT
);

INSERT INTO wishlist(user_id, is_bought, item_name, item_price, link) VALUES
(1, false,'Floral V-Neck Long Puff Sleeve Cutout Mini Dress', 118.00, 'https://www.express.com/clothing/women/floral-v-neck-long-puff-sleeve-cutout-mini-dress/pro/07809360/color/Multi/size/xs/'),
(2, false,'watch', 22.95, 'https://www.amazon.com/Casio-F108WH-Illuminator-Collection-Digital/dp/B0053HBJBE/ref=sr_1_2?crid=2ZSOX1A7Q9BR8&keywords=watch&qid=1698683161&sprefix=watch%2Caps%2C67&sr=8-2');

DROP TABLE IF EXISTS notifications;
CREATE TABLE notifications (
    id SERIAL PRIMARY KEY NOT NULL,
    user_id INTEGER REFERENCES users(id),
    date_stamp DATE NOT NULL,
    time_stamp TIME NOT NULL,
    sender_id INTEGER REFERENCES users(id),
    sender_name TEXT,
    msg_type TEXT,
    messages TEXT,
    is_read BOOLEAN
);
INSERT INTO notifications(user_id, date_stamp, time_stamp, sender_id, sender_name, msg_type, messages, is_read) VALUES
(1, '2024-03-21', '16:00:00', 2, 'Akira', 'purchase', 'An Item has been bought', false),
(2, '2024-03-21', '16:00:00', 1, 'Naomi', 'purchase', 'An Item has been bought', false);

DROP TABLE IF EXISTS events;
CREATE TABLE events (
    id SERIAL PRIMARY KEY NOT NULL,
    user_id INTEGER REFERENCES users(id),
    event_date DATE NOT NULL,
    event_time TIME NOT NULL,
    google_location TEXT NOT NULL
);
INSERT INTO events(user_id, event_date, event_time, google_location) VALUES
(1, '2023-12-21', '14:00:00', '47-10 Austell Pl 2nd floor, Long Island City, NY 11101'),
(2, '2023-12-22', '15:00:00', '350 Fifth Avenue, New York, NY 10118'),
(3, '2023-12-23', '16:00:00', '4 Pennsylvania Plaza, New York, NY 10001'),
(4, '2023-12-24', '17:00:00', 'One World Trade Center, New York, NY 10007'),
(5, '2023-12-25', '18:00:00', '89 E 42nd Street, New York, NY 10017');
