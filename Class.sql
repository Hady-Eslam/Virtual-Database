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
	Table : Class
	index no : 2
	Length : 37
	Columns : [JoinCode, Academic_Year_id]
	Trigger index Search on Columns : (JoinCode), (JoinCode, Academic_Year_id)
*/
--DROP INDEX IF EXISTS `Class__JoinCode-Academic_Year_id__idx`;
--CREATE INDEX `Class__JoinCode-Academic_Year_id__idx` ON Class(JoinCode, Academic_Year_id);



/*
	Table : Class
	index no : 3
	Length : 25
	Columns : [id, Creator_id]
	Trigger index Search on Columns : (id), (id, Creator_id)
*/
--DROP INDEX IF EXISTS `Class__id-Creator_id__idx`;
--CREATE INDEX `Class__id-Creator_id__idx` ON Class(id, Creator_id);



/**___________________________________________INDEX_________________________________________________*/



/*
	Table : Class_Members
	index no : 2
	Length : 45
	Columns : [User_id, Class_id, Position]
	Trigger index Search on Columns : (User_id), (User_id, Class_id), (User_id, Class_id, Position)
*/
--DROP INDEX IF EXISTS `Class_Members__User_id-Class_id-Position__idx`;
--CREATE INDEX `Class_Members__User_id-Class_id-Position__idx` ON Class_Members(User_id, Class_id, Position);




/**___________________________________________INDEX_________________________________________________*/



/*
	Table : Class_Posts
	index no : 2
	Length : 40
	Columns : [id, Class_id, Creator_id]
	Trigger index Search on Columns : (id), (id, Class_id), (id, Class_id, Creator_id)
*/
--DROP INDEX IF EXISTS `Class_Posts__id-Class_id-Creator_id__idx`;
--CREATE INDEX `Class_Posts__id-Class_id-Creator_id__idx` ON Class_Posts(id, Class_id, Creator_id);



/*
	Table : Class_Posts
	index no : 3
	Length : 37
	Columns : [Class_id, Creator_id]
	Trigger index Search on Columns : (Class_id), (Class_id, Creator_id)
*/
--DROP INDEX IF EXISTS `Class_Posts__Class_id-Creator_id__idx`;
--CREATE INDEX `Class_Posts__Class_id-Creator_id__idx` ON Class_Posts(Class_id, Creator_id);




/**___________________________________________INDEX_________________________________________________*/




/*
	Table : Class_Comments
	index no : 2
	Length : 31
	Columns : [id, Post_id]
	Trigger index Search on Columns : (id), (id, Post_id)
*/
--DROP INDEX IF EXISTS `Class_Comments__id-Post_id__idx`;
--CREATE INDEX `Class_Comments__id-Post_id__idx` ON Class_Comments(id, Post_id);



/*
	Table : Class_Comments
	index no : 3
	Length : 34
	Columns : [id, Creator_id]
	Trigger index Search on Columns : (id), (id, Creator_id)
*/
--DROP INDEX IF EXISTS `Class_Comments__id-Creator_id__idx`;
--CREATE INDEX `Class_Comments__id-Creator_id__idx` ON Class_Comments(id, Creator_id);



/*
	Table : Class_Comments
	index no : 4
	Length : 39
	Columns : [Post_id, Creator_id]
	Trigger index Search on Columns : (Post_id), (Post_id, Creator_id)
*/
--DROP INDEX IF EXISTS `Class_Comments__Post_id-Creator_id__idx`;
--CREATE INDEX `Class_Comments__Post_id-Creator_id__idx` ON Class_Comments(Post_id, Creator_id);




















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


DROP FUNCTION IF EXISTS `Is_Class_JoinCode_Exists`;
DELIMITER //
CREATE FUNCTION `Is_Class_JoinCode_Exists`(
	Academic_Year_id INT,
	JoinCode VARCHAR(6)
)
RETURNS INT
BEGIN
	
	RETURN (SELECT EXISTS( 
		SELECT 1 FROM Class 
			WHERE 
				Class.JoinCode = JoinCode AND
				Class.Academic_Year_id = Academic_Year_id
			LIMIT 1
	));

END //
DELIMITER ;



/**___________________________________________CLASS________________________________________________*/




DROP FUNCTION IF EXISTS `Get_Class_id`;
DELIMITER //
CREATE FUNCTION `Get_Class_id`(
	Academic_Year_id INT,
	JoinCode VARCHAR(6)
)
RETURNS INT
BEGIN
	
	RETURN (
		SELECT Class.id FROM Class
			WHERE
				Class.JoinCode = JoinCode AND
				Class.Academic_Year_id = Academic_Year_id
			LIMIT 1
	);

END //
DELIMITER ;



/**___________________________________________CLASS________________________________________________*/




DROP FUNCTION IF EXISTS `Is_Class_Member`;
DELIMITER //
CREATE FUNCTION `Is_Class_Member`(
	User_id INT,
	Class_id INT
)
RETURNS INT
BEGIN
	
	RETURN (SELECT EXISTS( 
		SELECT 1 FROM Class_Members 
			WHERE 
				Class_Members.User_id = User_id AND
				Class_Members.Class_id = Class_id
			LIMIT 1
	));

END //
DELIMITER ;



/**___________________________________________CLASS________________________________________________*/



DROP FUNCTION IF EXISTS `Is_Class_Post`;
DELIMITER //
CREATE FUNCTION `Is_Class_Post`(
	Post_id INT
)
RETURNS INT
BEGIN
	
	RETURN (SELECT EXISTS( SELECT 1 FROM CLass_Posts WHERE CLass_Posts.id = Post_id LIMIT 1 ));

END //
DELIMITER ;



/**___________________________________________CLASS________________________________________________*/




DROP FUNCTION IF EXISTS `Is_Class_Post_Creator`;
DELIMITER //
CREATE FUNCTION `Is_Class_Post_Creator`(
	User_id INT,
	Post_id INT,
	CLass_id INT
)
RETURNS INT
BEGIN
	
	RETURN (SELECT EXISTS(
		SELECT 1 FROM Class_Posts
			WHERE
				Class_Posts.id = Post_id AND
				Class_Posts.CLass_id = CLass_id AND
				Class_Posts.Creator_id = User_id
			LIMIT 1 
	));

END //
DELIMITER ;



/**___________________________________________CLASS________________________________________________*/



