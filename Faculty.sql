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
	Length : 22
	Columns : [JoinCode]
	Trigger index Search on Columns : (JoinCode)
*/
/*DROP INDEX IF EXISTS `Faculty__JoinCode__idx`;*/
--CREATE INDEX `Faculty__JoinCode__idx` ON Faculty(JoinCode);

/*
	index no : 3
	Length : 27
	Columns : [id, Creator_id]
	Trigger index Search on Columns : (id), (id, Creator_id)
*/
/*DROP INDEX IF EXISTS `Faculty__id-Creator_id__idx`;*/
--CREATE INDEX `Faculty__id-Creator_id__idx` ON Faculty(id, Creator_id);





/**__________________________________________FACULTY_______________________________________________*/




/**
	Table : Faculty_Members
	index no : 2
	Length : 49
	Columns : [User_id, Faculty_id, Position]
	Trigger index Search on Columns : (User_id), (User_id, Faculty_id), (User_id, Faculty_id, Position)
*/
/*DROP INDEX IF EXISTS `Faculty_Members__User_id-Faculty_id-Position__idx`;*/
--CREATE INDEX `Faculty_Members__User_id-Faculty_id-Position__idx` ON Faculty_Members(User_id, Faculty_id, Position);





/**__________________________________________FACULTY_______________________________________________*/




/**
	Table : Faculty_Posts
	index no : 2
	Length : 44
	Columns : [id, Faculty_id, Creator_id]
	Trigger index Search on Columns : (id), (id, Faculty_id), (id, Faculty_id, Creator_id)
*/
/*DROP INDEX IF EXISTS `Faculty_Posts__id-Faculty_id-Creator_id__idx`;*/
--CREATE INDEX `Faculty_Posts__id-Faculty_id-Creator_id__idx` ON Faculty_Posts(id, Faculty_id, Creator_id);

/**
	Table : Faculty_Posts
	index no : 3
	Length : 41
	Columns : [Faculty_id, Creator_id]
	Trigger index Search on Columns : (Faculty_id), (Faculty_id, Creator_id)
*/
/*DROP INDEX IF EXISTS `Faculty_Posts__Faculty_id-Creator_id__idx`;*/
--CREATE INDEX `Faculty_Posts__Faculty_id-Creator_id__idx` ON Faculty_Posts(Faculty_id, Creator_id);





/**__________________________________________FACULTY_______________________________________________*/





/**
	Table : Faculty_Comments
	index no : 2
	Length : 36
	Columns : [id, Creator_id]
	Trigger index Search on Columns : (id), (id, Creator_id)
*/
/*DROP INDEX IF EXISTS `Faculty_Comments__id-Creator_id__idx`;*/
--CREATE INDEX `Faculty_Comments__id-Creator_id__idx` ON Faculty_Comments(id, Creator_id);


/**
	Table : Faculty_Comments
	index no : 3
	Length : 33
	Columns : [Post_id, id]
	Trigger index Search on Columns : (Post_id), (Post_id, id)
*/
/*DROP INDEX IF EXISTS `Faculty_Comments__Post_id-id__idx`;*/
--CREATE INDEX `Faculty_Comments__Post_id-id__idx` ON Faculty_Comments(Post_id, id);



























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



DROP FUNCTION IF EXISTS `Is_Faculty_JoinCode_Exists`;
DELIMITER //
CREATE FUNCTION `Is_Faculty_JoinCode_Exists`(
	JoinCode VARCHAR(6)
)
RETURNS INT
BEGIN
	
	RETURN (SELECT EXISTS( SELECT 1 FROM Faculty WHERE Faculty.JoinCode = JoinCode LIMIT 1 ));

END //
DELIMITER ;



/**__________________________________________FACULTY_______________________________________________*/




DROP FUNCTION IF EXISTS `Get_Faculty_id`;
DELIMITER //
CREATE FUNCTION `Get_Faculty_id`(
	JoinCode VARCHAR(6)
)
RETURNS INT
BEGIN
	
	RETURN (SELECT Faculty.id FROM Faculty WHERE Faculty.JoinCode = JoinCode LIMIT 1);

END //
DELIMITER ;




/**__________________________________________FACULTY_______________________________________________*/




