CREATE TABLE `testMMM` (
  `team_name` char(40) NOT NULL,
  `personal_id` char(4) NOT NULL,
  `personal_name` char(10) NOT NULL,
  `sex` char(2) DEFAULT NULL,
  `record_time` time DEFAULT NULL,
  PRIMARY KEY (`personal_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;