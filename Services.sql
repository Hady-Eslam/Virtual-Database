
DROP PROCEDURE IF EXISTS `Report`;
DELIMITER //
CREATE PROCEDURE `Report`(
	IN Type VARCHAR(8),
	IN Title VARCHAR(100),
	IN Message VARCHAR(1000)
)
BEGIN
	
	INSERT INTO FeedBack(Type, Title, Message) VALUES (Type, Title, Message);

END //
DELIMITER ;