DROP FUNCTION IF EXISTS `Is_Faculty_Member`;
DELIMITER //
CREATE FUNCTION `Is_Faculty_Member`(
	User_id INT,
	Faculty_id INT
)
RETURNS INT
BEGIN
	
	RETURN (SELECT EXISTS( 
		SELECT 1 FROM Faculty_Members 
			WHERE 
				Faculty_Members.User_id = User_id AND
				Faculty_Members.Faculty_id = Faculty_id
			LIMIT 1
	));

END //
DELIMITER ;



/**__________________________________________FACULTY_______________________________________________*/



DROP FUNCTION IF EXISTS `Is_Faculty_Post`;
DELIMITER //
CREATE FUNCTION `Is_Faculty_Post`(
	Post_id INT
)
RETURNS INT
BEGIN
	
	RETURN (SELECT EXISTS( SELECT 1 FROM Faculty_Posts WHERE Faculty_Posts.id = Post_id LIMIT 1 ));

END //
DELIMITER ;



/**__________________________________________FACULTY_______________________________________________*/




DROP FUNCTION IF EXISTS `Is_Faculty_Post_Creator`;
DELIMITER //
CREATE FUNCTION `Is_Faculty_Post_Creator`(
	User_id INT,
	Post_id INT,
	Faculty_id INT
)
RETURNS INT
BEGIN
	
	RETURN (SELECT EXISTS(
		SELECT 1 FROM Faculty_Posts
			WHERE
				Faculty_Posts.id = Post_id AND
				Faculty_Posts.Faculty_id = Faculty_id AND
				Faculty_Posts.Creator_id = User_id
			LIMIT 1 
	));

END //
DELIMITER ;



/**__________________________________________FACULTY_______________________________________________*/




DROP FUNCTION IF EXISTS `Is_Faculty_Comment_Creator`;
DELIMITER //
CREATE FUNCTION `Is_Faculty_Comment_Creator`(
	User_id INT,
	Comment_id INT
)
RETURNS INT
BEGIN
	
	RETURN (SELECT EXISTS(
		SELECT 1 FROM Faculty_Comments
			WHERE
				Faculty_Comments.id = Comment_id AND
				Faculty_Comments.Creator_id = User_id
			LIMIT 1 
	));

END //
DELIMITER ;



/**__________________________________________FACULTY_______________________________________________*/



DROP FUNCTION IF EXISTS `Is_Post_in_Faculty`;
DELIMITER //
CREATE FUNCTION `Is_Post_in_Faculty`(
	Post_id INT,
	Faculty_id INT
)
RETURNS INT
BEGIN

	RETURN (SELECT EXISTS(
		SELECT 1 FROM Faculty_Posts WHERE Faculty_Posts.id = Post_id AND Faculty_Posts.Faculty_id = Faculty_id LIMIT 1
	));

END //
DELIMITER ;



/**__________________________________________FACULTY_______________________________________________*/



DROP FUNCTION IF EXISTS `Is_Comment_In_Faculty_Post`;
DELIMITER //
CREATE FUNCTION `Is_Comment_In_Faculty_Post`(
	Comment_id INT,
	Post_id INT
)
RETURNS INT
BEGIN

	RETURN (SELECT EXISTS(
		SELECT 1 FROM Faculty_Comments
			WHERE
				Faculty_Comments.id = Comment_id AND
				Faculty_Comments.Post_id = Post_id
			LIMIT 1
	));

END //
DELIMITER ;



/**__________________________________________FACULTY_______________________________________________*/




DROP FUNCTION IF EXISTS `Is_Faculty_Admin`;
DELIMITER //
CREATE FUNCTION `Is_Faculty_Admin`(
	Admin_id INT,
	Faculty_id INT
)
RETURNS INT
BEGIN
	
	RETURN (SELECT EXISTS( 
		SELECT 1 FROM Faculty_Members 
			WHERE 
				Faculty_Members.User_id = Admin_id AND
				Faculty_Members.Faculty_id = Faculty_id AND
				Faculty_Members.Position = 'Admin'
			LIMIT 1
	));

END //
DELIMITER ;




/**__________________________________________FACULTY_______________________________________________*/




DROP FUNCTION IF EXISTS `Is_Faculty_Creator`;
DELIMITER //
CREATE FUNCTION `Is_Faculty_Creator`(
	Creator_id INT,
	Faculty_id INT
)
RETURNS INT
BEGIN
	
	RETURN (SELECT EXISTS(
		SELECT 1 FROM Faculty
			WHERE
				Faculty.id = Faculty_id AND
				Faculty.Creator_id = Creator_id
			LIMIT 1
	));

