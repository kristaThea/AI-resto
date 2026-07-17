-- ══════════════════════════════════════════════════════════════
-- AI FILIPINO KOREAN RESTAURANT
-- Management System — Database Schema v1.0
-- Generated: May 2026
-- ══════════════════════════════════════════════════════════════

CREATE DATABASE IF NOT EXISTS air_management
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE air_management;

-- ──────────────────────────────────────
-- TABLE: users
-- Stores all system users / employees
-- ──────────────────────────────────────
CREATE TABLE users (
  id VARCHAR(10) NOT NULL,
  name VARCHAR(100) NOT NULL,
  password VARCHAR(255) NOT NULL COMMENT 'Plaintext for demo; use bcrypt in production',
  role ENUM('supervisor','manager','staff') NOT NULL DEFAULT 'staff',
  department VARCHAR(50) DEFAULT NULL,
  position VARCHAR(100) DEFAULT NULL,
  employment_type ENUM('Regular','Probationary') NOT NULL DEFAULT 'Regular',
  daily_rate DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  days_worked INT NOT NULL DEFAULT 0,
  ot_hours DECIMAL(5,2) NOT NULL DEFAULT 0.00,
  sss_contribution DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  loan_deduction DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  sss_number VARCHAR(20) DEFAULT NULL,
  philhealth_number VARCHAR(20) DEFAULT NULL,
  pagibig_number VARCHAR(20) DEFAULT NULL,
  pay_period DATE DEFAULT NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_role (role),
  KEY idx_dept (department)
) ENGINE=InnoDB;

-- ──────────────────────────────────────
-- TABLE: inventory_items
-- Master list of all inventory products
-- ──────────────────────────────────────
CREATE TABLE inventory_items (
  code VARCHAR(10) NOT NULL,
  description VARCHAR(255) NOT NULL,
  category VARCHAR(60) NOT NULL,
  storage_type ENUM('Wet Goods','Dry Goods') NOT NULL,
  unit VARCHAR(20) NOT NULL,
  unit_cost DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  moving_speed ENUM('Fast','Slow') NOT NULL DEFAULT 'Slow',
  reorder_point INT NOT NULL DEFAULT 0,
  beginning_balance_qty INT NOT NULL DEFAULT 0,
  beginning_balance_date DATE DEFAULT NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  created_by VARCHAR(100) DEFAULT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (code),
  KEY idx_cat (category),
  KEY idx_storage (storage_type),
  KEY idx_moving (moving_speed)
) ENGINE=InnoDB;

