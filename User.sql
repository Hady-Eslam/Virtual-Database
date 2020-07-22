/**___________________________________________INDEX_________________________________________________*/
/**___________________________________________INDEX_________________________________________________*/
/**___________________________________________INDEX_________________________________________________*/
/**___________________________________________INDEX_________________________________________________*/
/**___________________________________________INDEX_________________________________________________*/
/**___________________________________________INDEX_________________________________________________*/
/**___________________________________________INDEX_________________________________________________*/
/**___________________________________________INDEX_________________________________________________*/
/**___________________________________________INDEX_________________________________________________*/
/**___________________________________________INDEX_________________________________________________*/


/**
									Some Best Practise About index
		1. Max Length = 64
*/





/*
	index no : 2
	Length : 33
	Columns : [Email, Hash_Code, Status]
	Trigger index Search on Columns : (Email), (Email, Hash_Code), (Email, Hash_Code, Status)
*/
/*DROP INDEX IF EXISTS `User__Email-Hash_Code-Status__idx`;
CREATE INDEX `User__Email-Hash_Code-Status__idx` ON User(Email, Hash_Code, Status);
*/






























/**___________________________________________FUNCTIONS_________________________________________________*/
/**___________________________________________FUNCTIONS_________________________________________________*/
/**___________________________________________FUNCTIONS_________________________________________________*/
/**___________________________________________FUNCTIONS_________________________________________________*/
/**___________________________________________FUNCTIONS_________________________________________________*/
/**___________________________________________FUNCTIONS_________________________________________________*/
/**___________________________________________FUNCTIONS_________________________________________________*/
/**___________________________________________FUNCTIONS_________________________________________________*/
/**___________________________________________FUNCTIONS_________________________________________________*/
/**___________________________________________FUNCTIONS_________________________________________________*/



/**
						Some Best Practise For Functions

		1. Max Length = 64
		2. Name Must Begin With Verb
*/





DROP FUNCTION IF EXISTS `Is_User_Email_Exists`;
DELIMITER //
CREATE FUNCTION `Is_User_Email_Exists`(
	Email VARCHAR(100)
)
RETURNS INT
BEGIN
	
	RETURN (SELECT EXISTS( SELECT 1 FROM User WHERE User.Email = Email LIMIT 1 ));

END //
DELIMITER ;


/**___________________________________________USER_________________________________________________*/



DROP FUNCTION IF EXISTS `Is_Pending_User_Exists`;
DELIMITER //
CREATE FUNCTION `Is_Pending_User_Exists`(
	Email VARCHAR(100),
	Hash_Code VARCHAR(100)
)
RETURNS INT
BEGIN
	
	RETURN (SELECT EXISTS(
		SELECT 1 FROM User 
			WHERE 
				User.Email = Email AND 
				User.Hash_Code = Hash_Code AND
				User.Status = 'Pending'
			LIMIT 1
	));

END //
DELIMITER ;



/**___________________________________________USER_________________________________________________*/




DROP FUNCTION IF EXISTS `Is_User_Exists`;
DELIMITER //
CREATE FUNCTION `Is_User_Exists`(
	Email VARCHAR(100),
	Hash_Code VARCHAR(100)
)
RETURNS INT
BEGIN
	
	RETURN(SELECT EXISTS(SELECT 1 FROM User WHERE User.Email = Email AND User.Hash_Code = Hash_Code LIMIT 1 ));

END //
DELIMITER ;




/**___________________________________________USER_________________________________________________*/




DROP FUNCTION IF EXISTS `Is_User_Password_Code`;
DELIMITER //
CREATE FUNCTION `Is_User_Password_Code`(
	Email VARCHAR(100),
	Password_Code VARCHAR(100)
)
RETURNS INT
BEGIN
	
	RETURN(SELECT EXISTS(SELECT 1 FROM User WHERE User.Email = Email AND User.Password_Code = Password_Code LIMIT 1 ));

END //
DELIMITER ;




/**___________________________________________USER_________________________________________________*/



DROP FUNCTION IF EXISTS `Is_User_Teacher`;
DELIMITER //
CREATE FUNCTION `Is_User_Teacher`(
	User_id INT
)
RETURNS INT
BEGIN
	
	RETURN(SELECT EXISTS(SELECT 1 FROM User WHERE User.id = User_id AND User.I_AM = 'Teacher' LIMIT 1));

END //
DELIMITER ;
























/**___________________________________________PROCEDURE_________________________________________________*/
/**___________________________________________PROCEDURE_________________________________________________*/
/**___________________________________________PROCEDURE_________________________________________________*/
/**___________________________________________PROCEDURE_________________________________________________*/
/**___________________________________________PROCEDURE_________________________________________________*/
/**___________________________________________PROCEDURE_________________________________________________*/
/**___________________________________________PROCEDURE_________________________________________________*/
/**___________________________________________PROCEDURE_________________________________________________*/
/**___________________________________________PROCEDURE_________________________________________________*/
/**___________________________________________PROCEDURE_________________________________________________*/




/**
						Some Best Practise For Procedure

		1. Max Length = 64
		2. Name Must Begin With Noun
*/





/**
	Restriction : 
		1. Every ip can have at max 20 Check every hour

DROP PROCEDURE IF EXISTS `Is_User_Email_Registered`;
DELIMITER //
CREATE PROCEDURE `Is_User_Email_Registered`(
	IN Email VARCHAR(100)
)
BEGIN
	
	SELECT Is_User_Email_Exists(Email);

END //
DELIMITER ;
*/



/**___________________________________________USER_________________________________________________*/