END //
DELIMITER ;





/**__________________________________________FACULTY_______________________________________________*/




DROP FUNCTION IF EXISTS `Is_Faculty_Staff_Or_Teacher`;
DELIMITER //
CREATE FUNCTION `Is_Faculty_Staff_Or_Teacher`(
	User_id INT,
	Faculty_id INT
)
RETURNS INT
BEGIN
	
	RETURN (SELECT EXISTS(
		SELECT 1 FROM User WHERE User.I_AM != 'Student' AND User.Status = 'Approved' AND User.id = User_id LIMIT 1
	));

END //
DELIMITER ;




/**__________________________________________FACULTY_______________________________________________*/




DROP FUNCTION IF EXISTS `Is_Faculty_Announcement`;
DELIMITER //
CREATE FUNCTION `Is_Faculty_Announcement`(
	Announcement_id INT,
	Faculty_id INT
)
RETURNS INT
BEGIN
	
	RETURN (SELECT EXISTS(
		SELECT 1 FROM Faculty_Announcements
			WHERE
				Faculty_Announcements.id = Announcement_id AND
				Faculty_Announcements.Faculty_id = Faculty_id
			LIMIT 1
	));

END //
DELIMITER ;




/**__________________________________________FACULTY_______________________________________________*/




DROP FUNCTION IF EXISTS `Is_Faculty_Announcement_Creator`;
DELIMITER //
CREATE FUNCTION `Is_Faculty_Announcement_Creator`(
	User_id INT,
	Announcement_id INT
)
RETURNS INT
BEGIN
	
	RETURN (SELECT EXISTS(
		SELECT 1 FROM Faculty_Announcements
			WHERE
				Faculty_Announcements.id = Announcement_id AND
				Faculty_Announcements.Creator_id = User_id
			LIMIT 1
	));

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



/*
DROP PROCEDURE IF EXISTS `Is_Faculty_JoinCode_Registered`;
DELIMITER //
CREATE PROCEDURE `Is_Faculty_JoinCode_Registered`(
	IN JoinCode VARCHAR(6)
)
BEGIN
	
	SELECT Is_Faculty_JoinCode_Exists(JoinCode);

END //
DELIMITER ;




/**__________________________________________FACULTY_______________________________________________*/




/**
	Restrictions:
		1. User Can Create only one Faculty
*/
DROP PROCEDURE IF EXISTS `Create_Faculty`;
DELIMITER //
CREATE PROCEDURE `Create_Faculty`(
	IN Creator_id INT,
	IN Name VARCHAR(100),
	IN JoinCode VARCHAR(6),
	IN Descreption VARCHAR(1000),
	IN Image VARCHAR(100)
)
BEGIN
	
	IF Is_Faculty_JoinCode_Exists(JoinCode) = 1 THEN
		SELECT 'Join Code Found';

	ELSE
		START TRANSACTION;

			INSERT INTO Faculty(Name, JoinCode, Creator_id, Descreption, Image)
				VALUES (Name, JoinCode, Creator_id, Descreption, Image);
			
			SET @Faculty_id = Get_Faculty_id(JoinCode);

			INSERT INTO Faculty_Members(User_id, Faculty_id, Position)
				VALUES (Creator_id, @Faculty_id, 'Admin');

			SELECT 'Created', @Faculty_id;
		
		COMMIT;

	END IF;

END //
DELIMITER ;



/**__________________________________________FACULTY_______________________________________________*/




DROP PROCEDURE IF EXISTS `Join_Faculty`;
DELIMITER //
CREATE PROCEDURE `Join_Faculty`(
	IN User_id INT,
	IN User_JoinCode VARCHAR(6)
)
BEGIN

	SET @Faculty_id = Get_Faculty_id(User_JoinCode);

	IF @Faculty_id IS NULL THEN
		SELECT 'Faculty Not Found';

	ELSE
		IF Is_Faculty_Member(User_id, @Faculty_id) = 1 THEN
			SELECT 'Already Member';

		ELSE
			INSERT INTO Faculty_Members(User_id, Faculty_id, Position)
				VALUES (User_id, @Faculty_id, 'Member');

			SELECT 'Joined', @Faculty_id;

		END IF;
	
	END IF;

