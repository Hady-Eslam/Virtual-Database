/**___________________________________________USER_________________________________________________*/
/**___________________________________________USER_________________________________________________*/
/**___________________________________________USER_________________________________________________*/
/**___________________________________________USER_________________________________________________*/



DROP TABLE IF EXISTS `User`;
CREATE TABLE `User`(
	
	`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,

	`Image` VARCHAR(100) NULL,
	`First_Name` VARCHAR(100) NOT NULL,
	`Last_Name` VARCHAR(100) NOT NULL,
	`I_AM` ENUM('Staff', 'Teacher', 'Student') NOT NULL,
	`Email` VARCHAR(100) NOT NULL UNIQUE,
	`Password` VARCHAR(100) NOT NULL,
	`Status` ENUM('Pending', 'Approved') NOT NULL DEFAULT 'Pending',
	`Hash_Code` VARCHAR(100) NOT NULL,
	
	`Created_At` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP

)ENGINE=InnoDB;




/**__________________________________________FACULTY_______________________________________________*/
/**__________________________________________FACULTY_______________________________________________*/
/**__________________________________________FACULTY_______________________________________________*/
/**__________________________________________FACULTY_______________________________________________*/



DROP TABLE IF EXISTS `Faculty`;
CREATE TABLE `Faculty`(

	`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,

	`Creator_id` INT NOT NULL REFERENCES `User`(`id`) ON DELETE CASCADE,
	
	`Name` VARCHAR(100) NOT NULL,
	`JoinCode` VARCHAR(6) NOT NULL UNIQUE,
	`Descreption` VARCHAR(1000) NULL,
	`Image` VARCHAR(100) NULL,

	`Created_At` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP

)ENGINE=InnoDB;



DROP TABLE IF EXISTS `Faculty_Members`;
CREATE TABLE `Faculty_Members`(

	`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,

	`User_id` INT NOT NULL REFERENCES `User`(`id`) ON DELETE CASCADE,
	`Faculty_id` INT NOT NULL REFERENCES `Faculty`(`id`) ON DELETE CASCADE,
	
	`Role` ENUM('Student', 'Teacher', 'Staff') NULL,
	`Position` ENUM('Admin', 'Member') NULL,
	
	`Joined_At` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP

)ENGINE=InnoDB;



DROP TABLE IF EXISTS `Faculty_Posts`;
CREATE TABLE `Faculty_Posts`(

	`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,

	`Creator_id` INT NOT NULL REFERENCES `User`(`id`) ON DELETE CASCADE,
	`Faculty_id` INT NOT NULL REFERENCES `Faculty`(`id`) ON DELETE CASCADE,
	
	`Post` TEXT NOT NULL,
	`Files` TEXT NULL,
	
	`Created_At` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP

)ENGINE=InnoDB;



DROP TABLE IF EXISTS `Faculty_Comments`;
CREATE TABLE `Faculty_Comments`(

	`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,

	`Creator_id` INT NOT NULL REFERENCES `User`(`id`) ON DELETE CASCADE,
	`Post_id` INT NOT NULL REFERENCES `Faculty_Posts`(`id`) ON DELETE CASCADE,
	
	`Comment` VARCHAR(2000) NOT NULL,
	
	`Created_At` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP

)ENGINE=InnoDB;



DROP TABLE IF EXISTS `Faculty_Announcements`;
CREATE TABLE `Faculty_Announcements`(

	`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,

	`Creator_id` INT NOT NULL REFERENCES `User`(`id`) ON DELETE CASCADE,
	`Faculty_id` INT NOT NULL REFERENCES `Faculty`(`id`) ON DELETE CASCADE,

	`Title` VARCHAR(100) NOT NULL,
	`Instruction` VARCHAR(2000) NOT NULL,
	`File` TEXT NULL,

	`Created_At` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP

)ENGINE=InnoDB;




/**________________________________________ACADEMIC_YEAR___________________________________________*/
/**________________________________________ACADEMIC_YEAR___________________________________________*/
/**________________________________________ACADEMIC_YEAR___________________________________________*/
/**________________________________________ACADEMIC_YEAR___________________________________________*/



DROP TABLE IF EXISTS `Academic_Year`;
CREATE TABLE `Academic_Year`(

	`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,

	`Creator_id` INT NOT NULL REFERENCES `User`(`id`) ON DELETE CASCADE,
	`Faculty_id` INT NOT NULL REFERENCES `Faculty`(`id`) ON DELETE CASCADE,
	
	`Name` VARCHAR(100) NOT NULL,
	`JoinCode` VARCHAR(6) NOT NULL UNIQUE,
	`Descreption` VARCHAR(1000) NULL,
	`Image` VARCHAR(100) NULL,
	
	`Created_At` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP

)ENGINE=InnoDB;



DROP TABLE IF EXISTS `Academic_Year_Members`;
CREATE TABLE `Academic_Year_Members`(

	`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,

	`User_id` INT NOT NULL REFERENCES `User`(`id`) ON DELETE CASCADE,
	`Academic_Year_id` INT NOT NULL REFERENCES `Academic_Year`(`id`) ON DELETE CASCADE,
	
	`Role` ENUM('Student', 'Teacher') NULL,
	`Position` ENUM('Admin', 'Member') NULL,
	
	`Joined_At` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP

)ENGINE=InnoDB;



