CREATE TABLE `PR20220115` (
  `event` char(20) DEFAULT '2022 马拉松接力赛',
  `personal_id` int NOT NULL,
  `personal_name` char(10) DEFAULT NULL,
  `gender` char(2) DEFAULT NULL,
  `start_time` time DEFAULT '00:00:00',
  `record_time` time DEFAULT NULL,
  `video_rank` int DEFAULT NULL COMMENT '如果计时时间相同，根据视频时间排序',
  PRIMARY KEY (`personal_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;