END //
DELIMITER ;




/**__________________________________________FACULTY_______________________________________________*/




DROP PROCEDURE IF EXISTS `Make_Faculty_Post`;
DELIMITER //
CREATE PROCEDURE `Make_Faculty_Post`(
	IN User_id INT,
	IN Faculty_id INT,
	IN Post TEXT,
	IN Files TEXT
)
BEGIN
	
	IF Is_Faculty_Member(User_id, Faculty_id) = 0 THEN
		SELECT 'Not Member';

	ELSE
		INSERT INTO Faculty_Posts(Faculty_id, Creator_id, Post, Files) VALUES (Faculty_id, User_id, Post, Files);
		SELECT
			'Created',
			Faculty_Posts.id,
			Faculty_Posts.Faculty_id,
			Faculty_Posts.Creator_id,
			Faculty_Posts.Post,
			Faculty_Posts.Files,
			Faculty_Posts.Created_At
			FROM
				Faculty_Posts
			WHERE
				Faculty_Posts.id = LAST_INSERT_ID()
			LIMIT 1;
		
	END IF;

END //
DELIMITER ;



/**__________________________________________FACULTY_______________________________________________*/




DROP PROCEDURE IF EXISTS `Edit_Faculty_Post`;
DELIMITER //
CREATE PROCEDURE `Edit_Faculty_Post`(
	IN User_id INT,
	IN Faculty_id INT,
	IN Post_id INT,
	IN Post TEXT
)
BEGIN
	
	IF Is_Faculty_Member(User_id, Faculty_id) = 0 THEN
		SELECT 'Not Member';

	ELSE
		IF IS_Faculty_Post_Creator(User_id, Post_id, Faculty_id) = 0 THEN
			SELECT 'Not Post Creator';
		
		ELSE
			UPDATE Faculty_Posts SET Faculty_Posts.Post = Post WHERE Faculty_Posts.id = Post_id LIMIT 1;
			SELECT 'Edited';

		END IF;
	END IF;

END //
DELIMITER ;




/**__________________________________________FACULTY_______________________________________________*/



DROP PROCEDURE IF EXISTS `Delete_Faculty_Post`;
DELIMITER //
CREATE PROCEDURE `Delete_Faculty_Post`(
	IN User_id INT,
	IN Faculty_id INT,
	IN Post_id INT
)
BEGIN
	
	IF Is_Faculty_Member(User_id, Faculty_id) = 0 THEN
		SELECT 'Not Member';
	
	ELSE
		IF Is_Faculty_Post_Creator(User_id, Post_id, Faculty_id) = 0 THEN
			SELECT 'Not Post Creator';
		
		ELSE
			DELETE FROM Faculty_Posts WHERE Faculty_Posts.id = Post_id LIMIT 1;
			SELECT 'Deleted';
		
		END IF;

	END IF;

END //
DELIMITER ;



/**__________________________________________FACULTY_______________________________________________*/



DROP PROCEDURE IF EXISTS `Make_Faculty_Comment`;
DELIMITER //
CREATE PROCEDURE `Make_Faculty_Comment`(
	IN User_id INT,
	IN Post_id INT,
	IN Faculty_id INT,
	IN Comment VARCHAR(2000)
)
BEGIN
	
	IF Is_Faculty_Member(User_id, Faculty_id) = 0 THEN
		SELECT 'Not Member';
	
	ELSE
		IF Is_Post_in_Faculty(Post_id, Faculty_id) = 0 THEN
			SELECT 'Not Faculty Post';

		ELSE
			INSERT INTO Faculty_Comments(Creator_id, Post_id, Comment) VALUES(User_id, Post_id, Comment);
			SELECT
				'Created',
				Faculty_Comments.id,
				Faculty_Comments.Creator_id,
				Faculty_Comments.Post_id,
				Faculty_Comments.Comment,
				Faculty_Comments.Created_At
				FROM 
					Faculty_Comments
				WHERE
					Faculty_Comments.id = LAST_INSERT_ID()
				LIMIT 1;

		END IF;

	END IF;

END //
DELIMITER ;



/**__________________________________________FACULTY_______________________________________________*/