DROP TABLE IF EXISTS `Academic_Year_Posts`;
CREATE TABLE `Academic_Year_Posts`(

	`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,

	`Creator_id` INT NOT NULL REFERENCES `User`(`id`) ON DELETE CASCADE,
	`Academic_Year_id` INT NOT NULL REFERENCES `Academic_Year`(`id`) ON DELETE CASCADE,
	
	`Post` TEXT NOT NULL,
	`Files` TEXT NULL,
	
	`Created_At` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP

)ENGINE=InnoDB;



DROP TABLE IF EXISTS `Academic_Year_Comments`;
CREATE TABLE `Academic_Year_Comments`(

	`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,

	`Creator_id` INT NOT NULL REFERENCES `User`(`id`) ON DELETE CASCADE,
	`Post_id` INT NOT NULL REFERENCES `Academic_Year_Posts`(`id`) ON DELETE CASCADE,
	
	`Comment` VARCHAR(2000) NOT NULL,
	
	`Created_At` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP

)ENGINE=InnoDB;




DROP TABLE IF EXISTS `Academic_Year_Announcements`;
CREATE TABLE `Academic_Year_Announcements`(

	`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,

	`Creator_id` INT NOT NULL REFERENCES `User`(`id`) ON DELETE CASCADE,
	`Academic_Year_id` INT NOT NULL REFERENCES `Academic_Year`(`id`) ON DELETE CASCADE,

	`Title` VARCHAR(100) NOT NULL,
	`Instruction` VARCHAR(2000) NOT NULL,
	`File` TEXT NULL,

	`Created_At` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP

)ENGINE=InnoDB;




/**___________________________________________CLASS________________________________________________*/
/**___________________________________________CLASS________________________________________________*/
/**___________________________________________CLASS________________________________________________*/
/**___________________________________________CLASS________________________________________________*/



DROP TABLE IF EXISTS `Class`;
CREATE TABLE `Class`(

	`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,

	`Creator_id` INT NOT NULL REFERENCES `User`(`id`) ON DELETE CASCADE,
	`Academic_Year_id` INT NOT NULL	REFERENCES `Academic_Year`(`id`) ON DELETE CASCADE,
	
	`Name` VARCHAR(100) NOT NULL,
	`JoinCode` VARCHAR(6) NOT NULL UNIQUE,
	`Descreption` VARCHAR(1000) NULL,
	`Image` VARCHAR(100) NULL,
	
	`Created_At` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP

)ENGINE=InnoDB;



DROP TABLE IF EXISTS `Class_Members`;
CREATE TABLE `Class_Members`(

	`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	
	`User_id` INT NOT NULL REFERENCES `User`(`id`) ON DELETE CASCADE,
	`Class_id` INT NOT NULL REFERENCES `Class`(`id`) ON DELETE CASCADE,
	
	`Role` ENUM('Student', 'Teacher') NULL,
	`Position` ENUM('Admin', 'Member') NULL,
	
	`Joined_At` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP

)ENGINE=InnoDB;



DROP TABLE IF EXISTS `Class_Posts`;
CREATE TABLE `Class_Posts`(

	`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`Creator_id` INT NOT NULL REFERENCES `User`(`id`) ON DELETE CASCADE,
	`Class_id` INT NOT NULL REFERENCES `Class`(`id`) ON DELETE CASCADE,
	
	`Post` TEXT NOT NULL,
	`Images` TEXT NULL,
	
	`Created_At` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP

)ENGINE=InnoDB;



DROP TABLE IF EXISTS `Class_Comments`;
CREATE TABLE `Class_Comments`(

	`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`Creator_id` INT NOT NULL REFERENCES `User`(`id`) ON DELETE CASCADE,
	`Post_id` INT NOT NULL REFERENCES `Class_Posts`(`id`) ON DELETE CASCADE,
	
	`Comment` VARCHAR(2000) NOT NULL,
	
	`Created_At` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP

)ENGINE=InnoDB;




DROP TABLE IF EXISTS `Class_Assignments`;
CREATE TABLE `Class_Assignments`(

	`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,

	`Creator_id` INT NOT NULL REFERENCES `User`(`id`) ON DELETE CASCADE,
	`Class_id` INT NOT NULL REFERENCES `Class`(`id`) ON DELETE CASCADE,
	
	`Title` VARCHAR(100) NOT NULL,
	`Instruction` VARCHAR(2000) NOT NULL,
	`Topic` VARCHAR(100) NULL,
	`Points` INT NOT NULL,
	`Due_Date` DATE NOT NULL,
	`Due_Time` TIME NOT NULL,
	`File` TEXT NULL,

	`Created_At` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP

)ENGINE=InnoDB;





DROP TABLE IF EXISTS `Class_Announcements`;
CREATE TABLE `Class_Announcements`(

	`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,

	`Creator_id` INT NOT NULL REFERENCES `User`(`id`) ON DELETE CASCADE,
	`Class_id` INT NOT NULL REFERENCES `Class`(`id`) ON DELETE CASCADE,

	`Title` VARCHAR(100) NOT NULL,
	`Instruction` VARCHAR(2000) NOT NULL,
	`File` TEXT NULL,

	`Created_At` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP

)ENGINE=InnoDB;




/**__________________________________________SERVICES______________________________________________*/
/**__________________________________________SERVICES______________________________________________*/
/**__________________________________________SERVICES______________________________________________*/
/**__________________________________________SERVICES______________________________________________*/



DROP TABLE IF EXISTS `FeedBack`;
CREATE TABLE `FeedBack`(

	`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	
	`Type` ENUM('FeedBack', 'Bug') NOT NULL,
	`Title` VARCHAR(100) NOT NULL,
	`Message` TEXT NOT NULL,
	
	`Created_At` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP

)ENGINE=InnoDB;
