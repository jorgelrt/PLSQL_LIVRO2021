CREATE OR REPLACE PROCEDURE autonoma AS
	PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
	INSERT INTO temp_table
	VALUES(10,'Hello from Autonoumous!');
	COMMIT;
END autonoma;
/