DROP PROCEDURE IF EXISTS `Edit_Faculty_Comment`;
DELIMITER //
CREATE PROCEDURE `Edit_Faculty_Comment`(
	IN User_id INT,
	IN Comment_id INT,
	IN Post_id INT,
	IN Faculty_id INT,
	IN New_Comment VARCHAR(2000)
)
BEGIN
	
	IF Is_Faculty_Member(User_id, Faculty_id) = 0 THEN
		SELECT 'Not Member';

	ELSE
		IF Is_Post_in_Faculty(Post_id, Faculty_id) = 0 THEN
			SELECT 'Not Faculty Post';
		
		ELSE
			IF Is_Comment_In_Faculty_Post(Comment_id, Post_id) = 0 THEN
				SELECT 'Not Faculty Comment';
			
			ELSE
				IF Is_Faculty_Comment_Creator(User_id, Comment_id) = 0 THEN
					SELECT 'Not Comment Creator';
				
				ELSE
					UPDATE Faculty_Comments
						SET
							Faculty_Comments.Comment = New_Comment
						WHERE
							Faculty_Comments.id = Comment_id
						LIMIT 1;

					SELECT 'Edited';
				END IF;
			END IF;
		END IF;
	END IF;

END //
DELIMITER ;



/**__________________________________________FACULTY_______________________________________________*/



DROP PROCEDURE IF EXISTS `Delete_Faculty_Comment`;
DELIMITER //
CREATE PROCEDURE `Delete_Faculty_Comment`(
	IN User_id INT,
	IN Comment_id INT,
	IN Post_id INT,
	IN Faculty_id INT
)
BEGIN
	
	IF Is_Faculty_Member(User_id, Faculty_id) = 0 THEN
		SELECT 'Not Member';

	ELSE
		IF Is_Post_in_Faculty(Post_id, Faculty_id) = 0 THEN
			SELECT 'Not Faculty Post';
		
		ELSE
			IF Is_Comment_In_Faculty_Post(Comment_id, Post_id) = 0 THEN
				SELECT 'Not Faculty Comment';
			
			ELSE
				IF Is_Faculty_Comment_Creator(User_id, Comment_id) = 0 THEN
					SELECT 'Not Comment Creator';
				
				ELSE
					DELETE FROM Faculty_Comments WHERE Faculty_Comments.id = Comment_id LIMIT 1;
					SELECT 'Deleted';

				END IF;
			END IF;
		END IF;
	END IF;

END //
DELIMITER ;



/**__________________________________________FACULTY_______________________________________________*/




DROP PROCEDURE IF EXISTS `Get_Faculty_Post_Comments`;
DELIMITER //
CREATE PROCEDURE `Get_Faculty_Post_Comments`(
	IN User_id INT,
	IN Post_id INT,
	IN Faculty_id INT,
	IN Offset INT
)
BEGIN
	
	IF Is_Faculty_Member(User_id, Faculty_id) = 0 THEN
		SELECT 'Not Member';

	ELSE
		IF Is_Post_in_Faculty(Post_id, Faculty_id) = 0 THEN
			SELECT 'Not Faculty Post';
		
		ELSE
			SELECT
				'Comments',
				Faculty_Comments.id,
				Faculty_Comments.Creator_id,
				Faculty_Comments.Post_id,
				Faculty_Comments.Comment,
				Faculty_Comments.Created_At,
				User.id,
				User.First_Name,
				User.Last_Name,
				User.Image 
				FROM 
					Faculty_Comments, User
				WHERE
					Faculty_Comments.Post_id = Post_id AND
					User.id = Faculty_Comments.Creator_id
				ORDER BY
					Faculty_Comments.id DESC
				LIMIT 10
				OFFSET Offset;
		END IF;

	END IF;

END //
DELIMITER ;



/**__________________________________________FACULTY_______________________________________________*/



DROP PROCEDURE IF EXISTS `Show_Faculty`;
DELIMITER //
CREATE PROCEDURE `Show_Faculty`(
	IN User_id INT,
	IN Faculty_id INT,
	IN Offset INT
)
BEGIN
	
	IF Is_Faculty_Member(User_id, Faculty_id) = 0 THEN
		SELECT 'Not Member';

	ELSE
		SELECT
			'Posts',
			Faculty_Posts.id,
			Faculty_Posts.Faculty_id,
			Faculty_Posts.Creator_id,
			Faculty_Posts.Post,
			Faculty_Posts.Files,
			Faculty_Posts.Created_At,
			User.id,
			User.Image,
			User.First_Name,
			User.Last_Name
			FROM
				Faculty_Posts, User
			WHERE
				Faculty_Posts.Faculty_id = Faculty_id AND
				Faculty_Posts.Creator_id = User.id
			ORDER BY
				Faculty_Posts.id DESC
			LIMIT
				Offset, 5;

	END IF;

