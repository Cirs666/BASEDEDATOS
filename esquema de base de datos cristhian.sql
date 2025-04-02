CREATE SCHEMA users;
CREATE SCHEMA store;
CREATE SCHEMA buys;
CREATE SCHEMA promotion;

CREATE TABLE sale.sale(
	id SERIAL,
	id_users INTEGER NOT NULL,
	id_client INTEGER NOT NULL,
	id_detail INTEGER NOT NULL,
	date_sale DATE DEFAULT CURRENT_TIMESTAMP,
	stock INTEGER NULL,

	CONSTRAINT pk_sale PRIMARY KEY(id),
	CONSTRAINT fk_users_user FOREIGN KEY(id_user) REFERENCES users.users(id),
	CONSTRAINT fk_sale_client FOREIGN KEY(id_client) REFERENCES sale.client(id),
	CONSTRAINT fk_sale_detail FOREIGN KEY(id_detail) REFERENCES sale.sale_detail(id),
	CONSTRAINT stock_valid CHECK (stock>=0)
);

CREATE TABLE sale.client(
	id SERIAL,
	name_client TEXT NOT NULL,

	CONSTRAINT pk_client PRIMARY KEY(id)
);

CREATE TABLE sale.sale_detail(
	id SERIAL,
	id_item INTEGER NOT NULL,
	cost_detail INTEGER NOT NULL,
	amount INTEGER NULL,

	CONSTRAINT pk_detail PRIMARY KEY(id),
	CONSTRAINT fk_store_item FOREIGN KEY(id_item) REFERENCES store.item(id),
	CONSTRAINT amount_valid CHECK (amount>=0)
);
CREATE INDEX idx_sale_id_users ON sale.sale(id_users);
CREATE INDEX idx_users_name_users ON users.users(name_users);
CREATE INDEX idx_sale_id_users ON sale.sale(id_users);
CREATE INDEX idx_contract_id_employee ON users.contract(id_employee);
CREATE INDEX idx_position_id ON users.position(id);


CREATE TABLE store.store(
	id SERIAL,
	id_users INTEGER NOT NULL,
	id_item INTEGER NOT NULL,
	date_store DATE DEFAULT CURRENT_TIMESTAMP,
	motion CHAR(1) NOT NULL,
	amount_store INTEGER NULL,
	final_amount INTEGER NULL,

	CONSTRAINT pk_store PRIMARY KEY(id),
	CONSTRAINT fk_users_user FOREIGN KEY(id_user) REFERENCES users.users(id),
	CONSTRAINT fk_store_item FOREIGN KEY(id_item) REFERENCES store.item(id),
	CONSTRAINT amount_valid_store CHECK (amount_store >= 0),
	CONSTRAINT motion_valid CHECK (motion IN ('i', 's'))
);

CREATE TABLE store.item(
	id SERIAL,
	name_item TEXT NOT NULL,
	description_item TEXT NOT NULL,

	CONSTRAINT pk_item PRIMARY KEY(id)
);
CREATE INDEX idx_item_name ON store.item(name_item);
CREATE INDEX idx_store_id_item ON store.store(id_item);

CREATE TABLE users.users(
	id SERIAL,
	name_users TEXT NOT NULL,
	password_users TEXT NOT NULL,

	CONSTRAINT pk_user PRIMARY KEY(id)
);
CREATE INDEX idx_users_name_users ON users.users(name_users);


CREATE TABLE users.employee (
    id SERIAL,
    id_users INTEGER NOT NULL,
    name_employee TEXT NOT NULL,
    ap_paterno TEXT NULL,
    ap_materno TEXT NULL,

    CONSTRAINT pk_users_employee PRIMARY KEY(id),
    CONSTRAINT fk_users_users FOREIGN KEY(id_users) REFERENCES users.users(id)
);


CREATE TABLE users.contract(
	id SERIAL,
	id_employee INTEGER NOT NULL,
	id_position INTEGER NOT NULL,
	date_contract DATE DEFAULT CURRENT_TIMESTAMP,
	type_contract TEXT NOT NULL,
	time_contrat INTEGER,
	
	CONSTRAINT pk_users_contract PRIMARY KEY(id),
	CONSTRAINT fk_users_employee FOREIGN KEY(id_employee) REFERENCES users.employee(id),
	CONSTRAINT fk_users_position FOREIGN KEY(id_position) REFERENCES users.position(id),
	CONSTRAINT time_valid CHECK (time_contrat>0)
);

