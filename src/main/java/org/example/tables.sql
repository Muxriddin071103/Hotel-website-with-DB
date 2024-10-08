-- -- create database hotel_db
--
-- CREATE TABLE hotel (
--                        id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
--                        name VARCHAR(255) NOT NULL,
--                        description TEXT,
--                        image_url TEXT,
--                        active BOOLEAN DEFAULT TRUE
-- );
--
-- CREATE TABLE reservation (
--                              id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
--                              user_id UUID NOT NULL,
--                              room_id UUID NOT NULL,
--                              check_in_date TIMESTAMPTZ NOT NULL,
--                              check_out_date TIMESTAMPTZ NOT NULL,
--                              total_amount DECIMAL(10, 2) NOT NULL,
--                              confirmed BOOLEAN DEFAULT FALSE,
--                              FOREIGN KEY (user_id) REFERENCES users(id),
--                              FOREIGN KEY (room_id) REFERENCES room(id)
-- );
--
-- CREATE TABLE room (
--                       id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
--                       name VARCHAR(255) NOT NULL,
--                       description TEXT,
--                       image_url TEXT,
--                       price_per_night DECIMAL(10, 2) NOT NULL,
--                       available BOOLEAN DEFAULT TRUE
-- );
--
-- CREATE TABLE users (
--                        id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
--                        name VARCHAR(255) NOT NULL,
--                        email VARCHAR(255) UNIQUE NOT NULL,
--                        password VARCHAR(255) NOT NULL,
--                        is_active BOOLEAN DEFAULT TRUE
-- );
--
-- CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
--
-- CREATE TYPE location AS ENUM ('TASHKENT', 'NAMANGAN', 'BUXORO','ANDIJON','XORAZM'); -- Add your specific locations
-- CREATE TYPE type_room AS ENUM ('STANDARD', 'DELUXE', 'SUITE','EXECUTIVE'); -- Add your specific room types
-- CREATE TYPE role AS ENUM ('ADMIN', 'USER', 'GUEST'); -- Add your specific roles
--
-- ALTER TABLE hotel ADD location location;
-- ALTER TABLE room ADD type_room type_room;
-- ALTER TABLE users ADD role role;
--
-- -- User default values
-- INSERT INTO users (name, email, password, is_active, role)
-- VALUES
--     ('Admin', 'admin@gmail.com', 'root123', TRUE, 'ADMIN'),
--     ('User', 'user@gmail.com', 'user123', TRUE, 'USER'),
--     ('Guest', 'guest@gmail.com', 'guest123', TRUE, 'GUEST');
--
-- -- Insert default hotels
-- INSERT INTO hotel (name, description, image_url, active, location)
-- VALUES
--     ('Majestic Palace', 'Luxurious hotel with stunning views.', 'path/to/majestic_palace.png', TRUE, 'TASHKENT'),
--     ('Grand Central', 'Modern hotel in the heart of the city.', 'path/to/grand_central.png', TRUE, 'NAMANGAN'),
--     ('Ocean View Resort', 'Relaxing resort with beach access.', 'path/to/ocean_view_resort.png', TRUE, 'ANDIJON');
--
-- -- Suppose these are the retrieved UUIDs
-- -- <hotel_id_1> = 'bdf6a236-0607-4879-8c71-d9c005a1c933'
-- -- <hotel_id_2> = '00707a45-e1e6-423f-b6e4-ee458d857cf1'
-- -- <hotel_id_3> = '8d3370d9-46be-4635-9444-59da24297b15'
--
-- -- Insert default rooms for Majestic Palace
-- INSERT INTO room (name, description, image_url, price_per_night, available, type_room, hotel_id)
-- VALUES
--     ('Deluxe King', 'Spacious room with a king-sized bed and city views.', 'path/to/deluxe_king.png', 150.00, TRUE, 'DELUXE', 'bdf6a236-0607-4879-8c71-d9c005a1c933'),
--     ('Executive Suite', 'Luxurious suite with separate living area.', 'path/to/executive_suite.png', 250.00, TRUE, 'EXECUTIVE', 'bdf6a236-0607-4879-8c71-d9c005a1c933');
--
-- -- Insert default rooms for Grand Central
-- INSERT INTO room (name, description, image_url, price_per_night, available, type_room, hotel_id)
-- VALUES
--     ('Standard Double', 'Comfortable room with double bed.', 'path/to/standard_double.png', 100.00, TRUE, 'STANDARD', '00707a45-e1e6-423f-b6e4-ee458d857cf1'),
--     ('Suite Room', 'Modern suite with excellent amenities.', 'path/to/suite_room.png', 200.00, TRUE, 'SUITE', '00707a45-e1e6-423f-b6e4-ee458d857cf1');
--
-- -- Insert default rooms for Ocean View Resort
-- INSERT INTO room (name, description, image_url, price_per_night, available, type_room, hotel_id)
-- VALUES
--     ('Ocean Front Room', 'Room with breathtaking ocean views.', 'path/to/ocean_front.png', 180.00, TRUE, 'DELUXE', '8d3370d9-46be-4635-9444-59da24297b15'),
--     ('Beachside Suite', 'Luxurious suite with direct beach access.', 'path/to/beachside_suite.png', 300.00, TRUE, 'EXECUTIVE', '8d3370d9-46be-4635-9444-59da24297b15');
--
-- create type status as enum ('ACTIVE','CANCELED','FINISHED');
-- alter table reservation add status status

-- CREATE TABLE contact_messages (
--                                   id SERIAL PRIMARY KEY,
--                                   name VARCHAR(255) NOT NULL,
--                                   email VARCHAR(255) NOT NULL,
--                                   message TEXT NOT NULL,
--                                   created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
-- );
--
-- CREATE TABLE reservation (
--                              id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
--                              user_id UUID NOT NULL,
--                              room_id UUID NOT NULL,
--                              check_in_date TIMESTAMPTZ NOT NULL,
--                              check_out_date TIMESTAMPTZ NOT NULL,
--                              total_amount DECIMAL(10, 2) NOT NULL,
--                              confirmed BOOLEAN DEFAULT FALSE,
--                              status status,  -- ENUM column
--                              FOREIGN KEY (user_id) REFERENCES users(id),
--                              FOREIGN KEY (room_id) REFERENCES room(id)
-- );
--
-- CREATE TYPE status AS ENUM ('ACTIVE', 'CANCELED', 'FINISHED');

-- CREATE TABLE admin_responses (
--                                  id SERIAL PRIMARY KEY,
--                                  message_id INT NOT NULL,
--                                  response TEXT NOT NULL,
--                                  created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
--                                  FOREIGN KEY (message_id) REFERENCES contact_messages(id)
-- );

-- CREATE TABLE notifications (
--                                id SERIAL PRIMARY KEY,
--                                message TEXT NOT NULL,
--                                created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
-- );