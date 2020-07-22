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
	Table : Academic_Year
	index no : 2
	Length : 39
	Columns : [Faculty_id, JoinCode]
	Trigger index Search on Columns : (Faculty_id), (Faculty_id, JoinCode)
*/
--DROP INDEX IF EXISTS `Academic_Year__Faculty_id-JoinCode__idx`;
--CREATE INDEX `Academic_Year__Faculty_id-JoinCode__idx` ON Academic_Year(Faculty_id, JoinCode);


/*
	Table : Academic_Year
	index no : 3
	Length : 33
	Columns : [id, Creator_id]
	Trigger index Search on Columns : (id), (id, Creator_id)
*/
--DROP INDEX IF EXISTS `Academic_Year__id-Creator_id__idx`;
--CREATE INDEX `Academic_Year__id-Creator_id__idx` ON Academic_Year(id, Creator_id);



/**___________________________________________INDEX_________________________________________________*/


/*
	Table : Academic_Year_Members
	index no : 2
	Length : 61
	Columns : [User_id, Academic_Year_id, Position]
	Trigger index Search on Columns : (User_id), (User_id, Academic_Year_id), (User_id, Academic_Year_id, Position)
*/
--DROP INDEX IF EXISTS `Academic_Year_Members__User_id-Academic_Year_id-Position__idx`;
/*CREATE INDEX `Academic_Year_Members__User_id-Academic_Year_id-Position__idx` ON Academic_Year_Members(
	User_id, Academic_Year_id, Position
);*/



/**___________________________________________INDEX_________________________________________________*/


/*
	Table : Academic_Year_Posts
	index no : 2
	Length : 56
	Columns : [id, Academic_Year_id, Creator_id]
	Trigger index Search on Columns : (id), (id, Academic_Year_id), (id, Academic_Year_id, Creator_id)
*/
--DROP INDEX IF EXISTS `Academic_Year_Posts__id-Academic_Year_id-Creator_id__idx`;
/*CREATE INDEX `Academic_Year_Posts__id-Academic_Year_id-Creator_id__idx` ON Academic_Year_Posts(
	id, Academic_Year_id, Creator_id
);


/*
	Table : Academic_Year_Posts
	index no : 3
	Length : 53
	Columns : [Academic_Year_id, Creator_id]
	Trigger index Search on Columns : (Academic_Year_id), (Academic_Year_id, Creator_id)
*/
--DROP INDEX IF EXISTS `Academic_Year_Posts__Academic_Year_id-Creator_id__idx`;
/*CREATE INDEX `Academic_Year_Posts__Academic_Year_id-Creator_id__idx` ON Academic_Year_Posts(
	Academic_Year_id, Creator_id
);



/**___________________________________________INDEX_________________________________________________*/



/*
	Table : Academic_Year_Comments
	index no : 2
	Length : 39
	Columns : [Post_id, id]
	Trigger index Search on Columns : (Post_id), (Post_id, id)
*/
--DROP INDEX IF EXISTS `Academic_Year_Comments__Post_id-id__idx`;
--CREATE INDEX `Academic_Year_Comments__Post_id-id__idx` ON Academic_Year_Comments(Post_id, id);



/*
	Table : Academic_Year_Comments
	index no : 3
	Length : 42
	Columns : [id, Creator_id]
	Trigger index Search on Columns : (id), (id, Creator_id)
*/
--DROP INDEX IF EXISTS `Academic_Year_Comments__id-Creator_id__idx`;
--CREATE INDEX `Academic_Year_Comments__id-Creator_id__idx` ON Academic_Year_Comments(id, Creator_id);























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


DROP FUNCTION IF EXISTS `Is_Academic_Year_JoinCode_Exists`;
DELIMITER //
CREATE FUNCTION `Is_Academic_Year_JoinCode_Exists`(
	Faculty_id INT,
	JoinCode VARCHAR(6)
)
RETURNS INT
BEGIN
	
	RETURN (SELECT EXISTS( 
		SELECT 1 FROM Academic_Year 
			WHERE 
				Academic_Year.JoinCode = JoinCode AND
				Academic_Year.Faculty_id = Faculty_id
			LIMIT 1
	));

END //
DELIMITER ;



/**________________________________________ACADEMIC_YEAR___________________________________________*/