END //
DELIMITER ;



/**__________________________________________FACULTY_______________________________________________*/



DROP PROCEDURE IF EXISTS `Show_Faclty_Settings`;
DELIMITER //
CREATE PROCEDURE `Show_Faclty_Settings`(
	IN Admin_id INT,
	IN Faculty_id INT
)
BEGIN
	
	IF Is_Faculty_Admin(Admin_id, Faculty_id) = 0 THEN
		SELECT 'Not Admin';
		
	ELSE
		SELECT 
			'Settings',
			Faculty.id,
			Faculty.Name,
			Faculty.JoinCode,
			Faculty.Descreption,
			Faculty.Image,
			Faculty.Created_At,
			User.id,
			User.First_Name,
			User.Last_Name,
			User.Image
			FROM 
				Faculty, User 
			WHERE
				Faculty.id = Faculty_id AND
				Faculty.Creator_id = User.id 
			LIMIT 1;
	END IF;

END //
DELIMITER ;



/**__________________________________________FACULTY_______________________________________________*/



DROP PROCEDURE IF EXISTS `Edit_Faculty_Settings`;
DELIMITER //
CREATE PROCEDURE `Edit_Faculty_Settings`(
	IN Admin_id INT,
	IN Faculty_id INT,
	IN Name VARCHAR(100),
	IN Descreption VARCHAR(1000)
)
BEGIN

	IF Is_Faculty_Admin(Admin_id, Faculty_id) = 0 THEN
		SELECT 'Not Admin';

	ELSE
		UPDATE Faculty 
			SET
				Faculty.Name = Name,
				Faculty.Descreption = Descreption
			WHERE 
				Faculty.id = Faculty_id
			LIMIT 1;

		SELECT 'Edited';

	END IF;

END //
DELIMITER ;



/**__________________________________________FACULTY_______________________________________________*/


/*
DROP PROCEDURE IF EXISTS `Delete_Faculty`;
DELIMITER //
CREATE PROCEDURE `Delete_Faculty`(
	IN Admin_id INT,
	IN Faculty_id INT
)
BEGIN

	IF Is_Faculty_Creator(Admin_id, Faculty_id) = 0 THEN
		SELECT 'Do Not Have Permision' AS `Result`;

	ELSE
		START TRANSACTION;
			
			/** 	Faculty 	
			DELETE FROM Faculty_Comments WHERE Faculty_Comments.Post_id IN (
				SELECT Faculty_Posts.id FROM Faculty_Posts WHERE Faculty_Posts.Faculty_id = Faculty_id
			);
			DELETE FROM Faculty_Posts WHERE Faculty_Posts.Faculty_id = Faculty_id;
			DELETE FROM Faculty_Members WHERE Faculty_Members.Faculty_id = Faculty_id;




			/** Academic Years 
			DELETE FROM Academic_Year_Comments WHERE Academic_Year_Comments.Post_id IN (
				SELECT Academic_Year_Posts.id FROM Academic_Year_Posts
					WHERE Academic_Year_Posts.Academic_Year_id IN (
						SELECT Academic_Year.id FROM Academic_Year WHERE Academic_Year.Faculty_id = Faculty_id
				)
			);
			DELETE FROM Academic_Year_Posts WHERE Academic_Year_Posts.Academic_Year_id IN (
				SELECT Academic_Year.id FROM Academic_Year WHERE Academic_Year.Faculty_id = Faculty_id
			);
			DELETE FROM Academic_Year_Members WHERE Academic_Year_Members.Academic_Year_id IN (
				SELECT Academic_Year.id FROM Academic_Year WHERE Academic_Year.Faculty_id = Faculty_id
			);




			/** Class 
			DELETE FROM Class_Comments WHERE Class_Comments.Post_id IN (
				SELECT Class_Posts.id FROM Class_Posts WHERE Class_Posts.Class_id IN (
					SELECT Class.id FROM Class WHERE Class.Academic_Year_id IN (
						SELECT Academic_Year.id FROM Academic_Year WHERE Academic_Year.Faculty_id = Faculty_id
					)
				)
			);
			DELETE FROM Class_Posts WHERE Class_Posts.Class_id IN(
				SELECT Class.id FROM Class WHERE Class.Academic_Year_id IN (
					SELECT Academic_Year.id FROM Academic_Year WHERE Academic_Year.Faculty_id = Faculty_id
				)
			);
			DELETE FROM Class_Members WHERE Class_Members.Class_id IN (
				SELECT Class.id FROM Class WHERE Class.Academic_Year_id IN (
					SELECT Academic_Year.id FROM Academic_Year WHERE Academic_Year.Faculty_id = Faculty_id
				)
			);
			DELETE FROM Class WHERE Class.Academic_Year_id IN (
				SELECT Academic_Year.id FROM Academic_Year WHERE Academic_Year.Faculty_id = Faculty_id
			);





			DELETE FROM Faculty WHERE Faculty.id = Faculty_id LIMIT 1;
			SELECT 'Done' AS `Result`;
		
		COMMIT;
	END IF;

END //
DELIMITER ;



/**__________________________________________FACULTY_______________________________________________*/



