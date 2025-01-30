-- PostgreSQL database and table creation

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

CREATE SCHEMA yalo_raw;

CREATE TABLE yalo_raw.iowa_liquor_sale (
    invoice_and_item_number CHARACTER VARYING,
    date DATE,	
    store_number CHARACTER VARYING,	
    store_name CHARACTER VARYING,	
    address CHARACTER VARYING,	
    city CHARACTER VARYING,	
    zip_code CHARACTER VARYING,	
    store_location CHARACTER VARYING,	
    county_number CHARACTER VARYING,	
    county CHARACTER VARYING,	
    category CHARACTER VARYING,	
    category_name CHARACTER VARYING,	
    vendor_number CHARACTER VARYING,	
    vendor_name CHARACTER VARYING,	
    item_number CHARACTER VARYING,	
    item_description CHARACTER VARYING,	
    pack INTEGER,	
    bottle_volume_ml INTEGER,	
    state_bottle_cost FLOAT,	
    state_bottle_retail FLOAT,	
    bottles_sold INTEGER,	
    sale_dollars FLOAT,	
    volume_sold_liters FLOAT,	
    volume_sold_gallons FLOAT	
);