DROP FUNCTION IF EXISTS `Get_Academic_Year_id`;
DELIMITER //
CREATE FUNCTION `Get_Academic_Year_id`(
	Faculty_id INT,
	JoinCode VARCHAR(6)
)
RETURNS INT
BEGIN
	
	RETURN (
		SELECT Academic_Year.id FROM Academic_Year
			WHERE
				Academic_Year.JoinCode = JoinCode AND
				Academic_Year.Faculty_id = Faculty_id
			LIMIT 1
	);

END //
DELIMITER ;



/**________________________________________ACADEMIC_YEAR___________________________________________*/




DROP FUNCTION IF EXISTS `Is_Academic_Year_Member`;
DELIMITER //
CREATE FUNCTION `Is_Academic_Year_Member`(
	User_id INT,
	Academic_Year_id INT
)
RETURNS INT
BEGIN
	
	RETURN (SELECT EXISTS( 
		SELECT 1 FROM Academic_Year_Members 
			WHERE 
				Academic_Year_Members.User_id = User_id AND
				Academic_Year_Members.Academic_Year_id = Academic_Year_id
			LIMIT 1
	));

END //
DELIMITER ;



/**________________________________________ACADEMIC_YEAR___________________________________________*/



DROP FUNCTION IF EXISTS `Is_Academic_Year_Post`;
DELIMITER //
CREATE FUNCTION `Is_Academic_Year_Post`(
	Post_id INT
)
RETURNS INT
BEGIN
	
	RETURN (SELECT EXISTS( SELECT 1 FROM Academic_Year_Posts WHERE Academic_Year_Posts.id = Post_id LIMIT 1 ));

END //
DELIMITER ;




/**________________________________________ACADEMIC_YEAR___________________________________________*/




DROP FUNCTION IF EXISTS `Is_Academic_Year_Post_Creator`;
DELIMITER //
CREATE FUNCTION `Is_Academic_Year_Post_Creator`(
	User_id INT,
	Post_id INT,
	Academic_Year_id INT
)
RETURNS INT
BEGIN
	
	RETURN (SELECT EXISTS(
		SELECT 1 FROM Academic_Year_Posts
			WHERE
				Academic_Year_Posts.id = Post_id AND
				Academic_Year_Posts.Academic_Year_id = Academic_Year_id AND
				Academic_Year_Posts.Creator_id = User_id
			LIMIT 1 
	));

END //
DELIMITER ;



/**________________________________________ACADEMIC_YEAR___________________________________________*/



DROP FUNCTION IF EXISTS `Is_Post_in_Academic_Year`;
DELIMITER //
CREATE FUNCTION `Is_Post_in_Academic_Year`(
	Post_id INT,
	Academic_Year_id INT
)
RETURNS INT
BEGIN

	RETURN (SELECT EXISTS(
		SELECT 1 FROM Academic_Year_Posts
			WHERE
				Academic_Year_Posts.id = Post_id AND
				Academic_Year_Posts.Academic_Year_id = Academic_Year_id
			LIMIT 1
	));

END //
DELIMITER ;




/**________________________________________ACADEMIC_YEAR___________________________________________*/





DROP FUNCTION IF EXISTS `Is_Comment_In_Academic_Year_Post`;
DELIMITER //
CREATE FUNCTION `Is_Comment_In_Academic_Year_Post`(
	Comment_id INT,
	Post_id INT
)
RETURNS INT
BEGIN

	RETURN (SELECT EXISTS(
		SELECT 1 FROM Academic_Year_Comments
			WHERE
				Academic_Year_Comments.id = Comment_id AND
				Academic_Year_Comments.Post_id = Post_id
			LIMIT 1
	));

END //
DELIMITER ;




/**________________________________________ACADEMIC_YEAR___________________________________________*/





DROP FUNCTION IF EXISTS `Is_Academic_Year_Comment_Creator`;
DELIMITER //
CREATE FUNCTION `Is_Academic_Year_Comment_Creator`(
	User_id INT,
	Comment_id INT
)
RETURNS INT
BEGIN
	
	RETURN (SELECT EXISTS(
		SELECT 1 FROM Academic_Year_Comments
			WHERE
				Academic_Year_Comments.id = Comment_id AND
				Academic_Year_Comments.Creator_id = User_id
			LIMIT 1 
	));

