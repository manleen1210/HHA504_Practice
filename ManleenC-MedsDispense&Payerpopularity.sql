ManleenC-MedsDispense&Payerpopularity

""" TRIGGER CODE """
delimiter $$

CREATE TRIGGER MedicationDispense BEFORE INSERT ON synthea.medications
FOR EACH ROW
BEGIN
IF NEW.DISPENSES = 0 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'ERROR: Medication dispense must be greater than 0';
END IF;
END; $$

delimiter ;

""" CHECKING TRIGGER """
INSERT INTO medications (dispenses) 
    VALUES (0);

""" FUNCTION CODE """

DELIMITER $$
CREATE FUNCTION UniquePatients(Patientcount DECIMAL(10,2))
RETURNS VARCHAR(20)
BEGIN
DECLARE UniPatient VARCHAR(20);
IF Patientcount >= 200 THEN
SET UniPatient = 'PopularPayer';
ELSEIF Patientcount < 200 THEN
SET UniPatient = 'UnpopularPayer';
END IF;
-- return the drug cost category
RETURN (UniPatient);
END
$$
DELIMITER;

"""CHECKING FUNCTION"""
SELECT NAME, UNIQUE_CUSTOMERS, UniquePatients(UNIQUE_CUSTOMERS) FROM payers;
