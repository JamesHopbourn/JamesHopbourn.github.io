SET @distance := 10;

SELECT
-- 	json_arrayagg(
		json_object( -- 括号内的 value 对应 28~44
			"rank", CASE final.`rank`
								WHEN "1" THEN "🏅️"
								WHEN "2" THEN "🥈"
								WHEN "3" THEN "🥉"
								ELSE final.`rank`
							END,
			"name", final.`name`,
			"gender", final.`gender`,
			"bib_no", final.`bib_no`,
-- 			"start_time", final.`start_time`, -- 如果是分批出发则需要取消注释该行
			"time", final.`time`,
			"pace", final.`pace`
		) -- json_object END
-- 	) -- json_arrayagg END
	AS "data"
FROM(
	SELECT
		 -- 根据情况选择 DENSE_RANK(), RANK(), ROW_NUMBER()
		 -- 先根据净时间排序，如果净时间相同，则根据视频过线排名排序，保证公平性
		ROW_NUMBER() over (ORDER BY result.`time`, p1.`video_rank`) AS 'rank',
		result.*
	FROM
	(
		SELECT
			p1.personal_name AS "name",
			p1.gender AS "gender",
			p1.personal_id AS "bib_no",
			p1.video_rank AS "video_rank",
			-- p1.start_time AS "start_time", -- 如果是分批出发，需要去设置 start_time
			DATE_FORMAT(
				SUBTIME(p1.record_time, p1.start_time) -- 减去分批出发的时间差
			, '%H:%i:%s') AS "time",
			-- 注意这里要包一个格式化函数 包在 TIME_TO_SEC(time)start_time
			DATE_FORMAT( -- 使用特定的格式输出配速
					SEC_TO_TIME( -- 将取整后的整数转回分钟数
						FLOOR( -- SEC_TO_TIME 函数不能处理含有小数点的数值，对数值向下取整
							TIME_TO_SEC( -- SUBTIME 得到的结果是分钟数，转为秒数
								SUBTIME(p1.record_time, p1.start_time) -- 减去分批出发的时间差
							) / @distance -- 除以公里数获得平均配速
						)
					)
				, '%i′%s″') AS "pace"
		FROM
			PR20220619 p1
		WHERE
			record_time -- 筛选条件要求 record_time 数值存在，用于接力赛及时更新数据
-- 	AND FIND_IN_SET(gender, '男')	-- tag:man
-- 	AND	FIND_IN_SET(gender, '女')	-- tag:woman
-- 	AND	FIND_IN_SET(gender, '男,女')	-- tag:overall
	) result -- 设置一级 alias
) final -- 设置二级 alias
-- 	INTO OUTFILE 'man.json';	-- tag:man
-- 	INTO OUTFILE 'woman.json';	-- tag:woman
-- 	INTO OUTFILE 'overall.json';	-- tag:overall