DROP PROCEDURE IF EXISTS `Show_Faculty_Members`;
DELIMITER //
CREATE PROCEDURE `Show_Faculty_Members`(
	IN User_id INT,
	IN Faculty_id INT,
	IN Offset INT
)
BEGIN

	IF Is_Faculty_Member(User_id, Faculty_id) = 0 THEN
		SELECT 'Not Member';

	ELSE
		SELECT
			'Member',
			Faculty_Members.id,
			Faculty_Members.Faculty_id,
			Faculty_Members.User_id,
			Faculty_Members.Position,
			Faculty_Members.Joined_At,
			User.Image,
			User.First_Name,
			User.Last_Name
			FROM 
				Faculty_Members, User 
			WHERE
				Faculty_Members.User_id = User.id AND
				Faculty_Members.Faculty_id = Faculty_id
			LIMIT
				Offset, 15;
	END IF;

END //
DELIMITER ;



/**__________________________________________FACULTY_______________________________________________*/



DROP PROCEDURE IF EXISTS `Kick_Faculty_Member`;
DELIMITER //
CREATE PROCEDURE `Kick_Faculty_Member`(
	IN Admin_id INT,
	IN Faculty_id INT,
	IN User_id INT
)
BEGIN

	IF Is_Faculty_Admin(Admin_id, Faculty_id) = 0 THEN
		SELECT 'Do Not Have Permision';

	ELSE
		IF Is_Faculty_Creator(User_id, Faculty_id) = 1 THEN
			SELECT 'Can Not Kick Out Creator';
		
		ELSE
			DELETE FROM Faculty_Members
				WHERE
					Faculty_Members.User_id = User_id AND
					Faculty_Members.Faculty_id = Faculty_id
				LIMIT 1;
			SELECT 'Kicked';
		
		END IF;
	END IF;

END //
DELIMITER ;



/**__________________________________________FACULTY_______________________________________________*/



DROP PROCEDURE IF EXISTS `Leave_Faculty`;
DELIMITER //
CREATE PROCEDURE `Leave_Faculty`(
	IN User_id INT,
	IN Faculty_id INT
)
BEGIN
	
	IF Is_Faculty_Creator(User_id, Faculty_id) = 1 THEN
		SELECT 'Creator Can Not Leave';
	
	ELSE
		DELETE FROM Faculty_Members
			WHERE
				Faculty_Members.User_id = User_id AND
				Faculty_Members.Faculty_id = Faculty_id
			LIMIT 1;
		SELECT 'Leaved';
	END IF;

END //
DELIMITER ;



/**__________________________________________FACULTY_______________________________________________*/