/**
	Restriction : 
		1. Every ip can have 3 register in one hour
*/
DROP PROCEDURE IF EXISTS `SignUP`;
DELIMITER //
CREATE PROCEDURE `SignUP`(
	IN Image VARCHAR(100),
	IN First_Name VARCHAR(100),
	IN Last_Name VARCHAR(100),
	IN I_AM VARCHAR(7),
	IN Email VARCHAR(100),
	IN Password VARCHAR(100),
	IN Hash_Code VARCHAR(100),
	IN Password_Code VARCHAR(8)
)
BEGIN

	IF Is_User_Email_Exists(Email) = 0 THEN

		INSERT INTO User(Image, First_Name, Last_Name, I_AM, Email, Password, Hash_Code, Password_Code)
			VALUES(Image, First_Name, Last_Name, I_AM, Email, Password, Hash_Code, Password_Code);

		SELECT 'Created';

	ELSE
		SELECT 'User Found';
	
	END IF;

END //
DELIMITER ;



/**___________________________________________USER_________________________________________________*/




/**
	Restriction : 
		1. Every ip have 3 Activations in half hour
*/
DROP PROCEDURE IF EXISTS `Activate_User`;
DELIMITER //
CREATE PROCEDURE `Activate_User`(
	IN Email VARCHAR(100),
	IN Hash_Code VARCHAR(100),
	IN New_Hash_Code VARCHAR(100)
)
BEGIN

	IF Is_Pending_User_Exists(Email, Hash_Code) = 0 THEN
		SELECT 'User Not Found';

	ELSE
		UPDATE User
			SET
				User.Hash_Code = New_Hash_Code,
				User.Status = 'Approved',
				User.is_active = 1
			WHERE
				User.Email = Email
			LIMIT 1;

		SELECT 'Activated';

	END IF;

END //
DELIMITER ;





/**___________________________________________USER_________________________________________________*/




/**
	Restriction :
		1. Every User Must 
*/
DROP PROCEDURE IF EXISTS `Forget_Password`;
DELIMITER //
CREATE PROCEDURE `Forget_Password`(
	IN Email VARCHAR(100)
)
BEGIN
	
	SELECT User.Password_Code, User.Status INTO @Password_Code, @Status FROM User WHERE User.Email = Email LIMIT 1;

	IF @Password_Code IS NULL THEN
		SELECT 'User Not Found';

	ELSEIF @Status = 'Pending' THEN
		SELECT 'Pending User';

	ELSE
		SELECT 'User Password Code', @Password_Code;

	END IF;

END //
DELIMITER ;



/**___________________________________________USER_________________________________________________*/



/*
DROP PROCEDURE IF EXISTS `Reset_Password_Token`;
DELIMITER //
CREATE PROCEDURE `Reset_Password_Token`(
	IN Email VARCHAR(100),
	IN Hash_Code VARCHAR(100)
)
BEGIN
	
	SELECT Is_User_Exists(Email, Hash_Code);

END //
DELIMITER ;



/**___________________________________________USER_________________________________________________*/



DROP PROCEDURE IF EXISTS `Reset_Password`;
DELIMITER //
CREATE PROCEDURE `Reset_Password`(
	IN Email VARCHAR(100),
	IN Old_Password_Code VARCHAR(100),
	IN New_Password_Code VARCHAR(100),
	IN New_Password VARCHAR(100)
)
BEGIN

	IF Is_User_Password_Code(Email, Old_Password_Code) = 0 THEN
		SELECT 'User Not Found';
	
	ELSE
		UPDATE User 
			SET
				User.Password = New_Password,
				User.Password_Code = New_Password_Code
			WHERE 
				User.Email = Email AND
				User.Status = 'Approved'
			LIMIT 1;

		SELECT 'Password Changed';
	
	END IF;
	
END //
DELIMITER ;




/**___________________________________________USER_________________________________________________*/



DROP PROCEDURE IF EXISTS `Change_User_Settings`;
DELIMITER //
CREATE PROCEDURE `Change_User_Settings`(
	IN Email VARCHAR(100),
	IN Image VARCHAR(100),
	In First_Name VARCHAR(100),
	In Last_Name VARCHAR(100)
)
BEGIN
	
	UPDATE User 
		SET 
			User.Image = Image,
			User.First_Name = First_Name,
			User.Last_Name = Last_Name
		WHERE 
			User.Email = Email AND
			User.Status = 'Approved'
		LIMIT 1;

END //
DELIMITER ;




/**___________________________________________USER_________________________________________________*/





DROP PROCEDURE IF EXISTS `Change_User_Password`;
DELIMITER //
CREATE PROCEDURE `Change_User_Password`(
	IN Email VARCHAR(100),
	IN Old_Password VARCHAR(100),
	IN New_Password VARCHAR(100)
)
BEGIN
	
	UPDATE User
		SET 
			User.Password = New_Password 
		WHERE
			User.Email = Email AND
			User.Password = Old_Password AND
			User.Status = 'Approved'
		LIMIT 1;

END //
DELIMITER ;




/**___________________________________________USER_________________________________________________*/



DROP EVENT IF EXISTS `Delete_Pending_Users`;
CREATE EVENT `Delete_Pending_Users`
ON SCHEDULE EVERY 3 DAY
DO
	DELETE FROM User WHERE User.Status = 'Pending' AND ADDDATE(User.Created_At, INTERVAL 7 DAY) < NOW();


/**___________________________________________USER_________________________________________________*/




DROP PROCEDURE IF EXISTS `Delete_User`;
DELIMITER //
CREATE PROCEDURE `Delete_User`(
	IN Email VARCHAR(100)
)
BEGIN

	DELETE FROM User WHERE User.Email = Email LIMIT 1;

END //
DELIMITER ;



/**___________________________________________USER_________________________________________________*/