END //
DELIMITER ;




/**________________________________________ACADEMIC_YEAR___________________________________________*/




DROP FUNCTION IF EXISTS `Is_Academic_Year_Admin`;
DELIMITER //
CREATE FUNCTION `Is_Academic_Year_Admin`(
	Admin_id INT,
	Academic_Year_id INT
)
RETURNS INT
BEGIN
	
	RETURN (SELECT EXISTS( 
		SELECT 1 FROM Academic_Year_Members 
			WHERE 
				Academic_Year_Members.User_id = Admin_id AND
				Academic_Year_Members.Academic_Year_id = Academic_Year_id AND
				Academic_Year_Members.Position = 'Admin'
			LIMIT 1
	));

END //
DELIMITER ;




/**________________________________________ACADEMIC_YEAR___________________________________________*/




DROP FUNCTION IF EXISTS `Is_Academic_Year_Creator`;
DELIMITER //
CREATE FUNCTION `Is_Academic_Year_Creator`(
	Creator_id INT,
	Academic_Year_id INT
)
RETURNS INT
BEGIN
	
	RETURN (SELECT EXISTS(
		SELECT 1 FROM Academic_Year
			WHERE
				Academic_Year.id = Academic_Year_id AND
				Academic_Year.Creator_id = Creator_id
			LIMIT 1
	));

END //
DELIMITER ;



/**__________________________________________FACULTY_______________________________________________*/




DROP FUNCTION IF EXISTS `Is_Academic_Year_Staff_Or_Teacher`;
DELIMITER //
CREATE FUNCTION `Is_Academic_Year_Staff_Or_Teacher`(
	User_id INT,
	Academic_Year_id INT
)
RETURNS INT
BEGIN
	
	RETURN (SELECT EXISTS(
		SELECT 1 FROM User WHERE User.I_AM != 'Student' AND User.Status = 'Approved' AND User.id = User_id LIMIT 1
	));

END //
DELIMITER ;




/**__________________________________________FACULTY_______________________________________________*/




DROP FUNCTION IF EXISTS `Is_Academic_Year_Announcement`;
DELIMITER //
CREATE FUNCTION `Is_Academic_Year_Announcement`(
	Announcement_id INT,
	Academic_Year_id INT
)
RETURNS INT
BEGIN
	
	RETURN (SELECT EXISTS(
		SELECT 1 FROM Academic_Year_Announcements
			WHERE
				Academic_Year_Announcements.id = Announcement_id AND
				Academic_Year_Announcements.Academic_Year_id = Academic_Year_id
			LIMIT 1
	));

END //
DELIMITER ;




/**__________________________________________FACULTY_______________________________________________*/