DROP PROCEDURE IF EXISTS `Make_Faculty_Announcement`;
DELIMITER //
CREATE PROCEDURE `Make_Faculty_Announcement`(
	IN User_id INT,
	IN Faculty_id INT,

	IN Title VARCHAR(100),
	IN Instructions VARCHAR(2000),
	IN File TEXT
)
BEGIN

	IF Is_Faculty_Member(User_id, Faculty_id) = 0 THEN
		SELECT 'Not Faculty Member';
	
	ELSE
		IF Is_Faculty_Staff_Or_Teacher(User_id, Faculty_id) = 0 THEN
			SELECT 'Not Staff Member Or Teacher';
		
		ELSE
			INSERT INTO Faculty_Announcements(Title, Instructions, File, Faculty_id, Creator_id)
				VALUES(Title, Instructions, File, Faculty_id, User_id);
			
			SELECT
				'Created',
				Faculty_Announcements.id,
				Faculty_Announcements.Faculty_id,
				Faculty_Announcements.Title,
				Faculty_Announcements.Instructions,
				Faculty_Announcements.File,
				Faculty_Announcements.Created_At,
				User.id,
				User.Image,
				User.First_Name,
				User.Last_Name
				FROM
					Faculty_Announcements, User
				WHERE
					Faculty_Announcements.id = LAST_INSERT_ID() AND
					Faculty_Announcements.Creator_id = User.id
				LIMIT 1;
		
		END IF;
	END IF;

END //
DELIMITER ;



/**__________________________________________FACULTY_______________________________________________*/



DROP PROCEDURE IF EXISTS `Edit_Faculty_Announcement`;
DELIMITER //
CREATE PROCEDURE `Edit_Faculty_Announcement`(
	IN User_id INT,
	IN Announcement_id INT,
	IN Faculty_id INT,

	IN Title VARCHAR(100),
	IN Instructions VARCHAR(2000)
)
BEGIN

	IF Is_Faculty_Member(User_id, Faculty_id) = 0 THEN
		SELECT 'Not Faculty Member';
	
	ELSE
		IF Is_Faculty_Announcement(Announcement_id, Faculty_id) = 0 THEN
			SELECT 'Not Faculty Announcement';
		
		ELSE
			IF Is_Faculty_Announcement_Creator(User_id, Announcement_id) = 0 THEN
				SELECT 'Not Announcement Creator';
			
			ELSE
				UPDATE Faculty_Announcements
					SET
						Faculty_Announcements.Title = Title,
						Faculty_Announcements.Instructions = Instructions
					WHERE
						Faculty_Announcements.id = Announcement_id
					LIMIT 1;

				SELECT 'Edited';
			
			END IF;
		END IF;
	END IF;

END //
DELIMITER ;



/**__________________________________________FACULTY_______________________________________________*/




DROP PROCEDURE IF EXISTS `Delete_Faculty_Announcement`;
DELIMITER //
CREATE PROCEDURE `Delete_Faculty_Announcement`(
	IN User_id INT,
	IN Announcement_id INT,
	IN Faculty_id INT
)
BEGIN

	IF Is_Faculty_Member(User_id, Faculty_id) = 0 THEN
		SELECT 'Not Faculty Member';
	
	ELSE
		IF Is_Faculty_Announcement(Announcement_id, Faculty_id) = 0 THEN
			SELECT 'Not Faculty Announcement';
		
		ELSE
			IF Is_Faculty_Announcement_Creator(User_id, Announcement_id) = 0 THEN
				SELECT 'Not Announcement Creator';
			
			ELSE
				DELETE FROM Faculty_Announcements WHERE Faculty_Announcements.id = Announcement_id LIMIT 1;
				SELECT 'Deleted';
			
			END IF;
		END IF;
	END IF;

END //
DELIMITER ;



/**__________________________________________FACULTY_______________________________________________*/




DROP PROCEDURE IF EXISTS `Get_Faculty_Announcements`;
DELIMITER //
CREATE PROCEDURE `Get_Faculty_Announcements`(
	IN User_id INT,
	IN Faculty_id INT,
	IN Offset INT
)
BEGIN

	IF Is_Faculty_Member(User_id, Faculty_id) = 0 THEN
		SELECT 'Not Faculty Member';
	
	ELSE
		SELECT
			'Faculty_Announcement',
			Faculty_Announcements.id,
			Faculty_Announcements.Faculty_id,
			Faculty_Announcements.Title,
			Faculty_Announcements.Instructions,
			Faculty_Announcements.File,
			Faculty_Announcements.Created_At,
			User.id,
			User.Image,
			User.First_Name,
			User.Last_Name
			FROM
				Faculty_Announcements, User
			WHERE
				Faculty_Announcements.Creator_id = User.id AND
				Faculty_Announcements.Faculty_id = Faculty_id
			ORDER BY
				Faculty_Announcements.id DESC
			LIMIT 
				Offset, 5;
	END IF;

END //
DELIMITER ;



/**__________________________________________FACULTY_______________________________________________*/
