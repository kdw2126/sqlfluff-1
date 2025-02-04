CREATE TRIGGER foo AFTER INSERT ON bar EXECUTE FUNCTION proc(args);

CREATE TRIGGER foo BEFORE INSERT on bar EXECUTE FUNCTION proc(args);

CREATE TRIGGER foo AFTER UPDATE OF bar, baz ON bar EXECUTE FUNCTION proc(args);

CREATE TRIGGER foo INSTEAD OF DELETE ON bar FROM baz DEFERRABLE INITIALLY DEFERRED FOR EACH STATEMENT EXECUTE FUNCTION proc(args);

CREATE TRIGGER foo BEFORE INSERT ON bar WHEN (a=b) EXECUTE FUNCTION proc(args);

CREATE OR REPLACE CONSTRAINT TRIGGER foo BEFORE INSERT ON bar EXECUTE FUNCTION proc(args);

CREATE TRIGGER foo BEFORE INSERT ON bar REFERENCING OLD TABLE as old_table NEW TABLE AS new_table EXECUTE PROCEDURE proc(args);

CREATE TRIGGER check_update
    BEFORE INSERT OR UPDATE ON accounts
    FOR EACH ROW
    EXECUTE FUNCTION check_account_update();

CREATE OR REPLACE TRIGGER check_update
    BEFORE UPDATE OF balance, transactions ON accounts
    FOR EACH ROW
    EXECUTE FUNCTION check_account_update();

CREATE OR REPLACE TRIGGER check_update
    BEFORE UPDATE OF balance, transactions OR TRUNCATE ON accounts
    FOR EACH ROW
    EXECUTE FUNCTION check_account_update();

CREATE OR REPLACE TRIGGER check_update
    BEFORE UPDATE OF balance ON accounts
    FOR EACH ROW
    EXECUTE FUNCTION check_account_update();

CREATE TRIGGER check_update
    BEFORE UPDATE ON accounts
    FOR EACH ROW
    WHEN (OLD.balance IS DISTINCT FROM NEW.balance)
    EXECUTE FUNCTION check_account_update();

--CREATE TRIGGER log_update
--    AFTER UPDATE ON accounts
--    FOR EACH ROW
--    WHEN (OLD.* IS DISTINCT FROM NEW.*)
--    EXECUTE FUNCTION log_account_update();

CREATE TRIGGER view_insert
    INSTEAD OF INSERT ON my_view
    FOR EACH ROW
    EXECUTE FUNCTION view_insert_row();

CREATE TRIGGER transfer_insert
    AFTER INSERT ON transfer
    REFERENCING NEW TABLE AS inserted
    FOR EACH STATEMENT
    EXECUTE FUNCTION check_transfer_balances_to_zero();

CREATE TRIGGER paired_items_update
    AFTER UPDATE ON paired_items
    REFERENCING NEW TABLE AS newtab OLD TABLE AS oldtab
    FOR EACH ROW
    EXECUTE FUNCTION check_matching_pairs();

CREATE TRIGGER log_update
    AFTER UPDATE ON accounts
    FOR EACH ROW
    WHEN (OLD.* IS DISTINCT FROM NEW.*)
    EXECUTE FUNCTION log_account_update();