DROP FUNCTION IF EXISTS `Is_Academic_Year_Announcement_Creator`;
DELIMITER //
CREATE FUNCTION `Is_Academic_Year_Announcement_Creator`(
	User_id INT,
	Announcement_id INT
)
RETURNS INT
BEGIN
	
	RETURN (SELECT EXISTS(
		SELECT 1 FROM Academic_Year_Announcements
			WHERE
				Academic_Year_Announcements.id = Announcement_id AND
				Academic_Year_Announcements.Creator_id = User_id
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

DROP PROCEDURE IF EXISTS `Is_Academic_Year_JoinCode_Registered`;
DELIMITER //
CREATE PROCEDURE `Is_Academic_Year_JoinCode_Registered`(
	IN Faculty_id INT,
	IN JoinCode VARCHAR(6)
)
BEGIN
	
	SELECT Is_Academic_Year_JoinCode_Exists(Faculty_id, JoinCode) AS `Result`;

END //
DELIMITER ;



/**________________________________________ACADEMIC_YEAR___________________________________________*/



DROP PROCEDURE IF EXISTS `Create_Academic_Year`;
DELIMITER //
CREATE PROCEDURE `Create_Academic_Year`(
	IN Faculty_id INT,
	IN Creator_id INT,
	IN Name VARCHAR(100),
	IN JoinCode VARCHAR(6),
	IN Descreption VARCHAR(1000),
	IN Image VARCHAR(100)
)
BEGIN
	
	IF Is_Academic_Year_JoinCode_Exists(Faculty_id, JoinCode) = 1 THEN
		SELECT 'Join Code Found';

	ELSE

		IF Is_Faculty_Admin(Creator_id, Faculty_id) = 0 THEN
			SELECT 'Do Not Have Permision';

		ELSE
			START TRANSACTION;

				INSERT INTO Academic_Year(Name, JoinCode, Creator_id, Faculty_id, Descreption, Image)
					VALUES (Name, JoinCode, Creator_id, Faculty_id, Descreption, Image);
			
				SET @Academic_Year_id = Get_Academic_Year_id(Faculty_id, JoinCode);

				INSERT INTO Academic_Year_Members(User_id, Academic_Year_id, Position)
					VALUES (Creator_id, @Academic_Year_id, 'Admin');

				SELECT 'Created', @Academic_Year_id;
			
			COMMIT;

		END IF;

	END IF;

END //
DELIMITER ;



/**________________________________________ACADEMIC_YEAR___________________________________________*/



DROP PROCEDURE IF EXISTS `Join_Academic_Year`;
DELIMITER //
CREATE PROCEDURE `Join_Academic_Year`(
	IN User_id INT,
	IN Faculty_id INT,
	IN User_JoinCode VARCHAR(6)
)
BEGIN

	SET @Academic_Year_id = Get_Academic_Year_id(Faculty_id, User_JoinCode);

	IF @Academic_Year_id IS NULL THEN
		SELECT 'Academic Year Not Found';

	ELSE
		IF Is_Faculty_Member(User_id, Faculty_id) = 0 THEN
			SELECT 'Not Faculty Member';

		ELSE
			IF Is_Academic_Year_Member(User_id, @Academic_Year_id) = 1 THEN
				SELECT 'Already Member';

			ELSE
				INSERT INTO Academic_Year_Members(User_id, Academic_Year_id, Position)
						VALUES (User_id, @Academic_Year_id, 'Member');

				SELECT 'Joined', @Academic_Year_id;
			END IF;

		END IF;
	
	END IF;

END //
DELIMITER ;



/**________________________________________ACADEMIC_YEAR___________________________________________*/



DROP PROCEDURE IF EXISTS `Show_All_Academic_Years`;
DELIMITER //
CREATE PROCEDURE `Show_All_Academic_Years`(
	IN User_id INT,
	IN Faculty_id INT
)
BEGIN
	
	IF Is_Faculty_Member(User_id, Faculty_id) = 0 THEN
		SELECT 'Not Faculty Member' AS `Result`;

	ELSE
		SELECT
			Academic_Year.id,
			Academic_Year.Name,
			Academic_Year.Descreption
			FROM Academic_Year WHERE Academic_Year.Faculty_id = Faculty_id;
	END IF;

END //
DELIMITER ;



/**________________________________________ACADEMIC_YEAR___________________________________________*/



DROP PROCEDURE IF EXISTS `Make_Academic_Year_Post`;
DELIMITER //
CREATE PROCEDURE `Make_Academic_Year_Post`(
	IN User_id INT,
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
			INSERT INTO Academic_Year_Posts(Academic_Year_id, Creator_id, Post, Files)
				VALUES (Academic_Year_id, User_id, Post, Files);

			SELECT
				'Created',
				Academic_Year_Posts.id,
				Academic_Year_Posts.Academic_Year_id,
				Academic_Year_Posts.Creator_id,
				Academic_Year_Posts.Post,
				Academic_Year_Posts.Files,
				Academic_Year_Posts.Created_At
				FROM
					Academic_Year_Posts
				WHERE
					Academic_Year_Posts.id = LAST_INSERT_ID()
				LIMIT 1;

		END IF;
	END IF;

END //
DELIMITER ;



/**________________________________________ACADEMIC_YEAR___________________________________________*/



DROP PROCEDURE IF EXISTS `Edit_Academic_Year_Post`;
DELIMITER //
CREATE PROCEDURE `Edit_Academic_Year_Post`(
	IN User_id INT,
	IN Post_id INT,
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
			IF IS_Academic_Year_Post_Creator(User_id, Post_id, Academic_Year_id) = 0 THEN
				SELECT 'Not Post Creator';
			
			ELSE
				UPDATE Academic_Year_Posts
					SET
						Academic_Year_Posts.Post = Post
					WHERE
						Academic_Year_Posts.id = Post_id
					LIMIT 1;

				SELECT 'Edited';
			
			END IF;
		END IF;
	END IF;

END //
DELIMITER ;



/**________________________________________ACADEMIC_YEAR___________________________________________*/



DROP PROCEDURE IF EXISTS `Delete_Academic_Year_Post`;
DELIMITER //
CREATE PROCEDURE `Delete_Academic_Year_Post`(
	IN User_id INT,
	IN Post_id INT,
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
			IF Is_Academic_Year_Post_Creator(User_id, Post_id, Academic_Year_id) = 0 THEN
				SELECT 'Not Post Creator';
			
			ELSE
				DELETE FROM Academic_Year_Posts WHERE Academic_Year_Posts.id = Post_id LIMIT 1;
				SELECT 'Deleted';
			
			END IF;
		END IF;
	END IF;

END //
DELIMITER ;



/**________________________________________ACADEMIC_YEAR___________________________________________*/



DROP PROCEDURE IF EXISTS `Make_Academic_Year_Comment`;
DELIMITER //
CREATE PROCEDURE `Make_Academic_Year_Comment`(
	IN User_id INT,
	IN Post_id INT,
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
			IF Is_Post_in_Academic_Year(Post_id, Academic_Year_id) = 0 THEN
				SELECT 'Post Not Found';

			ELSE
				INSERT INTO Academic_Year_Comments(Creator_id, Post_id, Comment) VALUES(User_id, Post_id, Comment);
				SELECT
					'Created',
					Academic_Year_Comments.id,
					Academic_Year_Comments.Creator_id,
					Academic_Year_Comments.Post_id,
					Academic_Year_Comments.Comment,
					Academic_Year_Comments.Created_At
					FROM 
						Academic_Year_Comments
					WHERE
						Academic_Year_Comments.id = LAST_INSERT_ID()
					LIMIT 1;

			END IF;
		END IF;
	END IF;

END //
DELIMITER ;



/**________________________________________ACADEMIC_YEAR___________________________________________*/



DROP PROCEDURE IF EXISTS `Edit_Academic_Year_Comment`;
DELIMITER //
CREATE PROCEDURE `Edit_Academic_Year_Comment`(
	IN User_id INT,
	IN Comment_id INT,
	IN Post_id INT,
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
			IF Is_Post_in_Academic_Year(Post_id, Academic_Year_id) = 0 THEN
				SELECT 'Not Academic Year Post';
			
			ELSE
				IF Is_Comment_In_Academic_Year_Post(Comment_id, Post_id) = 0 THEN
					SELECT 'Not Academic Year Comment';
				
				ELSE
					IF Is_Academic_Year_Comment_Creator(User_id, Comment_id) = 0 THEN
						SELECT 'Not Comment Creator';
					
					ELSE
						UPDATE Academic_Year_Comments
							SET
								Academic_Year_Comments.Comment = New_Comment
							WHERE
								Academic_Year_Comments.id = Comment_id
							LIMIT 1;

						SELECT 'Edited';

					END IF;
				END IF;
			END IF;
		END IF;
	END IF;

END //
DELIMITER ;



/**________________________________________ACADEMIC_YEAR___________________________________________*/




DROP PROCEDURE IF EXISTS `Delete_Academic_Year_Comment`;
DELIMITER //
CREATE PROCEDURE `Delete_Academic_Year_Comment`(
	IN User_id INT,
	IN Comment_id INT,
	IN Post_id INT,
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
			IF Is_Comment_In_Academic_Year_Post(Comment_id, Post_id) = 0 THEN
				SELECT 'Not Academic Year Comment';
			
			ELSE
				IF Is_Academic_Year_Comment_Creator(Comment_id, User_id) = 0 THEN
					SELECT 'Not Comment Creator';
				
				ELSE
					DELETE FROM Academic_Year_Comments WHERE Academic_Year_Comments.id = Comment_id LIMIT 1;
					SELECT 'Deleted';

				END IF;
			END IF;
		END IF;
	END IF;

END //
DELIMITER ;



/**________________________________________ACADEMIC_YEAR___________________________________________*/



DROP PROCEDURE IF EXISTS `Get_Academic_Year_Post_Comments`;
DELIMITER //
CREATE PROCEDURE `Get_Academic_Year_Post_Comments`(
	IN User_id INT,
	IN Post_id INT,
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
			IF Is_Post_in_Academic_Year(Post_id, Academic_Year_id) = 0 THEN
				SELECT 'Not Academic Year Post';
			
			ELSE
				SELECT
					'Comments',
					Academic_Year_Comments.id,
					Academic_Year_Comments.Creator_id,
					Academic_Year_Comments.Post_id,
					Academic_Year_Comments.Comment,
					Academic_Year_Comments.Created_At,
					User.id,
					User.First_Name,
					User.Last_Name,
					User.Image 
					FROM 
						Academic_Year_Comments, User
					WHERE
						Academic_Year_Comments.Post_id = Post_id AND
						User.id = Academic_Year_Comments.Creator_id
					ORDER BY
						Academic_Year_Comments.id DESC
					LIMIT 10
					OFFSET Offset;
			
			END IF;
		END IF;
	END IF;

END //
DELIMITER ;



/**________________________________________ACADEMIC_YEAR___________________________________________*/



DROP PROCEDURE IF EXISTS `Show_Academic_Year`;
DELIMITER //
CREATE PROCEDURE `Show_Academic_Year`(
	IN User_id INT,
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
			SELECT
				'Posts',
				Academic_Year_Posts.id,
				Academic_Year_Posts.Academic_Year_id,
				Academic_Year_Posts.Creator_id,
				Academic_Year_Posts.Post,
				Academic_Year_Posts.Files,
				Academic_Year_Posts.Created_At,
				User.id,
				User.Image,
				User.First_Name,
				User.Last_Name
				FROM
					Academic_Year_Posts, User
				WHERE
					Academic_Year_Posts.Academic_Year_id = Academic_Year_id AND
					Academic_Year_Posts.Creator_id = User.id
				ORDER BY
					Academic_Year_Posts.id DESC
				LIMIT
					Offset, 5;

		END IF;
	END IF;

END //
DELIMITER ;



/**________________________________________ACADEMIC_YEAR___________________________________________*/



DROP PROCEDURE IF EXISTS `Show_Academic_Year_Settings`;
DELIMITER //
CREATE PROCEDURE `Show_Academic_Year_Settings`(
	IN Admin_id INT,
	IN Academic_Year_id INT,
	IN Faculty_id INT
)
BEGIN
	
	IF Is_Faculty_Member(Admin_id, Faculty_id) = 0 THEN
		SELECT 'Not Faculty Member';
	
	ELSE
		IF Is_Academic_Year_Admin(Admin_id, Academic_Year_id) = 0 THEN
			SELECT 'Not Admin';

		ELSE
			SELECT 
				'Settings',
				Academic_Year.id,
				Academic_Year.Name,
				Academic_Year.JoinCode,
				Academic_Year.Descreption,
				Academic_Year.Image,
				Academic_Year.Created_At,
				User.id,
				User.First_Name,
				User.Last_Name,
				User.Image
				FROM 
					Academic_Year, User 
				WHERE
					Academic_Year.id = Academic_Year_id AND
					Academic_Year.Creator_id = User.id 
				LIMIT 1;

		END IF;
	END IF;
END //
DELIMITER ;



/**________________________________________ACADEMIC_YEAR___________________________________________*/



DROP PROCEDURE IF EXISTS `Edit_Academic_Year_Settings`;
DELIMITER //
CREATE PROCEDURE `Edit_Academic_Year_Settings`(
	IN Admin_id INT,
	IN Academic_Year_id INT,
	IN Faculty_id INT,
	IN Name VARCHAR(100),
	IN Descreption VARCHAR(1000)
)
BEGIN

	IF Is_Faculty_Member(Admin_id, Faculty_id) = 0 THEN
		SELECT 'Not Faculty Member';
	
	ELSE
		IF Is_Academic_Year_Admin(Admin_id, Academic_Year_id) = 0 THEN
			SELECT 'Not Admin';

		ELSE
			UPDATE Academic_Year
				SET
					Academic_Year.Name = Name,
					Academic_Year.Descreption = Descreption
				WHERE 
					Academic_Year.id = Academic_Year_id
				LIMIT 1;

			SELECT 'Edited';

		END IF;
	END IF;

END //
DELIMITER ;



/**________________________________________ACADEMIC_YEAR___________________________________________*/


/*

DROP PROCEDURE IF EXISTS `Delete_Academic_Year`;
DELIMITER //
CREATE PROCEDURE `Delete_Academic_Year`(
	IN Admin_id INT,
	IN Academic_Year_id INT
)
BEGIN

	IF Is_Academic_Year_Creator(Admin_id, Academic_Year_id) = 0 THEN
		SELECT 'Do Not Have Permision' AS `Result`;

	ELSE
		START TRANSACTION;

			/** Academic Years */
			/*DELETE FROM Academic_Year_Comments WHERE Academic_Year_Comments.Post_id IN (
				SELECT Academic_Year_Posts.id FROM Academic_Year_Posts
					WHERE Academic_Year_Posts.Academic_Year_id = Academic_Year_id
			);
			DELETE FROM Academic_Year_Posts WHERE Academic_Year_Posts.Academic_Year_id = Academic_Year_id;
			DELETE FROM Academic_Year_Members WHERE Academic_Year_Members.Academic_Year_id = Academic_Year_id;



			/** Class */
			/*DELETE FROM Class_Comments WHERE Class_Comments.Post_id IN (
				SELECT Class_Posts.id FROM Class_Posts WHERE Class_Posts.Class_id IN (
					SELECT Class.id FROM Class WHERE Class.Academic_Year_id = Academic_Year_id
				)
			);
			DELETE FROM Class_Posts WHERE Class_Posts.Class_id IN(
				SELECT Class.id FROM Class WHERE Class.Academic_Year_id = Academic_Year_id
			);
			DELETE FROM Class_Members WHERE Class_Members.Class_id IN (
				SELECT Class.id FROM Class WHERE Class.Academic_Year_id = Academic_Year_id
			);
			DELETE FROM Class WHERE Class.Academic_Year_id = Academic_Year_id;



			DELETE FROM Academic_Year WHERE Academic_Year.id = Academic_Year_id LIMIT 1;
			SELECT 'Done' AS `Result`;
		
		COMMIT;
	END IF;

END //
DELIMITER ;



/**________________________________________ACADEMIC_YEAR___________________________________________*/



DROP PROCEDURE IF EXISTS `Show_Academic_Year_Members`;
DELIMITER //
CREATE PROCEDURE `Show_Academic_Year_Members`(
	IN User_id INT,
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
			SELECT
				'Member',
				Academic_Year_Members.id,
				Academic_Year_Members.Academic_Year_id,
				Academic_Year_Members.User_id,
				Academic_Year_Members.Role,
				Academic_Year_Members.Position,
				Academic_Year_Members.Joined_At,
				User.Image,
				User.First_Name,
				User.Last_Name
				FROM 
					Academic_Year_Members, User 
				WHERE
					Academic_Year_Members.User_id = User.id AND
					Academic_Year_Members.Academic_Year_id = Academic_Year_id
				LIMIT
					Offset, 15;
	
		END IF;
	END IF;

END //
DELIMITER ;



/**________________________________________ACADEMIC_YEAR___________________________________________*/



DROP PROCEDURE IF EXISTS `Kick_Academic_Year_Member`;
DELIMITER //
CREATE PROCEDURE `Kick_Academic_Year_Member`(
	IN Admin_id INT,
	IN Faculty_id INT,
	IN Academic_Year_id INT,
	IN User_id INT
)
BEGIN

	IF Is_Faculty_Member(Admin_id, Faculty_id) = 0 THEN
		SELECT 'Not Faculty Member';
	
	ELSE
		IF Is_Academic_Year_Admin(Admin_id, Academic_Year_id) = 0 THEN
			SELECT 'Do Not Have Permision';

		ELSE
			IF Is_Academic_Year_Creator(User_id, Academic_Year_id) = 1 THEN
				SELECT 'Can Not Kick Out Creator';
			
			ELSE
				DELETE FROM Academic_Year_Members
					WHERE
						Academic_Year_Members.User_id = User_id AND
						Academic_Year_Members.Academic_Year_id = Academic_Year_id
					LIMIT 1;
				SELECT 'Kicked';

			END IF;
		END IF;
	END IF;
END //
DELIMITER ;



/**________________________________________ACADEMIC_YEAR___________________________________________*/



DROP PROCEDURE IF EXISTS `Leave_Academic_Year`;
DELIMITER //
CREATE PROCEDURE `Leave_Academic_Year`(
	IN User_id INT,
	IN Academic_Year_id INT
)
BEGIN
	
	IF Is_Academic_Year_Creator(User_id, Academic_Year_id) = 1 THEN
		SELECT 'Creator Can Not Leave';
	
	ELSE
		DELETE FROM Academic_Year_Members
			WHERE
				Academic_Year_Members.User_id = User_id AND
				Academic_Year_Members.Academic_Year_id = Academic_Year_id
			LIMIT 1;
		SELECT 'Leaved';
	
	END IF;

END //
DELIMITER ;



/**________________________________________ACADEMIC_YEAR___________________________________________*/



DROP PROCEDURE IF EXISTS `Make_Academic_Year_Announcement`;
DELIMITER //
CREATE PROCEDURE `Make_Academic_Year_Announcement`(
	IN User_id INT,
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
			IF Is_Academic_Year_Staff_Or_Teacher(User_id, Academic_Year_id) = 0 THEN
				SELECT 'Not Staff Member Or Teacher';
			
			ELSE
				INSERT INTO Academic_Year_Announcements(Title, Instructions, File, Academic_Year_id, Creator_id)
					VALUES(Title, Instructions, File, Academic_Year_id, User_id);
				
				SELECT
					'Created',
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
						Academic_Year_Announcements.id = LAST_INSERT_ID() AND
						Academic_Year_Announcements.Creator_id = User.id
					LIMIT 1;

			END IF;	
		END IF;
	END IF;

END //
DELIMITER ;



/**__________________________________________FACULTY_______________________________________________*/



DROP PROCEDURE IF EXISTS `Edit_Academic_Year_Announcement`;
DELIMITER //
CREATE PROCEDURE `Edit_Academic_Year_Announcement`(
	IN User_id INT,
	IN Announcement_id INT,
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
			IF Is_Academic_Year_Announcement(Announcement_id, Academic_Year_id) = 0 THEN
				SELECT 'Not Academic Year Announcement';
			
			ELSE
				IF Is_Academic_Year_Announcement_Creator(User_id, Announcement_id) = 0 THEN
					SELECT 'Not Announcement Creator';
				
				ELSE
					UPDATE Academic_Year_Announcements
						SET
							Academic_Year_Announcements.Title = Title,
							Academic_Year_Announcements.Instructions = Instructions
						WHERE
							Academic_Year_Announcements.id = Announcement_id
						LIMIT 1;

					SELECT 'Edited';

				END IF;
			END IF;
		END IF;
	END IF;

END //
DELIMITER ;



/**__________________________________________FACULTY_______________________________________________*/




DROP PROCEDURE IF EXISTS `Delete_Academic_Year_Announcement`;
DELIMITER //
CREATE PROCEDURE `Delete_Academic_Year_Announcement`(
	IN User_id INT,
	IN Announcement_id INT,
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
			IF Is_Academic_Year_Announcement(Announcement_id, Academic_Year_id) = 0 THEN
				SELECT 'Not Academic Year Announcement';
			
			ELSE
				IF Is_Academic_Year_Announcement_Creator(User_id, Announcement_id) = 0 THEN
					SELECT 'Not Announcement Creator';
				
				ELSE
					DELETE FROM Academic_Year_Announcements
						WHERE
							Academic_Year_Announcements.id = Announcement_id
						LIMIT 1;
					SELECT 'Deleted';

				END IF;
			END IF;
		END IF;
	END IF;

END //
DELIMITER ;



/**__________________________________________FACULTY_______________________________________________*/




DROP PROCEDURE IF EXISTS `Get_Academic_Year_Announcements`;
DELIMITER //
CREATE PROCEDURE `Get_Academic_Year_Announcements`(
	IN User_id INT,
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
					Offset, 3;
		
		END IF;
	END IF;

END //
DELIMITER ;



/**__________________________________________FACULTY_______________________________________________*/




DROP PROCEDURE IF EXISTS `Get_Faculty_in_Academic_Year_Announcements`;
DELIMITER //
CREATE PROCEDURE `Get_Faculty_in_Academic_Year_Announcements`(
	IN User_id INT,
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
					Offset, 2;
		
		END IF;
	END IF;

END //
DELIMITER ;