DROP FUNCTION IF EXISTS `Is_Post_in_Class`;
DELIMITER //
CREATE FUNCTION `Is_Post_in_Class`(
	Post_id INT,
	CLass_id INT
)
RETURNS INT
BEGIN

	RETURN (SELECT EXISTS(
		SELECT 1 FROM Class_Posts
			WHERE
				Class_Posts.id = Post_id AND
				Class_Posts.CLass_id = CLass_id
			LIMIT 1
	));

END //
DELIMITER ;



/**___________________________________________CLASS________________________________________________*/



DROP FUNCTION IF EXISTS `Is_Comment_In_Class_Post`;
DELIMITER //
CREATE FUNCTION `Is_Comment_In_Class_Post`(
	Comment_id INT,
	Post_id INT
)
RETURNS INT
BEGIN

	RETURN (SELECT EXISTS(
		SELECT 1 FROM Class_Comments
			WHERE
				Class_Comments.id = Comment_id AND
				Class_Comments.Post_id = Post_id
			LIMIT 1
	));

END //
DELIMITER ;



/**___________________________________________CLASS________________________________________________*/



DROP FUNCTION IF EXISTS `Is_Class_Comment_Creator`;
DELIMITER //
CREATE FUNCTION `Is_Class_Comment_Creator`(
	User_id INT,
	Comment_id INT
)
RETURNS INT
BEGIN
	
	RETURN (SELECT EXISTS(
		SELECT 1 FROM Class_Comments
			WHERE
				Class_Comments.id = Comment_id AND
				Class_Comments.Creator_id = User_id
			LIMIT 1 
	));

END //
DELIMITER ;



/**___________________________________________CLASS________________________________________________*/


DROP FUNCTION IF EXISTS `Is_Class_Admin`;
DELIMITER //
CREATE FUNCTION `Is_Class_Admin`(
	Admin_id INT,
	Class_id INT
)
RETURNS INT
BEGIN
	
	RETURN (SELECT EXISTS( 
		SELECT 1 FROM Class_Members 
			WHERE 
				Class_Members.User_id = Admin_id AND
				Class_Members.Class_id = Class_id AND
				Class_Members.Position = 'Admin'
			LIMIT 1
	));

END //
DELIMITER ;




/**___________________________________________CLASS________________________________________________*/




DROP FUNCTION IF EXISTS `Is_Class_Creator`;
DELIMITER //
CREATE FUNCTION `Is_Class_Creator`(
	Creator_id INT,
	Class_id INT
)
RETURNS INT
BEGIN
	
	RETURN (SELECT EXISTS(
		SELECT 1 FROM Class
			WHERE
				Class.id = Class_id AND
				Class.Creator_id = Creator_id
			LIMIT 1
	));

END //
DELIMITER ;



/**___________________________________________CLASS________________________________________________*/



DROP FUNCTION IF EXISTS `Is_Class_Assignment`;
DELIMITER //
CREATE FUNCTION `Is_Class_Assignment`(
	Assignment_id INT,
	Class_id INT
)
RETURNS INT
BEGIN
	
	RETURN (SELECT EXISTS(
		SELECT 1 FROM Class_Assignments
			WHERE
				Class_Assignments.id = Assignment_id AND
				Class_Assignments.Class_id = Class_id
			LIMIT 1
	));

END //
DELIMITER ;




/**___________________________________________CLASS________________________________________________*/



DROP FUNCTION IF EXISTS `Is_Class_Assignment_Creator`;
DELIMITER //
CREATE FUNCTION `Is_Class_Assignment_Creator`(
	User_id INT,
	Assignment_id INT
)
RETURNS INT
BEGIN
	
	RETURN (SELECT EXISTS(
		SELECT 1 FROM Class_Assignments
			WHERE
				Class_Assignments.id = Assignment_id AND
				Class_Assignments.Creator_id = User_id
			LIMIT 1
	));

END //
DELIMITER ;





/**___________________________________________CLASS________________________________________________*/




DROP FUNCTION IF EXISTS `Is_Class_Staff_Or_Teacher`;
DELIMITER //
CREATE FUNCTION `Is_Class_Staff_Or_Teacher`(
	User_id INT,
	Class_id INT
)
RETURNS INT
BEGIN
	
	RETURN (SELECT EXISTS(
		SELECT 1 FROM User WHERE User.I_AM != 'Student' AND User.Status = 'Approved' AND User.id = User_id LIMIT 1
	));

END //
DELIMITER ;




/**___________________________________________CLASS________________________________________________*/




DROP FUNCTION IF EXISTS `Is_Class_Announcement`;
DELIMITER //
CREATE FUNCTION `Is_Class_Announcement`(
	Announcement_id INT,
	Class_id INT
)
RETURNS INT
BEGIN
	
	RETURN (SELECT EXISTS(
		SELECT 1 FROM Class_Announcements
			WHERE
				Class_Announcements.id = Announcement_id AND
				Class_Announcements.Class_id = Class_id
			LIMIT 1
	));

END //
DELIMITER ;




/**__________________________________________FACULTY_______________________________________________*/




