CREATE SCHEMA product;

ALTER SCHEMA product OWNER TO mart;

CREATE TABLE product.categories(
	id uuid not null default uuid_generate_v4() primary key,
	name text not null,
	description text,
	parent_id uuid,
	extra jsonb,
	ctime timestamp without time zone not null default now()::timestamp without time zone,
	utime timestamp without time zone not null default now()::timestamp without time zone
);

ALTER TABLE product.categories OWNER TO mart;

CREATE TABLE product.items(
	id uuid not null default uuid_generate_v4() primary key,
	name text not null,
	description text,
	sale_deadline date,
	unit text,
	min_value numeric,
	category_id uuid not null references product.categories(id) on delete restrict,
	extra jsonb,
	ctime timestamp without time zone not null default now()::timestamp without time zone,
	utime timestamp without time zone not null default now()::timestamp without time zone
);

ALTER TABLE product.items OWNER TO mart;

CREATE TABLE product.images(
	id uuid not null default uuid_generate_v4() primary key,
	product_id uuid not null references product.items(id) on delete restrict,
	url text not null
);

ALTER TABLE product.images OWNER TO mart;

CREATE TABLE product.prices(
	id uuid not null default uuid_generate_v4() primary key,
	price numeric not null,
	product_id uuid not null references product.items(id) on delete restrict
);

ALTER TABLE product.prices OWNER TO mart;



 