-- ──────────────────────────────────────
-- TABLE: inventory_transactions
-- All IN / OUT stock movements
-- ──────────────────────────────────────
CREATE TABLE inventory_transactions (
  id VARCHAR(10) NOT NULL,
  item_code VARCHAR(10) NOT NULL,
  transaction_type ENUM('IN','OUT') NOT NULL,
  quantity INT NOT NULL,
  person_name VARCHAR(100) NOT NULL COMMENT 'Who received or took the item',
  purpose TEXT DEFAULT NULL,
  transaction_datetime DATETIME NOT NULL,
  logged_by VARCHAR(100) NOT NULL COMMENT 'System user who recorded this entry',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_item (item_code),
  KEY idx_type (transaction_type),
  KEY idx_dt (transaction_datetime),
  KEY idx_person (person_name),
  CONSTRAINT fk_txn_item FOREIGN KEY (item_code)
    REFERENCES inventory_items (code)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ──────────────────────────────────────
-- TABLE: audit_log
-- Immutable record of all system actions
-- ──────────────────────────────────────
CREATE TABLE audit_log (
  id VARCHAR(10) NOT NULL,
  action VARCHAR(60) NOT NULL,
  performed_by VARCHAR(100) NOT NULL,
  target VARCHAR(100) DEFAULT NULL,
  detail TEXT DEFAULT NULL,
  performed_at DATETIME NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_action (action),
  KEY idx_who (performed_by),
  KEY idx_dt (performed_at)
) ENGINE=InnoDB;

-- ──────────────────────────────────────
-- TABLE: price_history
-- Tracks unit cost per item over time
-- for analytics and purchasing decisions
-- ──────────────────────────────────────
CREATE TABLE price_history (
  id INT NOT NULL AUTO_INCREMENT,
  item_code VARCHAR(10) NOT NULL,
  unit_cost DECIMAL(10,2) NOT NULL,
  period_label VARCHAR(20) NOT NULL COMMENT 'e.g. May 2026',
  period_date DATE NOT NULL,
  recorded_by VARCHAR(100) DEFAULT NULL,
  notes TEXT DEFAULT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_item (item_code),
  KEY idx_period (period_date),
  CONSTRAINT fk_ph_item FOREIGN KEY (item_code)
    REFERENCES inventory_items (code)
    ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

-- ══════════════════════════════════════
-- SEED DATA — USERS / EMPLOYEES
-- ══════════════════════════════════════
INSERT INTO users
  (id, name, password, role, department, position, employment_type,
   daily_rate, days_worked, ot_hours, sss_contribution, loan_deduction,
   sss_number, philhealth_number, pagibig_number, pay_period)
VALUES
  ('EMP-001','Juan dela Cruz', 'juan2026', 'staff', 'Kitchen', 'Head Cook / Chef', 'Regular', 1200, 26, 10, 600, 0, '34-5678901-2','03-123456789-0','1234-5678-01','2026-05-01'),
  ('EMP-002','Maria Santos', 'maria2026', 'staff', 'Kitchen', 'Sous Chef', 'Regular', 950, 24, 4, 600, 1000, '34-5678902-3','03-123456790-1','1234-5678-02','2026-05-01'),
  ('EMP-003','Pedro Reyes', 'pedro2026', 'staff', 'Kitchen', 'Line Cook', 'Regular', 820, 26, 6, 600, 500, '34-5678903-4','03-123456791-2','1234-5678-03','2026-05-01'),
  ('EMP-004','Ana Gonzales', 'ana2026', 'staff', 'Service', 'Head Waiter', 'Regular', 750, 25, 8, 600, 0, '34-5678904-5','03-123456792-3','1234-5678-04','2026-05-01'),
  ('EMP-005','Jose Bautista', 'jose2026', 'staff', 'Service', 'Waitress / Waiter', 'Probationary', 650, 23, 0, 600, 0, '34-5678905-6','03-123456793-4','1234-5678-05','2026-05-01'),
  ('EMP-006','Liza Fernandez', 'liza2026', 'staff', 'Service', 'Cashier', 'Regular', 680, 26, 2, 600, 500, '34-5678906-7','03-123456794-5','1234-5678-06','2026-05-01'),
  ('EMP-007','Carlos Mendoza', 'carlos2026', 'supervisor', 'Management', 'Restaurant Manager', 'Regular', 1350, 26, 12, 600, 0, '34-5678907-8','03-123456795-6','1234-5678-07','2026-05-01'),
  ('EMP-008','Rosa Villanueva', 'rosa2026', 'manager', 'Management', 'Assistant Manager', 'Probationary', 900, 22, 0, 600, 1500, '34-5678908-9','03-123456796-7','1234-5678-08','2026-05-01'),
  ('EMP-009','Ramon Torres', 'ramon2026', 'staff', 'Utility', 'Dishwasher / Utility', 'Regular', 580, 26, 4, 600, 0, '34-5678909-0','03-123456797-8','1234-5678-09','2026-05-01'),
  ('EMP-010','Elena Aquino', 'elena2026', 'staff', 'Service', 'Hostess', 'Regular', 640, 25, 3, 600, 0, '34-5678910-1','03-123456798-9','1234-5678-10','2026-05-01');

-- ══════════════════════════════════════
-- SEED DATA — INVENTORY ITEMS
-- ══════════════════════════════════════
INSERT INTO inventory_items
  (code, description, category, storage_type, unit, unit_cost, moving_speed, reorder_point, beginning_balance_qty, beginning_balance_date)
VALUES
  ('INV-001','Gochujang Paste (1kg)', 'Condiments & Sauces', 'Wet Goods', 'Pack', 320.00, 'Slow', 10, 20, '2026-05-01'),
  ('INV-002','Doenjang / Soybean Paste (1kg)', 'Fermented / Preserved', 'Wet Goods', 'Pack', 280.00, 'Slow', 8, 15, '2026-05-01'),
  ('INV-003','Sesame Oil (500ml)', 'Cooking Oil', 'Dry Goods', 'Bottle', 195.00, 'Fast', 10, 20, '2026-05-01'),
  ('INV-004','Pork Belly (kg)', 'Meat', 'Wet Goods', 'Kg', 360.00, 'Fast', 12, 25, '2026-05-01'),
  ('INV-005','Chicken (whole, kg)', 'Meat', 'Wet Goods', 'Kg', 220.00, 'Fast', 15, 30, '2026-05-01'),
  ('INV-006','Bangus / Milkfish (kg)', 'Seafood', 'Wet Goods', 'Kg', 220.00, 'Fast', 10, 20, '2026-05-01'),
  ('INV-007','Bagoong Alamang (250g)', 'Fermented / Preserved', 'Wet Goods', 'Jar', 85.00, 'Slow', 15, 30, '2026-05-01'),
  ('INV-008','Calamansi (kg)', 'Vegetables', 'Wet Goods', 'Kg', 120.00, 'Fast', 8, 15, '2026-05-01'),
  ('INV-009','Japanese Rice (25kg sack)', 'Grains & Noodles', 'Dry Goods', 'Sack', 1450.00, 'Fast', 4, 10, '2026-05-01'),
  ('INV-010','Napa Cabbage (kg)', 'Vegetables', 'Wet Goods', 'Kg', 75.00, 'Fast', 10, 20, '2026-05-01'),
  ('INV-011','Korean Ramen Noodles (pack)', 'Grains & Noodles', 'Dry Goods', 'Pack', 55.00, 'Fast', 30, 50, '2026-05-01'),
  ('INV-012','Soy Sauce (1L)', 'Condiments & Sauces', 'Dry Goods', 'Bottle', 95.00, 'Fast', 15, 30, '2026-05-01'),
  ('INV-013','Fish Sauce / Patis (750ml)', 'Condiments & Sauces', 'Dry Goods', 'Bottle', 110.00, 'Fast', 12, 25, '2026-05-01'),
  ('INV-014','Kimchi (1kg homemade)', 'Fermented / Preserved', 'Wet Goods', 'Kg', 340.00, 'Fast', 8, 15, '2026-05-01'),
  ('INV-015','Bibimbap Stone Bowl', 'Kitchen Equipment', 'Dry Goods', 'Piece', 650.00, 'Slow', 5, 20, '2026-05-01'),
  ('INV-016','Disposable Chopsticks (box)', 'Disposable Supplies', 'Dry Goods', 'Box', 280.00, 'Slow', 5, 10, '2026-05-01'),
  ('INV-017','LP Gas (11kg)', 'Cooking Fuel', 'Dry Goods', 'Tank', 1100.00, 'Slow', 3, 6, '2026-05-01'),
  ('INV-018','Grill Charcoal (5kg bag)', 'Cooking Fuel', 'Dry Goods', 'Bag', 220.00, 'Fast', 8, 15, '2026-05-01'),
  ('INV-019','Take-out Containers (100pcs)', 'Disposable Supplies', 'Dry Goods', 'Pack', 350.00, 'Fast', 5, 10, '2026-05-01'),
  ('INV-020','Bond Paper A4 (ream)', 'Office Supplies', 'Dry Goods', 'Ream', 210.00, 'Slow', 5, 10, '2026-05-01');

-- ══════════════════════════════════════
-- SEED DATA — TRANSACTIONS
-- ══════════════════════════════════════
INSERT INTO inventory_transactions
  (id, item_code, transaction_type, quantity, person_name, purpose, transaction_datetime, logged_by)
VALUES
  ('TXN-001','INV-004','IN', 35,'Ramon Torres', 'Morning delivery — pork from supplier', '2026-05-01 07:30:00','Carlos Mendoza'),
  ('TXN-002','INV-005','IN', 40,'Ramon Torres', 'Morning delivery — chicken', '2026-05-01 07:35:00','Carlos Mendoza'),
  ('TXN-003','INV-009','IN', 8,'Ramon Torres', 'Rice delivery received', '2026-05-01 07:45:00','Maria Santos'),
  ('TXN-004','INV-004','OUT', 5,'Pedro Reyes', 'Lunch service — samgyupsal', '2026-05-01 10:00:00','Carlos Mendoza'),
  ('TXN-005','INV-005','OUT', 8,'Juan dela Cruz','Lunch prep — chicken adobo', '2026-05-01 10:30:00','Carlos Mendoza'),
  ('TXN-006','INV-009','OUT', 2,'Juan dela Cruz','Cooking — daily rice preparation', '2026-05-01 11:00:00','Maria Santos'),
  ('TXN-007','INV-006','OUT', 4,'Pedro Reyes', 'Dinner service — bangus sinigang', '2026-05-01 16:00:00','Carlos Mendoza'),
  ('TXN-008','INV-010','OUT', 3,'Pedro Reyes', 'Kimchi prep — napa cabbage', '2026-05-01 09:00:00','Carlos Mendoza'),
  ('TXN-009','INV-011','OUT', 10,'Juan dela Cruz','Dinner — ramen orders', '2026-05-01 18:00:00','Maria Santos'),
  ('TXN-010','INV-012','OUT', 2,'Pedro Reyes', 'Marinade preparation', '2026-05-01 09:30:00','Carlos Mendoza'),
  ('TXN-011','INV-004','OUT', 6,'Juan dela Cruz','Dinner service — pork dishes', '2026-05-01 17:00:00','Carlos Mendoza'),
  ('TXN-012','INV-018','OUT', 3,'Pedro Reyes', 'Grill setup — dinner service', '2026-05-01 15:30:00','Carlos Mendoza');

-- ══════════════════════════════════════
-- SEED DATA — PRICE HISTORY (Rice)
-- ══════════════════════════════════════
INSERT INTO price_history (item_code, unit_cost, period_label, period_date, recorded_by) VALUES
  ('INV-009', 1250.00, 'Jun 2025', '2025-06-01', 'Carlos Mendoza'),
  ('INV-009', 1280.00, 'Jul 2025', '2025-07-01', 'Carlos Mendoza'),
  ('INV-009', 1310.00, 'Aug 2025', '2025-08-01', 'Carlos Mendoza'),
  ('INV-009', 1350.00, 'Sep 2025', '2025-09-01', 'Carlos Mendoza'),
  ('INV-009', 1290.00, 'Oct 2025', '2025-10-01', 'Carlos Mendoza'),
  ('INV-009', 1320.00, 'Nov 2025', '2025-11-01', 'Carlos Mendoza'),
  ('INV-009', 1380.00, 'Dec 2025', '2025-12-01', 'Carlos Mendoza'),
  ('INV-009', 1420.00, 'Jan 2026', '2026-01-01', 'Carlos Mendoza'),
  ('INV-009', 1450.00, 'Feb 2026', '2026-02-01', 'Carlos Mendoza'),
  ('INV-009', 1400.00, 'Mar 2026', '2026-03-01', 'Carlos Mendoza'),
  ('INV-009', 1380.00, 'Apr 2026', '2026-04-01', 'Carlos Mendoza'),
  ('INV-009', 1450.00, 'May 2026', '2026-05-01', 'Carlos Mendoza');

-- ══════════════════════════════════════
-- SEED DATA — AUDIT LOG
-- ══════════════════════════════════════
INSERT INTO audit_log (id, action, performed_by, target, detail, performed_at) VALUES
  ('AUD-001','LOGIN', 'Carlos Mendoza','System', 'Logged in as supervisor', '2026-05-01 07:00:00'),
  ('AUD-002','SET_BALANCE', 'Carlos Mendoza','All Items','Set beginning balances for May 1, 2026', '2026-05-01 07:05:00'),
  ('AUD-003','ADD_TXN', 'Carlos Mendoza','INV-004', 'IN — 35 Kg Pork Belly (Ramon Torres, Morning delivery)', '2026-05-01 07:30:00'),
  ('AUD-004','ADD_TXN', 'Maria Santos', 'INV-009', 'IN — 8 Sacks Japanese Rice (Ramon Torres)', '2026-05-01 07:45:00'),
  ('AUD-005','ADD_TXN', 'Carlos Mendoza','INV-004', 'OUT — 5 Kg Pork Belly (Pedro Reyes, Lunch service)', '2026-05-01 10:00:00'),
  ('AUD-006','ADD_TXN', 'Carlos Mendoza','INV-005', 'OUT — 8 Kg Chicken (Juan dela Cruz, Lunch prep)', '2026-05-01 10:30:00');

-- ══════════════════════════════════════
-- VIEWS
-- ══════════════════════════════════════

-- Current stock per item (beginning balance + IN - OUT)
CREATE OR REPLACE VIEW v_current_stock AS
SELECT
  i.code,
  i.description,
  i.category,
  i.storage_type,
  i.unit,
  i.unit_cost,
  i.moving_speed,
  i.reorder_point,
  i.beginning_balance_qty,
  i.beginning_balance_date,
  COALESCE(SUM(CASE WHEN t.transaction_type='IN' AND t.transaction_datetime >= i.beginning_balance_date THEN t.quantity ELSE 0 END), 0) AS total_in,
  COALESCE(SUM(CASE WHEN t.transaction_type='OUT' AND t.transaction_datetime >= i.beginning_balance_date THEN t.quantity ELSE 0 END), 0) AS total_out,
  i.beginning_balance_qty
    + COALESCE(SUM(CASE WHEN t.transaction_type='IN' AND t.transaction_datetime >= i.beginning_balance_date THEN t.quantity ELSE 0 END), 0)
    - COALESCE(SUM(CASE WHEN t.transaction_type='OUT' AND t.transaction_datetime >= i.beginning_balance_date THEN t.quantity ELSE 0 END), 0) AS current_stock,
  CASE
    WHEN i.beginning_balance_qty
      + COALESCE(SUM(CASE WHEN t.transaction_type='IN' AND t.transaction_datetime >= i.beginning_balance_date THEN t.quantity ELSE 0 END), 0)
      - COALESCE(SUM(CASE WHEN t.transaction_type='OUT' AND t.transaction_datetime >= i.beginning_balance_date THEN t.quantity ELSE 0 END), 0)
      <= i.reorder_point
    THEN 'REORDER' ELSE 'OK'
  END AS stock_status,
  (i.beginning_balance_qty
    + COALESCE(SUM(CASE WHEN t.transaction_type='IN' AND t.transaction_datetime >= i.beginning_balance_date THEN t.quantity ELSE 0 END), 0)
    - COALESCE(SUM(CASE WHEN t.transaction_type='OUT' AND t.transaction_datetime >= i.beginning_balance_date THEN t.quantity ELSE 0 END), 0))
    * i.unit_cost AS current_value
FROM inventory_items i
LEFT JOIN inventory_transactions t ON t.item_code = i.code
WHERE i.is_active = 1
GROUP BY i.code;

-- Monthly payroll summary
CREATE OR REPLACE VIEW v_payroll_summary AS
SELECT
  u.id,
  u.name,
  u.department,
  u.position,
  u.employment_type,
  u.daily_rate,
  u.days_worked,
  u.ot_hours,
  ROUND(u.daily_rate * u.days_worked, 2) AS basic_pay,
  ROUND((u.daily_rate / 8) * 1.25 * u.ot_hours, 2) AS ot_pay,
  ROUND(u.daily_rate * u.days_worked + (u.daily_rate/8)*1.25*u.ot_hours, 2) AS gross_pay,
  u.sss_contribution AS sss,
  LEAST(ROUND(u.daily_rate * 26 * 0.025, 2), 1250.00) AS philhealth,
  200.00 AS pagibig,
  GREATEST(ROUND((u.daily_rate * 26 - 20833) * 0.20, 2), 0) AS withholding_tax,
  u.loan_deduction AS loan,
  ROUND(
    u.sss_contribution
    + LEAST(ROUND(u.daily_rate * 26 * 0.025, 2), 1250.00)
    + 200.00
    + GREATEST(ROUND((u.daily_rate * 26 - 20833) * 0.20, 2), 0)
    + u.loan_deduction
  , 2) AS total_deductions,
  ROUND(
    (u.daily_rate * u.days_worked + (u.daily_rate/8)*1.25*u.ot_hours)
    - (u.sss_contribution
       + LEAST(ROUND(u.daily_rate * 26 * 0.025, 2), 1250.00)
       + 200.00
       + GREATEST(ROUND((u.daily_rate * 26 - 20833) * 0.20, 2), 0)
       + u.loan_deduction)
  , 2) AS net_pay
FROM users u
WHERE u.is_active = 1;

-- ══════════════════════════════════════
-- USEFUL QUERIES
-- ══════════════════════════════════════

-- Q1: Items at or below reorder point
-- SELECT * FROM v_current_stock WHERE stock_status = 'REORDER';

-- Q2: Fast-moving items by total OUT quantity
-- SELECT i.description, SUM(t.quantity) AS total_issued
-- FROM inventory_items i
-- JOIN inventory_transactions t ON t.item_code = i.code AND t.transaction_type = 'OUT'
-- WHERE i.moving_speed = 'Fast'
-- GROUP BY i.code ORDER BY total_issued DESC;

-- Q3: Monthly payroll totals
-- SELECT SUM(gross_pay) AS total_gross, SUM(total_deductions) AS total_ded, SUM(net_pay) AS total_net
-- FROM v_payroll_summary;

-- Q4: Transaction history for a specific item
-- SELECT t.*, i.description, i.unit
-- FROM inventory_transactions t
-- JOIN inventory_items i ON i.code = t.item_code
-- WHERE t.item_code = 'INV-004'
-- ORDER BY t.transaction_datetime DESC;

-- Q5: Who issued the most stock (sorted by quantity)
-- SELECT person_name, SUM(quantity) AS total_out
-- FROM inventory_transactions WHERE transaction_type='OUT'
-- GROUP BY person_name ORDER BY total_out DESC;

-- Q6: Full audit trail for today
-- SELECT * FROM audit_log WHERE DATE(performed_at) = CURDATE() ORDER BY performed_at DESC;

-- Q7: Rice price trend
-- SELECT period_label, unit_cost FROM price_history WHERE item_code='INV-009' ORDER BY period_date;

-- ══════════════════════════════════════
-- DEFAULT CREDENTIALS (for reference)
-- ══════════════════════════════════════
-- Carlos Mendoza | carlos2026 | Supervisor
-- Rosa Villanueva | rosa2026 | Manager
-- Juan dela Cruz | juan2026 | Staff
-- Maria Santos | maria2026 | Staff
-- Pedro Reyes | pedro2026 | Staff
-- Ana Gonzales | ana2026 | Staff
-- Jose Bautista | jose2026 | Staff
-- Liza Fernandez | liza2026  