DROP TABLE IF EXISTS student;

CREATE TABLE student (
  id int NOT NULL AUTO_INCREMENT,
	stu_number VARCHAR ( 20 ) NOT NULL,
	stu_name VARCHAR ( 20 ) NOT NULL,
	stu_gender VARCHAR ( 20 ) NOT NULL DEFAULT '男',
	stu_class VARCHAR ( 20 ) NOT NULL,
	PRIMARY KEY (`id`)	
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;;

INSERT INTO student ( stu_number, stu_name, stu_gender, stu_class )
VALUES
	( 202012900301, '曾华', '男', '一班' ),
	( 202012900302, '匡明', '男', '一班' ),
	( 202012900303, '王丽', '女', '一班' ),
	( 202012900304, '李军', '男', '一班' ),
	( 202012900305, '王芳', '女', '一班' ),
	( 202012900306, '陆君', '男', '一班' );