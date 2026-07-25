BEGIN TRANSACTION;
CREATE TABLE audit_log (
    id TEXT PRIMARY KEY,
    action TEXT NOT NULL,
    who TEXT,
    target TEXT,
    detail TEXT,
    ts TEXT
);
INSERT INTO "audit_log" VALUES('AUD-001','LOGIN','Carlos Mendoza','System','Logged in as Supervisor','2026-05-01T07:00');
INSERT INTO "audit_log" VALUES('AUD-002','SET_BALANCE','Carlos Mendoza','All Items','Set beginning balances for May 1, 2026','2026-05-01T07:05');
INSERT INTO "audit_log" VALUES('AUD-003','ADD_TXN','Carlos Mendoza','INV-004','IN — 35 Kg Pork Belly (Ramon Torres, Morning delivery)','2026-05-01T07:30');
INSERT INTO "audit_log" VALUES('AUD-004','ADD_TXN','Maria Santos','INV-009','IN — 8 Sacks Japanese Rice (Ramon Torres)','2026-05-01T07:45');
INSERT INTO "audit_log" VALUES('AUD-005','ADD_TXN','Carlos Mendoza','INV-004','OUT — 5 Kg Pork Belly (Pedro Reyes, Lunch service)','2026-05-01T10:00');
INSERT INTO "audit_log" VALUES('AUD-006','ADD_TXN','Carlos Mendoza','INV-005','OUT — 8 Kg Chicken (Juan dela Cruz, Lunch prep)','2026-05-01T10:30');
CREATE TABLE employees (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    department TEXT,
    position TEXT,
    employment_type TEXT,
    daily_rate REAL,
    days_worked INTEGER,
    ot_hours REAL,
    sss REAL,
    loan_deduction REAL,
    sss_no TEXT,
    philhealth_no TEXT,
    pagibig_no TEXT
);
INSERT INTO "employees" VALUES('EMP-001','Juan dela Cruz','Kitchen','Head Cook / Chef','Regular',1200.0,26,10.0,600.0,0.0,'34-5678901-2','03-123456789-0','1234-5678-01');
INSERT INTO "employees" VALUES('EMP-002','Maria Santos','Kitchen','Sous Chef','Regular',950.0,24,4.0,600.0,1000.0,'34-5678902-3','03-123456790-1','1234-5678-02');
INSERT INTO "employees" VALUES('EMP-003','Pedro Reyes','Kitchen','Line Cook','Regular',820.0,26,6.0,600.0,500.0,'34-5678903-4','03-123456791-2','1234-5678-03');
INSERT INTO "employees" VALUES('EMP-004','Ana Gonzales','Service','Head Waiter','Regular',750.0,25,8.0,600.0,0.0,'34-5678904-5','03-123456792-3','1234-5678-04');
INSERT INTO "employees" VALUES('EMP-005','Jose Bautista','Service','Waitress / Waiter','Probationary',650.0,23,0.0,600.0,0.0,'34-5678905-6','03-123456793-4','1234-5678-05');
INSERT INTO "employees" VALUES('EMP-006','Liza Fernandez','Service','Cashier','Regular',680.0,26,2.0,600.0,500.0,'34-5678906-7','03-123456794-5','1234-5678-06');
INSERT INTO "employees" VALUES('EMP-007','Carlos Mendoza','Management','Restaurant Manager','Regular',1350.0,26,12.0,600.0,0.0,'34-5678907-8','03-123456795-6','1234-5678-07');
INSERT INTO "employees" VALUES('EMP-008','Rosa Villanueva','Management','Assistant Manager','Probationary',900.0,22,0.0,600.0,1500.0,'34-5678908-9','03-123456796-7','1234-5678-08');
INSERT INTO "employees" VALUES('EMP-009','Ramon Torres','Utility','Dishwasher / Utility','Regular',580.0,26,4.0,600.0,0.0,'34-5678909-0','03-123456797-8','1234-5678-09');
INSERT INTO "employees" VALUES('EMP-010','Elena Aquino','Service','Hostess','Regular',640.0,25,3.0,600.0,0.0,'34-5678910-1','03-123456798-9','1234-5678-10');
CREATE TABLE items (
    code TEXT PRIMARY KEY,
    description TEXT NOT NULL,
    category TEXT,
    storage_type TEXT,
    unit TEXT,
    unit_cost REAL,
    moving_speed TEXT,
    beginning_qty INTEGER,
    beginning_balance_date TEXT,
    reorder_point INTEGER
);
INSERT INTO "items" VALUES('INV-001','Gochujang Paste (1kg)','Condiments & Sauces','Wet Goods','Pack',320.0,'Slow',20,'2026-05-01',10);
INSERT INTO "items" VALUES('INV-002','Doenjang / Soybean Paste (1kg)','Fermented / Preserved','Wet Goods','Pack',280.0,'Slow',15,'2026-05-01',8);
INSERT INTO "items" VALUES('INV-003','Sesame Oil (500ml)','Cooking Oil','Dry Goods','Bottle',195.0,'Fast',20,'2026-05-01',10);
INSERT INTO "items" VALUES('INV-004','Pork Belly (kg)','Meat','Wet Goods','Kg',360.0,'Fast',25,'2026-05-01',12);
INSERT INTO "items" VALUES('INV-005','Chicken (whole, kg)','Meat','Wet Goods','Kg',220.0,'Fast',30,'2026-05-01',15);
INSERT INTO "items" VALUES('INV-006','Bangus / Milkfish (kg)','Seafood','Wet Goods','Kg',220.0,'Fast',20,'2026-05-01',10);
INSERT INTO "items" VALUES('INV-007','Bagoong Alamang (250g)','Fermented / Preserved','Wet Goods','Jar',85.0,'Slow',30,'2026-05-01',15);
INSERT INTO "items" VALUES('INV-008','Calamansi (kg)','Vegetables','Wet Goods','Kg',120.0,'Fast',15,'2026-05-01',8);
INSERT INTO "items" VALUES('INV-009','Japanese Rice (25kg sack)','Grains & Noodles','Dry Goods','Sack',1450.0,'Fast',10,'2026-05-01',4);
INSERT INTO "items" VALUES('INV-010','Napa Cabbage (kg)','Vegetables','Wet Goods','Kg',75.0,'Fast',20,'2026-05-01',10);
INSERT INTO "items" VALUES('INV-011','Korean Ramen Noodles (pack)','Grains & Noodles','Dry Goods','Pack',55.0,'Fast',50,'2026-05-01',30);
INSERT INTO "items" VALUES('INV-012','Soy Sauce (1L)','Condiments & Sauces','Dry Goods','Bottle',95.0,'Fast',30,'2026-05-01',15);
INSERT INTO "items" VALUES('INV-013','Fish Sauce / Patis (750ml)','Condiments & Sauces','Dry Goods','Bottle',110.0,'Fast',25,'2026-05-01',12);
INSERT INTO "items" VALUES('INV-014','Kimchi (1kg homemade)','Fermented / Preserved','Wet Goods','Kg',340.0,'Fast',15,'2026-05-01',8);
INSERT INTO "items" VALUES('INV-015','Bibimbap Stone Bowl','Kitchen Equipment','Dry Goods','Piece',650.0,'Slow',20,'2026-05-01',5);
INSERT INTO "items" VALUES('INV-016','Disposable Chopsticks (box)','Disposable Supplies','Dry Goods','Box',280.0,'Slow',10,'2026-05-01',5);
INSERT INTO "items" VALUES('INV-017','LP Gas (11kg)','Cooking Fuel','Dry Goods','Tank',1100.0,'Slow',6,'2026-05-01',3);
INSERT INTO "items" VALUES('INV-018','Grill Charcoal (5kg bag)','Cooking Fuel','Dry Goods','Bag',220.0,'Fast',15,'2026-05-01',8);
INSERT INTO "items" VALUES('INV-019','Take-out Containers (100pcs)','Disposable Supplies','Dry Goods','Pack',350.0,'Fast',10,'2026-05-01',5);
INSERT INTO "items" VALUES('INV-020','Bond Paper A4 (ream)','Office Supplies','Dry Goods','Ream',210.0,'Slow',10,'2026-05-01',5);
CREATE TABLE rice_price_history (
    month TEXT PRIMARY KEY,
    price REAL
);
INSERT INTO "rice_price_history" VALUES('Jun 2025',1250.0);
INSERT INTO "rice_price_history" VALUES('Jul 2025',1280.0);
INSERT INTO "rice_price_history" VALUES('Aug 2025',1310.0);
INSERT INTO "rice_price_history" VALUES('Sep 2025',1350.0);
INSERT INTO "rice_price_history" VALUES('Oct 2025',1290.0);
INSERT INTO "rice_price_history" VALUES('Nov 2025',1320.0);
INSERT INTO "rice_price_history" VALUES('Dec 2025',1380.0);
INSERT INTO "rice_price_history" VALUES('Jan 2026',1420.0);
INSERT INTO "rice_price_history" VALUES('Feb 2026',1450.0);
INSERT INTO "rice_price_history" VALUES('Mar 2026',1400.0);
INSERT INTO "rice_price_history" VALUES('Apr 2026',1380.0);
INSERT INTO "rice_price_history" VALUES('May 2026',1450.0);
CREATE TABLE transactions (
    id TEXT PRIMARY KEY,
    item_code TEXT NOT NULL REFERENCES items(code),
    txn_type TEXT NOT NULL CHECK(txn_type IN ('IN','OUT')),
    qty INTEGER NOT NULL,
    person TEXT,
    purpose TEXT,
    ts TEXT NOT NULL,
    logged_by TEXT
);
INSERT INTO "transactions" VALUES('TXN-001','INV-004','IN',35,'Ramon Torres','Morning delivery — pork from supplier','2026-05-01T07:30','Carlos Mendoza');
INSERT INTO "transactions" VALUES('TXN-002','INV-005','IN',40,'Ramon Torres','Morning delivery — chicken','2026-05-01T07:35','Carlos Mendoza');
INSERT INTO "transactions" VALUES('TXN-003','INV-009','IN',8,'Ramon Torres','Rice delivery received','2026-05-01T07:45','Maria Santos');
INSERT INTO "transactions" VALUES('TXN-004','INV-004','OUT',5,'Pedro Reyes','Lunch service — samgyupsal','2026-05-01T10:00','Carlos Mendoza');
INSERT INTO "transactions" VALUES('TXN-005','INV-005','OUT',8,'Juan dela Cruz','Lunch prep — chicken adobo','2026-05-01T10:30','Carlos Mendoza');
INSERT INTO "transactions" VALUES('TXN-006','INV-009','OUT',2,'Juan dela Cruz','Cooking — daily rice','2026-05-01T11:00','Maria Santos');
INSERT INTO "transactions" VALUES('TXN-007','INV-006','OUT',4,'Pedro Reyes','Dinner service — bangus sinigang','2026-05-01T16:00','Carlos Mendoza');
INSERT INTO "transactions" VALUES('TXN-008','INV-010','OUT',3,'Pedro Reyes','Kimchi prep — napa cabbage','2026-05-01T09:00','Carlos Mendoza');
INSERT INTO "transactions" VALUES('TXN-009','INV-011','OUT',10,'Juan dela Cruz','Dinner — ramen orders','2026-05-01T18:00','Maria Santos');
INSERT INTO "transactions" VALUES('TXN-010','INV-012','OUT',2,'Pedro Reyes','Marinade preparation','2026-05-01T09:30','Carlos Mendoza');
INSERT INTO "transactions" VALUES('TXN-011','INV-004','OUT',6,'Juan dela Cruz','Dinner service — pork dishes','2026-05-01T17:00','Carlos Mendoza');
INSERT INTO "transactions" VALUES('TXN-012','INV-018','OUT',3,'Pedro Reyes','Grill setup — dinner service','2026-05-01T15:30','Carlos Mendoza');
CREATE TABLE users (
    name TEXT PRIMARY KEY,
    demo_password TEXT NOT NULL,
    default_role TEXT NOT NULL DEFAULT 'staff'
);
INSERT INTO "users" VALUES('Carlos Mendoza','carlos123','supervisor');
INSERT INTO "users" VALUES('Rosa Villanueva','rosa123','manager');
INSERT INTO "users" VALUES('Juan dela Cruz','juan123','staff');
INSERT INTO "users" VALUES('Maria Santos','maria123','manager');
INSERT INTO "users" VALUES('Pedro Reyes','pedro123','staff');
INSERT INTO "users" VALUES('Ana Gonzales','ana123','staff');
INSERT INTO "users" VALUES('Jose Bautista','jose123','staff');
INSERT INTO "users" VALUES('Liza Fernandez','liza123','staff');
INSERT INTO "users" VALUES('Ramon Torres','ramon123','staff');
INSERT INTO "users" VALUES('Elena Aquino','elena123','staff');
COMMIT;