DROP FUNCTION IF EXISTS `Is_Class_Announcement_Creator`;
DELIMITER //
CREATE FUNCTION `Is_Class_Announcement_Creator`(
	User_id INT,
	Announcement_id INT
)
RETURNS INT
BEGIN
	
	RETURN (SELECT EXISTS(
		SELECT 1 FROM Class_Announcements
			WHERE
				Class_Announcements.id = Announcement_id AND
				Class_Announcements.Creator_id = User_id
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






























/*

DROP PROCEDURE IF EXISTS `Is_Class_JoinCode_Registered`;
DELIMITER //
CREATE PROCEDURE `Is_Class_JoinCode_Registered`(
	IN Faculty_id INT,
	IN Academic_Year_id INT,
	IN JoinCode VARCHAR(6)
)
BEGIN
	
	SELECT Is_Class_JoinCode_Exists(Faculty_id, Academic_Year_id, JoinCode) AS `Result`;

END //
DELIMITER ;



/**___________________________________________CLASS________________________________________________*/



DROP PROCEDURE IF EXISTS `Create_Class`;
DELIMITER //
CREATE PROCEDURE `Create_Class`(
	IN Faculty_id INT,
	IN Academic_Year_id INT,
	IN Creator_id INT,
	IN Name VARCHAR(100),
	IN JoinCode VARCHAR(6),
	IN Descreption VARCHAR(1000),
	IN Image VARCHAR(100)
)
BEGIN
	
	IF Is_Class_JoinCode_Exists(Academic_Year_id, JoinCode) = 1 THEN
		SELECT 'Join Code Found';

	ELSE
		IF Is_Faculty_Member(Creator_id, Faculty_id) = 0 THEN
			SELECT 'Not Faculty Member';
		
		ELSE
			IF Is_Academic_Year_Admin(Creator_id, Academic_Year_id) = 0 THEN
				SELECT 'Do Not Have Permision';

			ELSE
				START TRANSACTION;

					INSERT INTO Class(Name, JoinCode, Creator_id, Descreption, Academic_Year_id, Image)
						VALUES (Name, JoinCode, Creator_id, Descreption, Academic_Year_id, Image);
					
					SET @Class_id = Get_Class_id(Academic_Year_id, JoinCode);

					INSERT INTO Class_Members(User_id, Class_id, Position)
						VALUES (Creator_id, @Class_id, 'Admin');

					SELECT 'Created', @Class_id;
				
				COMMIT;

			END IF;
		END IF;
	END IF;

END //
DELIMITER ;



/**___________________________________________CLASS________________________________________________*/



DROP PROCEDURE IF EXISTS `Join_Class`;
DELIMITER //
CREATE PROCEDURE `Join_Class`(
	IN User_id INT,
	IN Academic_Year_id INT,
	IN Faculty_id INT,
	IN User_JoinCode VARCHAR(6)
)
BEGIN

	SET @CLass_id = Get_Class_id(Academic_Year_id, User_JoinCode);

	IF @Class_id IS NULL THEN
		SELECT 'Class Not Found';

	ELSE
		IF Is_Faculty_Member(User_id, Faculty_id) = 0 THEN
			SELECT 'Not Faculty Member';
		
		ELSE
			IF Is_Academic_Year_Member(User_id, Academic_Year_id) = 0 THEN
				SELECT 'Not Academic Year Member';

			ELSE
				IF Is_Class_Member(User_id, @Class_id) = 1 THEN
					SELECT 'Already Member';

				ELSE
					INSERT INTO Class_Members(User_id, Class_id, Position)
						VALUES (User_id, @Class_id, 'Member');

					SELECT 'Joined', @Class_id;

				END IF;
			END IF;
		END IF;
	END IF;

END //
DELIMITER ;



/**___________________________________________CLASS________________________________________________*/



DROP PROCEDURE IF EXISTS `Show_All_Classes`;
DELIMITER //
CREATE PROCEDURE `Show_All_Classes`(
	IN User_id INT,
	IN Academic_Year_id INT
)
BEGIN
	
	IF Is_Academic_Year_Member(User_id, Academic_Year_id) = 0 THEN
		SELECT 'Not Academic Year Member' AS `Result`;

	ELSE
		SELECT
			Class.id,
			Class.Name,
			Class.Descreption

			FROM Class, Class_Members

			WHERE
				Class.Academic_Year_id = Academic_Year_id AND
				Class.id = Class_Members.Class_id AND
				Class_Members.User_id = User_id;

	END IF;

END //
DELIMITER ;



/**___________________________________________CLASS________________________________________________*/



DROP PROCEDURE IF EXISTS `Make_Class_Post`;
DELIMITER //
CREATE PROCEDURE `Make_Class_Post`(
	IN User_id INT,
	IN Class_id INT,
	IN Academic_Year_id INT,
	IN Faculty_id INT,
	IN Post TEXT,
	IN Files TEXT
)
BEGIN
	
	IF Is_Faculty_Member(User_id, Faculty_id) = 0 THEN
		SELECT 'Not Faculty Member';
	
	ELSE
		IF Is_Academic_Year_Member(User_id, Academic_Year_id) = 0 THEN
			SELECT 'Not Academic Year Member';
		
		ELSE
			IF Is_Class_Member(User_id, Class_id) = 0 THEN
				SELECT 'Not Class Member';

			ELSE
				INSERT INTO Class_Posts(Class_id, Creator_id, Post, Files) VALUES (Class_id, User_id, Post, Files);
				SELECT
					'Created',
					Class_Posts.id,
					Class_Posts.Class_id,
					Class_Posts.Creator_id,
					Class_Posts.Post,
					Class_Posts.Files,
					Class_Posts.Created_At
					FROM
						Class_Posts
					WHERE
						Class_Posts.id = LAST_INSERT_ID()
					LIMIT 1;

			END IF;
		END IF;
	END IF;

END //
DELIMITER ;



/**___________________________________________CLASS________________________________________________*/



DROP PROCEDURE IF EXISTS `Edit_Class_Post`;
DELIMITER //
CREATE PROCEDURE `Edit_Class_Post`(
	IN User_id INT,
	IN Post_id INT,
	IN Class_id INT,
	IN Academic_Year_id INT,
	IN Faculty_id INT,
	IN Post TEXT
)
BEGIN
	
	IF Is_Faculty_Member(User_id, Faculty_id) = 0 THEN
		SELECT 'Not Faculty Member';
	
	ELSE
		IF Is_Academic_Year_Member(User_id, Academic_Year_id) = 0 THEN
			SELECT 'Not Academic Year Member';
		
		ELSE
			IF Is_Class_Member(User_id, Class_id) = 0 THEN
				SELECT 'Not Class Member';
			
			ELSE
				IF IS_Class_Post_Creator(User_id, Post_id, Class_id) = 0 THEN
					SELECT 'Not Post Creator';

				ELSE
					UPDATE Class_Posts SET Class_Posts.Post = Post WHERE Class_Posts.id = Post_id LIMIT 1;
					SELECT 'Edited';

				END IF;
			END IF;
		END IF;
	END IF;

END //
DELIMITER ;



/**___________________________________________CLASS________________________________________________*/



DROP PROCEDURE IF EXISTS `Delete_Class_Post`;
DELIMITER //
CREATE PROCEDURE `Delete_Class_Post`(
	IN User_id INT,
	IN Post_id INT,
	IN Class_id INT,
	IN Academic_Year_id INT,
	IN Faculty_id INT
)
BEGIN
	
	IF Is_Faculty_Member(User_id, Faculty_id) = 0 THEN
		SELECT 'Not Faculty Member';
	
	ELSE
		IF Is_Academic_Year_Member(User_id, Academic_Year_id) = 0 THEN
			SELECT 'Not Academic Year Member';
		
		ELSE
			IF Is_Class_Member(User_id, Class_id) = 0 THEN
				SELECT 'Not Class Member';
			
			ELSE
				IF Is_Class_Post_Creator(User_id, Post_id, Class_id) = 0 THEN
					SELECT 'Not Post Creator';
			
				ELSE
					DELETE FROM Class_Posts WHERE Class_Posts.id = Post_id LIMIT 1;
					SELECT 'Deleted';

				END IF;
			END IF;
		END IF;
	END IF;

END //
DELIMITER ;



/**___________________________________________CLASS________________________________________________*/



DROP PROCEDURE IF EXISTS `Make_Class_Comment`;
DELIMITER //
CREATE PROCEDURE `Make_Class_Comment`(
	IN User_id INT,
	IN Post_id INT,
	IN Class_id INT,
	IN Academic_Year_id INT,
	IN Faculty_id INT,
	IN Comment VARCHAR(2000)
)
BEGIN
	
	IF Is_Faculty_Member(User_id, Faculty_id) = 0 THEN
		SELECT 'Not Faculty Member';
	
	ELSE
		IF Is_Academic_Year_Member(User_id, Academic_Year_id) = 0 THEN
			SELECT 'Not Academic Year Member';
		
		ELSE
			IF Is_Class_Member(User_id, Class_id) = 0 THEN
				SELECT 'Not Class Member';
			
			ELSE
				IF Is_Post_in_Class(Post_id, Class_id) = 0 THEN
					SELECT 'Post Not Found';

				ELSE
					INSERT INTO Class_Comments(Creator_id, Post_id, Comment) VALUES(User_id, Post_id, Comment);
					SELECT
						'Created',
						Class_Comments.id,
						Class_Comments.Creator_id,
						Class_Comments.Post_id,
						Class_Comments.Comment,
						Class_Comments.Created_At
						FROM 
							Class_Comments
						WHERE
							Class_Comments.id = LAST_INSERT_ID()
						LIMIT 1;

				END IF;
			END IF;
		END IF;
	END IF;

END //
DELIMITER ;



/**___________________________________________CLASS________________________________________________*/



DROP PROCEDURE IF EXISTS `Edit_Class_Comment`;
DELIMITER //
CREATE PROCEDURE `Edit_Class_Comment`(
	IN User_id INT,
	IN Comment_id INT,
	IN Post_id INT,
	IN Class_id INT,
	IN Academic_Year_id INT,
	IN Faculty_id INT,
	IN New_Comment VARCHAR(2000)
)
BEGIN
	
	IF Is_Faculty_Member(User_id, Faculty_id) = 0 THEN
		SELECT 'Not Faculty Member';
	
	ELSE
		IF Is_Academic_Year_Member(User_id, Academic_Year_id) = 0 THEN
			SELECT 'Not Academic Year Member';
		
		ELSE
			IF Is_Class_Member(User_id, Class_id) = 0 THEN
				SELECT 'Not Class Member';
			
			ELSE
				IF Is_Post_in_Class(Post_id, Class_id) = 0 THEN
					SELECT 'Not Class Post';
				
				ELSE
					IF Is_Comment_In_Class_Post(Comment_id, Post_id) = 0 THEN
						SELECT 'Not Class Comment';
					
					ELSE
						IF Is_Class_Comment_Creator(User_id, Comment_id) = 0 THEN
							SELECT 'Not Comment Creator';

						ELSE
							UPDATE Class_Comments
								SET
									Class_Comments.Comment = New_Comment
								WHERE
									Class_Comments.id = Comment_id
								LIMIT 1;

							SELECT 'Edited';

						END IF;
					END IF;
				END IF;
			END IF;
		END IF;
	END IF;

END //
DELIMITER ;



/**___________________________________________CLASS________________________________________________*/



DROP PROCEDURE IF EXISTS `Delete_Class_Comment`;
DELIMITER //
CREATE PROCEDURE `Delete_Class_Comment`(
	IN User_id INT,
	IN Comment_id INT,
	IN Post_id INT,
	IN Class_id INT,
	IN Academic_Year_id INT,
	IN Faculty_id INT
)
BEGIN
	
	IF Is_Faculty_Member(User_id, Faculty_id) = 0 THEN
		SELECT 'Not Faculty Member';
	
	ELSE
		IF Is_Academic_Year_Member(User_id, Academic_Year_id) = 0 THEN
			SELECT 'Not Academic Year Member';
		
		ELSE
			IF Is_Class_Member(User_id, Class_id) = 0 THEN
				SELECT 'Not Class Member';
			
			ELSE
				IF Is_Comment_In_Class_Post(Comment_id, Post_id) = 0 THEN
					SELECT 'Not Class Comment';
				
				ELSE
					IF Is_Class_Comment_Creator(User_id, Comment_id) = 0 THEN
						SELECT 'Not Comment Creator';
					
					ELSE
						DELETE FROM Class_Comments WHERE Class_Comments.id = Comment_id LIMIT 1;
						SELECT 'Deleted';

					END IF;
				END IF;
			END IF;
		END IF;
	END IF;

END //
DELIMITER ;



/**___________________________________________CLASS________________________________________________*/



DROP PROCEDURE IF EXISTS `Get_Class_Post_Comments`;
DELIMITER //
CREATE PROCEDURE `Get_Class_Post_Comments`(
	IN User_id INT,
	IN Post_id INT,
	IN Class_id INT,
	IN Academic_Year_id INT,
	IN Faculty_id INT,
	IN Offset INT
)
BEGIN
	
	IF Is_Faculty_Member(User_id, Faculty_id) = 0 THEN
		SELECT 'Not Faculty Member';
	
	ELSE
		IF Is_Academic_Year_Member(User_id, Academic_Year_id) = 0 THEN
			SELECT 'Not Academic Year Member';
		
		ELSE
			IF Is_Class_Member(User_id, Class_id) = 0 THEN
				SELECT 'Not Class Member';
			
			ELSE
				IF Is_Post_in_Class(Post_id, Class_id) = 0 THEN
					SELECT 'Not Class Post';

				ELSE
					SELECT
						'Comments',
						Class_Comments.id,
						Class_Comments.Creator_id,
						Class_Comments.Post_id,
						Class_Comments.Comment,
						Class_Comments.Created_At,
						User.id,
						User.First_Name,
						User.Last_Name,
						User.Image 
						FROM 
							Class_Comments, User
						WHERE
							Class_Comments.Post_id = Post_id AND
							Class_Comments.Creator_id = User.id
						ORDER BY
							Class_Comments.id DESC
						LIMIT 10
						OFFSET Offset;

				END IF;
			END IF;
		END IF;
	END IF;

END //
DELIMITER ;




/**___________________________________________CLASS________________________________________________*/



DROP PROCEDURE IF EXISTS `Get_All_Class_Assignments`;
DELIMITER //
CREATE PROCEDURE `Get_All_Class_Assignments`(
	IN Admin_id INT,
	IN Class_id INT
)
BEGIN
	
	IF Is_Class_Member(Admin_id, Class_id) = 0 THEN
		SELECT 'Not Class Member' AS `Result`;

	ELSE
		SELECT * FROM Class_Assignment WHERE Class_Assignment.Class_id = Class_id;

	END IF;

END //
DELIMITER ;



/**___________________________________________CLASS________________________________________________*/



DROP PROCEDURE IF EXISTS `Show_Class`;
DELIMITER //
CREATE PROCEDURE `Show_Class`(
	IN User_id INT,
	IN Class_id INT,
	IN Academic_Year_id INT,
	IN Faculty_id INT,
	IN Offset INT
)
BEGIN
	
	IF Is_Faculty_Member(User_id, Faculty_id) = 0 THEN
		SELECT 'Not Faculty Member';
	
	ELSE
		IF Is_Academic_Year_Member(User_id, Academic_Year_id) = 0 THEN
			SELECT 'Not Academic Year Member';
		
		ELSE
			IF Is_Class_Member(User_id, Class_id) = 0 THEN
				SELECT 'Not Class Member';

			ELSE
				SELECT
					'Posts',
					Class_Posts.id,
					Class_Posts.Class_id,
					Class_Posts.Creator_id,
					Class_Posts.Post,
					Class_Posts.Files,
					Class_Posts.Created_At,
					User.id,
					User.Image,
					User.First_Name,
					User.Last_Name
					FROM
						Class_Posts, User
					WHERE
						Class_Posts.Class_id = Class_id AND
						Class_Posts.Creator_id = User.id
					ORDER BY
						Class_Posts.id DESC
					LIMIT
						Offset, 5;

			END IF;
		END IF;
	END IF;

END //
DELIMITER ;



/**___________________________________________CLASS________________________________________________*/



DROP PROCEDURE IF EXISTS `Show_Class_Settings`;
DELIMITER //
CREATE PROCEDURE `Show_Class_Settings`(
	IN Admin_id INT,
	IN Class_id INT,
	IN Academic_Year_id INT,
	IN Faculty_id INT
)
BEGIN
	
	IF Is_Faculty_Member(Admin_id, Faculty_id) = 0 THEN
		SELECT 'Not Faculty Member';
	
	ELSE
		IF Is_Academic_Year_Member(Admin_id, Academic_Year_id) = 0 THEN
			SELECT 'Not Academic Year Member';
		
		ELSE
			IF Is_Class_Admin(Admin_id, Class_id) = 0 THEN
				SELECT 'Not Admin';

			ELSE
				SELECT 
					'Settings',
					Class.id,
					Class.Name,
					Class.JoinCode,
					Class.Descreption,
					Class.Image,
					Class.Created_At,
					User.id,
					User.First_Name,
					User.Last_Name,
					User.Image
					FROM 
						Class, User 
					WHERE
						Class.id = Class_id AND
						Class.Creator_id = User.id 
					LIMIT 1;

			END IF;
		END IF;
	END IF;

END //
DELIMITER ;



/**___________________________________________CLASS________________________________________________*/



DROP PROCEDURE IF EXISTS `Edit_Class_Settings`;
DELIMITER //
CREATE PROCEDURE `Edit_Class_Settings`(
	IN Admin_id INT,
	IN Class_id INT,
	IN Academic_Year_id INT,
	IN Faculty_id INT,
	IN Name VARCHAR(100),
	IN Descreption VARCHAR(1000)
)
BEGIN

	IF Is_Faculty_Member(Admin_id, Faculty_id) = 0 THEN
		SELECT 'Not Faculty Member';
	
	ELSE
		IF Is_Academic_Year_Member(Admin_id, Academic_Year_id) = 0 THEN
			SELECT 'Not Academic Year Member';
		
		ELSE
			IF Is_Class_Admin(Admin_id, Class_id) = 0 THEN
				SELECT 'Not Admin';

			ELSE
				UPDATE Class SET Class.Name = Name, Class.Descreption = Descreption WHERE Class.id = Class_id LIMIT 1;
				SELECT 'Edited';

			END IF;
		END IF;
	END IF;

END //
DELIMITER ;



/**___________________________________________CLASS________________________________________________*/


/*
DROP PROCEDURE IF EXISTS `Delete_Class`;
DELIMITER //
CREATE PROCEDURE `Delete_Class`(
	IN Admin_id INT,
	IN Class_id INT
)
BEGIN

	IF Is_Class_Creator(Admin_id, Class_id) = 0 THEN
		SELECT 'Do Not Have Permision' AS `Result`;

	ELSE
		START TRANSACTION;
			
			DELETE FROM Class_Comments WHERE Class_Comments.Post_id IN (
				SELECT Class_Posts.id FROM Class_Posts WHERE Class_Posts.Class_id = Class_id
			);
			DELETE FROM Class_Posts WHERE Class_Posts.Class_id = Class_id;
			DELETE FROM Class_Members WHERE Class_Members.Class_id = Class_id;
			DELETE FROM Class WHERE Class.id = Class_id LIMIT 1;
			SELECT 'Done' AS `Result`;
		
		COMMIT;
	END IF;

END //
DELIMITER ;



/**___________________________________________CLASS________________________________________________*/




DROP PROCEDURE IF EXISTS `Show_Class_Members`;
DELIMITER //
CREATE PROCEDURE `Show_Class_Members`(
	IN User_id INT,
	IN Class_id INT,
	IN Academic_Year_id INT,
	IN Faculty_id INT,
	IN Offset INT
)
BEGIN

	IF Is_Faculty_Member(User_id, Faculty_id) = 0 THEN
		SELECT 'Not Faculty Member';
	
	ELSE
		IF Is_Academic_Year_Member(User_id, Academic_Year_id) = 0 THEN
			SELECT 'Not Academic Year Member';
		
		ELSE
			IF Is_Class_Member(User_id, Class_id) = 0 THEN
				SELECT 'Not Class Member';

			ELSE
				SELECT
					'Member',
					Class_Members.id,
					Class_Members.CLass_id,
					Class_Members.User_id,
					Class_Members.Role,
					Class_Members.Position,
					Class_Members.Joined_At,
					User.Image,
					User.First_Name,
					User.Last_Name
					FROM 
						Class_Members, User 
					WHERE
						Class_Members.User_id = User.id AND
						Class_Members.CLass_id = CLass_id
					LIMIT
						Offset, 15;
			END IF;
		END IF;
	END IF;

END //
DELIMITER ;



/**___________________________________________CLASS________________________________________________*/



DROP PROCEDURE IF EXISTS `Kick_Class_Member`;
DELIMITER //
CREATE PROCEDURE `Kick_Class_Member`(
	IN Admin_id INT,
	IN Faculty_id INT,
	IN Academic_Year_id INT,
	IN Class_id INT,
	IN User_id INT
)
BEGIN

	IF Is_Faculty_Member(Admin_id, Faculty_id) = 0 THEN
		SELECT 'Not Faculty Member';
	
	ELSE
		IF Is_Academic_Year_Member(Admin_id, Academic_Year_id) = 0 THEN
			SELECT 'Not Academic Year Member';
		
		ELSE
			IF Is_Class_Admin(Admin_id, Class_id) = 0 THEN
				SELECT 'Do Not Have Permision';

			ELSE
				IF Is_Class_Creator(User_id, CLass_id) = 1 THEN
					SELECT 'Can Not Kick Out Creator';

				ELSE
					DELETE FROM Class_Members
						WHERE
							Class_Members.User_id = User_id AND
							Class_Members.CLass_id = CLass_id
						LIMIT 1;
					SELECT 'Kicked';

				END IF;
			END IF;
		END IF;
	END IF;

END //
DELIMITER ;



/**___________________________________________CLASS________________________________________________*/



DROP PROCEDURE IF EXISTS `Leave_Class`;
DELIMITER //
CREATE PROCEDURE `Leave_Class`(
	IN User_id INT,
	IN Class_id INT
)
BEGIN
	
	IF Is_Class_Creator(User_id, CLass_id) = 1 THEN
		SELECT 'Creator Can Not Leave';
	
	ELSE
		DELETE FROM Class_Members
			WHERE
				Class_Members.User_id = User_id AND
				Class_Members.CLass_id = CLass_id
			LIMIT 1;
		SELECT 'Leaved';
	
	END IF;

END //
DELIMITER ;




/**___________________________________________CLASS________________________________________________*/



DROP PROCEDURE IF EXISTS `Make_Class_Assignment`;
DELIMITER //
CREATE PROCEDURE `Make_Class_Assignment`(
	IN User_id INT,
	IN Class_id INT,
	IN Academic_Year_id INT,
	IN Faculty_id INT,

	IN Title VARCHAR(100),
	IN Instructions VARCHAR(2000),
	IN Topic VARCHAR(100),
	IN Points INT,
	IN Due_Date DATE,
	IN Due_Time TIME,
	IN File TEXT
)
BEGIN
	
	IF Is_Faculty_Member(User_id, Faculty_id) = 0 THEN
		SELECT 'Not Faculty Member';
	
	ELSE
		IF Is_Academic_Year_Member(User_id, Academic_Year_id) = 0 THEN
			SELECT 'Not Academic Year Member';
		
		ELSE
			IF Is_Class_Member(User_id, Class_id) = 0 THEN
				SELECT 'Not Class Member';
			
			ELSE
				IF Is_User_Teacher(User_id) = 0 THEN
					SELECT 'Not Teacher';
				
				ELSE
					INSERT INTO Class_Assignments(
						Creator_id, Class_id, Title, Instructions, Topic, Points, Due_Date, Due_Time, File
					)VALUES (
						User_id, Class_id, Title, Instructions, Topic, Points, Due_Date, Due_Time, File
					);

					SELECT 
						'Created',
						Class_Assignments.id,
						Class_Assignments.Creator_id,
						Class_Assignments.Class_id,
						Class_Assignments.Title,
						Class_Assignments.Instructions,
						Class_Assignments.Topic,
						Class_Assignments.Points,
						Class_Assignments.Due_Date,
						Class_Assignments.Due_Time,
						Class_Assignments.File,
						User.id,
						User.Image,
						User.First_Name,
						User.Last_Name
						FROM 
							Class_Assignments, User
						WHERE
							Class_Assignments.id = LAST_INSERT_ID() AND
							Class_Assignments.Creator_id = User.id
						LIMIT 1;
				
				END IF;
			END IF;
		END IF;
	END IF;

END //
DELIMITER ;



/**___________________________________________CLASS________________________________________________*/



DROP PROCEDURE IF EXISTS `Edit_Class_Assignment`;
DELIMITER //
CREATE PROCEDURE `Edit_Class_Assignment`(
	IN User_id INT,
	IN Assignment_id INT,
	IN Class_id INT,
	IN Academic_Year_id INT,
	IN Faculty_id INT,

	IN Title VARCHAR(100),
	IN Instructions VARCHAR(2000),
	IN Topic VARCHAR(100),
	IN Points INT,
	IN Due_Date DATE,
	IN Due_Time TIME
)
BEGIN
	
	IF Is_Faculty_Member(User_id, Faculty_id) = 0 THEN
		SELECT 'Not Faculty Member';
	
	ELSE
		IF Is_Academic_Year_Member(User_id, Academic_Year_id) = 0 THEN
			SELECT 'Not Academic Year Member';
		
		ELSE
			IF Is_Class_Member(User_id, Class_id) = 0 THEN
				SELECT 'Not Class Member';
			
			ELSE
				IF Is_Class_Assignment(Assignment_id, Class_id) = 0 THEN
					SELECT 'Not Class Assignment';
				
				ELSE
					IF Is_Class_Assignment_Creator(User_id, Assignment_id) = 0 THEN
						SELECT 'Not Class Assignment Creator';
					
					ELSE

						UPDATE Class_Assignments
							SET
								Class_Assignments.Title = Title,
								Class_Assignments.Instructions = Instructions,
								Class_Assignments.Topic = Topic,
								Class_Assignments.Points = Points,
								Class_Assignments.Due_Date = Due_Date,
								Class_Assignments.Due_Time = Due_Time
							WHERE
								Class_Assignments.id = Assignment_id
							LIMIT 1;
						
						SELECT 'Edited';

					END IF;
				END IF;
			END IF;
		END IF;
	END IF;

END //
DELIMITER ;



/**___________________________________________CLASS________________________________________________*/



DROP PROCEDURE IF EXISTS `Delete_Class_Assignment`;
DELIMITER //
CREATE PROCEDURE `Delete_Class_Assignment`(
	IN User_id INT,
	IN Assignment_id INT,
	IN Class_id INT,
	IN Academic_Year_id INT,
	IN Faculty_id INT
)
BEGIN
	
	IF Is_Faculty_Member(User_id, Faculty_id) = 0 THEN
		SELECT 'Not Faculty Member';
	
	ELSE
		IF Is_Academic_Year_Member(User_id, Academic_Year_id) = 0 THEN
			SELECT 'Not Academic Year Member';
		
		ELSE
			IF Is_Class_Member(User_id, Class_id) = 0 THEN
				SELECT 'Not Class Member';
			
			ELSE
				IF Is_Class_Assignment(Assignment_id, Class_id) = 0 THEN
					SELECT 'Not Class Assignment';
				
				ELSE
					IF Is_Class_Assignment_Creator(User_id, Assignment_id) = 0 THEN
						SELECT 'Not Class Assignment Creator';
					
					ELSE
						DELETE FROM Class_Assignments WHERE Class_Assignments.id = Assignment_id LIMIT 1;
						SELECT 'Deleted';
					
					END IF;
				END IF;
			END IF;
		END IF;
	END IF;

END //
DELIMITER ;



/**___________________________________________CLASS________________________________________________*/



DROP PROCEDURE IF EXISTS `Get_Class_Assignments`;
DELIMITER //
CREATE PROCEDURE `Get_Class_Assignments`(
	IN User_id INT,
	IN Class_id INT,
	IN Academic_Year_id INT,
	IN Faculty_id INT,
	IN Offset INT
)
BEGIN
	
	IF Is_Faculty_Member(User_id, Faculty_id) = 0 THEN
		SELECT 'Not Faculty Member';
	
	ELSE
		IF Is_Academic_Year_Member(User_id, Academic_Year_id) = 0 THEN
			SELECT 'Not Academic Year Member';
		
		ELSE
			IF Is_Class_Member(User_id, Class_id) = 0 THEN
				SELECT 'Not Class Member';
			
			ELSE
				SELECT 
					'Assignments',
					Class_Assignments.id,
					Class_Assignments.Creator_id,
					Class_Assignments.Class_id,
					Class_Assignments.Title,
					Class_Assignments.Instructions,
					Class_Assignments.Topic,
					Class_Assignments.Points,
					Class_Assignments.Due_Date,
					Class_Assignments.Due_Time,
					Class_Assignments.File,
					Class_Assignments.Created_At,
					User.id,
					User.Image,
					User.First_Name,
					User.Last_Name
					FROM 
						Class_Assignments, User
					WHERE
						Class_Assignments.Creator_id = User.id AND
						Class_Assignments.Due_Date >= CURRENT_DATE() AND
						Class_Assignments.Due_Time >= CURRENT_TIME()
					ORDER BY
						Class_Assignments.id DESC
					LIMIT
						Offset, 5;

			END IF;
		END IF;
	END IF;

END //
DELIMITER ;




/**___________________________________________CLASS________________________________________________*/




DROP PROCEDURE IF EXISTS `Make_Class_Announcement`;
DELIMITER //
CREATE PROCEDURE `Make_Class_Announcement`(
	IN User_id INT,
	IN Class_id INT,
	IN Academic_Year_id INT,
	IN Faculty_id INT,

	IN Title VARCHAR(100),
	IN Instructions VARCHAR(2000),
	IN File TEXT
)
BEGIN

	IF Is_Faculty_Member(User_id, Faculty_id) = 0 THEN
		SELECT 'Not Faculty Member';
	
	ELSE
		IF Is_Academic_Year_Member(User_id, Academic_Year_id) = 0 THEN
			SELECT 'Not Academic Year Member';
	
		ELSE
			IF Is_Class_Member(User_id, Class_id) = 0 THEN
				SELECT 'Not Class Member';
			
			ELSE
				IF Is_Class_Staff_Or_Teacher(User_id, Class_id) = 0 THEN
					SELECT 'Not Staff Member Or Teacher';
				
				ELSE
					INSERT INTO Class_Announcements(Title, Instructions, File, Class_id, Creator_id)
						VALUES(Title, Instructions, File, Class_id, User_id);
					
					SELECT
						'Created',
						Class_Announcements.id,
						Class_Announcements.Class_id,
						Class_Announcements.Title,
						Class_Announcements.Instructions,
						Class_Announcements.File,
						Class_Announcements.Created_At,
						User.id,
						User.Image,
						User.First_Name,
						User.Last_Name
						FROM
							Class_Announcements, User
						WHERE
							Class_Announcements.id = LAST_INSERT_ID() AND
							Class_Announcements.Creator_id = User.id
						LIMIT 1;

				END IF;
			END IF;	
		END IF;
	END IF;

END //
DELIMITER ;



/**___________________________________________CLASS________________________________________________*/



DROP PROCEDURE IF EXISTS `Edit_Class_Announcement`;
DELIMITER //
CREATE PROCEDURE `Edit_Class_Announcement`(
	IN User_id INT,
	IN Announcement_id INT,
	IN Class_id INT,
	IN Academic_Year_id INT,
	IN Faculty_id INT,

	IN Title VARCHAR(100),
	IN Instructions VARCHAR(2000)
)
BEGIN

	IF Is_Faculty_Member(User_id, Faculty_id) = 0 THEN
		SELECT 'Not Faculty Member';
	
	ELSE
		IF Is_Academic_Year_Member(User_id, Academic_Year_id) = 0 THEN
			SELECT 'Not Academic Year Member';
	
		ELSE
			IF Is_Class_Member(User_id, Class_id) = 0 THEN
				SELECT 'Not Class Member';
			
			ELSE
				IF Is_Class_Announcement(Announcement_id, Class_id) = 0 THEN
					SELECT 'Not Class Announcement';
				
				ELSE
					IF Is_Class_Announcement_Creator(User_id, Announcement_id) = 0 THEN
						SELECT 'Not Announcement Creator';
					
					ELSE
						UPDATE Class_Announcements
							SET
								Class_Announcements.Title = Title,
								Class_Announcements.Instructions = Instructions
							WHERE
								Class_Announcements.id = Announcement_id
							LIMIT 1;

						SELECT 'Edited';

					END IF;
				END IF;
			END IF;
		END IF;
	END IF;

END //
DELIMITER ;



/**___________________________________________CLASS________________________________________________*/




DROP PROCEDURE IF EXISTS `Delete_Class_Announcement`;
DELIMITER //
CREATE PROCEDURE `Delete_Class_Announcement`(
	IN User_id INT,
	IN Announcement_id INT,
	IN Class_id INT,
	IN Academic_Year_id INT,
	IN Faculty_id INT
)
BEGIN

	IF Is_Faculty_Member(User_id, Faculty_id) = 0 THEN
		SELECT 'Not Faculty Member';
	
	ELSE
		IF Is_Academic_Year_Member(User_id, Academic_Year_id) = 0 THEN
			SELECT 'Not Academic Year Member';
	
		ELSE
			IF Is_Class_Member(User_id, Class_id) = 0 THEN
				SELECT 'Not Class Member';
			
			ELSE
				IF Is_Class_Announcement(Announcement_id, Class_id) = 0 THEN
					SELECT 'Not Class Announcement';
				
				ELSE
					IF Is_Class_Announcement_Creator(User_id, Announcement_id) = 0 THEN
						SELECT 'Not Announcement Creator';
					
					ELSE
						DELETE FROM Class_Announcements
							WHERE
								Class_Announcements.id = Announcement_id
							LIMIT 1;
						SELECT 'Deleted';

					END IF;
				END IF;
			END IF;
		END IF;
	END IF;

END //
DELIMITER ;



/**___________________________________________CLASS________________________________________________*/




DROP PROCEDURE IF EXISTS `Get_Class_Announcements`;
DELIMITER //
CREATE PROCEDURE `Get_Class_Announcements`(
	IN User_id INT,
	IN Class_id INT,
	IN Academic_Year_id INT,
	IN Faculty_id INT,
	IN Offset INT
)
BEGIN

	IF Is_Faculty_Member(User_id, Faculty_id) = 0 THEN
		SELECT 'Not Faculty Member';
	
	ELSE
		IF Is_Academic_Year_Member(User_id, Academic_Year_id) = 0 THEN
			SELECT 'Not Academic Year Member';
	
		ELSE
			IF Is_Class_Member(User_id, Class_id) = 0 THEN
				SELECT 'Not Class Member';
			
			ELSE
				SELECT
					'Class_Announcement',
					Class_Announcements.id,
					Class_Announcements.Class_id,
					Class_Announcements.Title,
					Class_Announcements.Instructions,
					Class_Announcements.File,
					Class_Announcements.Created_At,
					User.id,
					User.Image,
					User.First_Name,
					User.Last_Name
					FROM
						Class_Announcements, User
					WHERE
						Class_Announcements.Creator_id = User.id AND
						Class_Announcements.Class_id = Class_id
					ORDER BY
						Class_Announcements.id DESC
					LIMIT 
						Offset, 3;

			END IF;
		END IF;
	END IF;

END //
DELIMITER ;



/**___________________________________________CLASS________________________________________________*/




DROP PROCEDURE IF EXISTS `Get_Academic_Year_in_Class_Announcements`;
DELIMITER //
CREATE PROCEDURE `Get_Academic_Year_in_Class_Announcements`(
	IN User_id INT,
	IN Class_id INT,
	IN Academic_Year_id INT,
	IN Faculty_id INT,
	IN Offset INT
)
BEGIN

	IF Is_Faculty_Member(User_id, Faculty_id) = 0 THEN
		SELECT 'Not Faculty Member';
	
	ELSE
		IF Is_Academic_Year_Member(User_id, Academic_Year_id) = 0 THEN
			SELECT 'Not Academic Year Member';
	
		ELSE
			IF Is_Class_Member(User_id, Class_id) = 0 THEN
				SELECT 'Not Class Member';
			
			ELSE
				SELECT
					'Academic_Year_Announcement',
					Academic_Year_Announcements.id,
					Academic_Year_Announcements.Academic_Year_id,
					Academic_Year_Announcements.Title,
					Academic_Year_Announcements.Instructions,
					Academic_Year_Announcements.File,
					Academic_Year_Announcements.Created_At,
					User.id,
					User.Image,
					User.First_Name,
					User.Last_Name
					FROM
						Academic_Year_Announcements, User
					WHERE
						Academic_Year_Announcements.Creator_id = User.id AND
						Academic_Year_Announcements.Academic_Year_id = Academic_Year_id
					ORDER BY
						Academic_Year_Announcements.id DESC
					LIMIT 
						Offset, 2;

			END IF;
		END IF;
	END IF;

END //
DELIMITER ;




/**___________________________________________CLASS________________________________________________*/





DROP PROCEDURE IF EXISTS `Get_Faculty_in_Class_Announcements`;
DELIMITER //
CREATE PROCEDURE `Get_Faculty_in_Class_Announcements`(
	IN User_id INT,
	IN Class_id INT,
	IN Academic_Year_id INT,
	IN Faculty_id INT,
	IN Offset INT
)
BEGIN

	IF Is_Faculty_Member(User_id, Faculty_id) = 0 THEN
		SELECT 'Not Faculty Member';
	
	ELSE
		IF Is_Academic_Year_Member(User_id, Academic_Year_id) = 0 THEN
			SELECT 'Not Academic Year Member';
	
		ELSE
			IF Is_Class_Member(User_id, CLass_id) = 0 THEN
				SELECT 'Not Class Member';
			
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
						Offset, 1;

			END IF;
		END IF;
	END IF;

END //
DELIMITER ;

