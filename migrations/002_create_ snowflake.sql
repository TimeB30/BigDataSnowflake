CREATE SCHEMA IF NOT EXISTS snowflake;

CREATE TABLE IF NOT EXISTS snowflake.product_categories(
    id SERIAL PRIMARY KEY,
    name  VARCHAR(50) NOT NULL
);
CREATE TABLE IF NOT EXISTS snowflake.countries(
    id SERIAL PRIMARY KEY,
    country VARCHAR (100) NOT NULL
);
CREATE TABLE IF NOT EXISTS snowflake.cities(
    id SERIAL PRIMARY KEY,
    country_id INT NOT NULL,
    city VARCHAR(100) NOT NULL,
    FOREIGN KEY(country_id) REFERENCES snowflake.countries(id) ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS snowflake.pet_types(
    id SERIAL PRIMARY KEY,
    type VARCHAR(50) NOT NULL
);
CREATE TABLE IF NOT EXISTS snowflake.pet_categories(
    id SERIAL PRIMARY KEY,
    category VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS snowflake.colors(
    id SERIAL PRIMARY KEY,
    color VARCHAR(50) NOT NULL
);
CREATE TABLE IF NOT EXISTS snowflake.sizes(
    id SERIAL PRIMARY KEY,
    size VARCHAR(50) NOT NULL
);
CREATE TABLE IF NOT EXISTS snowflake.materials(
    id SERIAL PRIMARY KEY,
    material VARCHAR(50) NOT NULL
);
CREATE TABLE IF NOT EXISTS snowflake.brands(
    id SERIAL PRIMARY KEY,
    brand VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS snowflake.days(
    id INT PRIMARY KEY
);
CREATE TABLE IF NOT EXISTS snowflake.months(
    id INT PRIMARY KEY
);
CREATE TABLE IF NOT EXISTS snowflake.years(
    id INT PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS snowflake.d_date(
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    day_id INT NOT NULL,
    month_id INT NOT NULL,
    year_id INT NOT NULL,
    FOREIGN KEY(day_id) REFERENCES snowflake.days(id),
    FOREIGN KEY(month_id) REFERENCES snowflake.months(id),
    FOREIGN KEY(year_id) REFERENCES snowflake.years(id)
);
CREATE TABLE snowflake.store_states(
    id SERIAL PRIMARY KEY,
    state VARCHAR(50)
);
CREATE TABLE snowflake.pet_breeds
(
    id SERIAL PRIMARY KEY,
    breed VARCHAR(50),
    pet_type_id INT,
    FOREIGN KEY(pet_type_id) REFERENCES snowflake.pet_types(id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS snowflake.products(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category_id INT,
    price NUMERIC(10, 2) NOT NULL,
    quantity int NOT NULL,
    release_date_id INT NOT NULL,
    expiry_date_id INT NOT NULL,
    rating NUMERIC(3, 2) DEFAULT  NULL,
    reviews INT DEFAULT NULL,
    weight NUMERIC(10, 2) NOT NULL,
    color_id INT,
    size_id INT,
    material_id INT,
    brand_id INT,
    description VARCHAR(1000),
    FOREIGN KEY(color_id) REFERENCES snowflake.colors(id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY(size_id) REFERENCES snowflake.sizes(id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY(material_id) REFERENCES snowflake.materials(id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY(brand_id) REFERENCES snowflake.brands(id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY(category_id) REFERENCES snowflake.pet_categories(id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (category_id) REFERENCES snowflake.product_categories(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(release_date_id) REFERENCES snowflake.d_date(id)  ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(expiry_date_id) REFERENCES snowflake.d_date(id)  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS snowflake.stores(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(255) NOT NULL,
    city_id INT NOT NULL,
    state_id INT,
    country_id INT NOT NULL,
    phone VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL,
    FOREIGN KEY(country_id) REFERENCES snowflake.countries(id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY(city_id) REFERENCES snowflake.cities(id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY(state_id) REFERENCES snowflake.store_states(id) ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS snowflake.sellers(
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    store_id INT NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    country_id INT NOT NULL,
    postal_code VARCHAR(50),
    FOREIGN KEY(country_id) REFERENCES snowflake.countries(id),
    FOREIGN KEY(store_id) REFERENCES snowflake.stores(id)
);

CREATE TABLE IF NOT EXISTS snowflake.pets(
    id SERIAL PRIMARY KEY,
    type_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    breed_id INT,
    FOREIGN KEY(type_id) REFERENCES snowflake.pet_types(id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY(breed_id) REFERENCES snowflake.pet_breeds(id) ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS snowflake.customers(
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    age INT NOT NULL,
    email VARCHAR(255) NOT NULL,
    country_id INT NOT NULL,
    postal_code VARCHAR(50),
    FOREIGN KEY(country_id) REFERENCES snowflake.countries(id) ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS snowflake.customers_pets(
    customer_id INT NOT NULL,
    pet_id INT NOT NULL,
    FOREIGN KEY(customer_id) REFERENCES snowflake.customers(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(pet_id) REFERENCES snowflake.pets(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS snowflake.suppliers(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    contact VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(50) NOT NULL,
    address VARCHAR(255) NOT NULL,
    city_id INT,
    country_id INT,
    FOREIGN KEY(city_id) REFERENCES snowflake.cities(id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY(country_id) REFERENCES snowflake.countries(id) ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS snowflake.products_suppliers(
    product_id INT NOT NULL,
    supplier_id INT NOT NULL,
    FOREIGN KEY(product_id) REFERENCES snowflake.products(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(supplier_id) REFERENCES snowflake.suppliers(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS snowflake.sales(
    id SERIAL PRIMARY KEY,
    date_id INT NOT NULL,
    customer_id INT NOT NULL,
    seller_id INT NOT NULL,
    store_id INT NOT NULL,
    supplier_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    total_price NUMERIC(10, 2) NOT NULL,
    FOREIGN KEY(customer_id) REFERENCES snowflake.customers(id) ON UPDATE NO ACTION ON DELETE NO ACTION,
    FOREIGN KEY(seller_id) REFERENCES snowflake.sellers(id) ON UPDATE NO ACTION ON DELETE NO ACTION,
    FOREIGN KEY(store_id) REFERENCES snowflake.stores(id) ON UPDATE NO ACTION ON DELETE NO ACTION,
    FOREIGN KEY(supplier_id) REFERENCES snowflake.suppliers(id) ON UPDATE NO ACTION ON DELETE NO ACTION,
    FOREIGN KEY(date_id) REFERENCES snowflake.d_date(id) ON DELETE NO ACTION ON UPDATE CASCADE

);