CREATE TABLE users.position(
	id SERIAL,
	name_position TEXT,
	description_position TEXT,

	CONSTRAINT pk_users_position PRIMARY KEY(id)
);

CREATE TABLE users.assing_area(
	id SERIAL,
	id_employee INTEGER NOT NULL,
	id_area INTEGER NOT NULL,

	CONSTRAINT pk_users_assing_area PRIMARY KEY(id),
	CONSTRAINT fk_users_employee FOREIGN KEY(id_employee) REFERENCES users.employee(id),
	CONSTRAINT fk_users_area FOREIGN KEY(id_area) REFERENCES users.area(id)
);


DROP TABLE USERS.area;
CREATE TABLE users.area(
	id SERIAL,
	location_area TEXT NOT NULL,
	description_area TEXT NULL,
	number_area INTEGER NOT NULL,

	CONSTRAINT pk_users_area PRIMARY KEY(id),
	CONSTRAINT number_valid CHECK (number_area > 0)
 );

 8CREATE TABLE users.control_access(
	id SERIAL,
	id_users INTEGER NOT NULL,
	admin_control_access TEXT NULL,
	buys_control_access TEXT NULL,
	sale_control_access TEXT NULL,
	store_control_access TEXT NULL,

	CONSTRAINT pk_users_control_access PRIMARY KEY(id),
	CONSTRAINT fk_users_user FOREIGN KEY(id_users) REFERENCES users.users(id)
);
CREATE INDEX idx_employee_id ON users.employee(id);
CREATE INDEX idx_contract_id_employee ON users.contract(id_employee);
CREATE INDEX idx_position_name_position ON users.position(name_position);

8CREATE TABLE buys.buys(
	id SERIAL,
	id_users INTEGER NOT NULL,
	id_buys_detail INTEGER NOT NULL,
	id_buys_supplier INTEGER NOT NULL,
	date_buys DATE DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT pk_buys PRIMARY KEY(id),
	CONSTRAINT fk_users_users FOREIGN KEY(id_users) REFERENCES users.users(id),
	CONSTRAINT fk_buys_detail FOREIGN KEY(id_buys_detail) REFERENCES buys.buys_detail(id),
	CONSTRAINT fk_buys_supplier FOREIGN KEY(id_buys_supplier) REFERENCES buys.buys_supplier(id)
);

CREATE TABLE buys.buys_detail(
	id SERIAL,
	id_item INTEGER NOT NULL,
	cost_detail INTEGER NOT NULL,
	amount_detail INTEGER NULL,

	CONSTRAINT pk_detail PRIMARY KEY(id),
	CONSTRAINT fk_store_item FOREIGN KEY(id_item) REFERENCES store.item(id),
	CONSTRAINT cost_valid CHECK (cost_detail>=0),
	CONSTRAINT amount_valid CHECK (amount_detail>=0)
);

CREATE TABLE buys.buys_supplier(
	id SERIAL,
	supplier_name TEXT NOT NULL,
	company_name TEXT NOT NULL,
	email TEXT NOT NULL,
	number_phone TEXT NOT NULL,

	CONSTRAINT pk_buys_supplier PRIMARY KEY(id)
);

CREATE TABLE promotion.promotion(
	id SERIAL,
	id_item INTEGER NOT NULL,
	date_promotion DATE DEFAULT CURRENT_TIMESTAMP,
	amount_promotion INTEGER NULL,
	discount INTEGER NULL,
	
	CONSTRAINT pk_promotion PRIMARY KEY(id),
	CONSTRAINT fk_store_item FOREIGN KEY(id_item) REFERENCES store.item(id),
	CONSTRAINT amount_valid CHECK (amount_promotion>=0),
	CONSTRAINT discount_valid CHECK (discount>0)
);
CREATE INDEX idx_promotion_item_id ON promotion.promotion(id_item);
CREATE INDEX idx_item_name ON store.item(name_item);