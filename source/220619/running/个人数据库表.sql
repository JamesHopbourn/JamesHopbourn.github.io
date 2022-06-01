CREATE TABLE `PR20220619` (
  `event` char(20) DEFAULT "十不我待2022特跑族全国10K排位赛",
  `personal_id` int(4) NOT NULL AUTO_INCREMENT,
  `personal_name` char(10),
  `gender` char(2),
  `start_time` time DEFAULT "00:00:00" COMMENT "如果是分批出发需要设置相应的出发时间",
  `record_time` time COMMENT "到达终点之后的计时时间",
	`video_rank` int(2) COMMENT '如果计时时间相同，根据视频时间排序',
  PRIMARY KEY (`personal_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8; 