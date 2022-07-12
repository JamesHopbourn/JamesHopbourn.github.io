SET @distance := 10;

SELECT
-- 	JSON_ARRAYAGG(
			JSON_OBJECT(
				personal_id,
					JSON_ARRAY( -- 括号内的 value 对应 28~44 -- list:
						CASE final.`rank`
							WHEN "1" THEN "🏅️"
							WHEN "2" THEN "🥈"
							WHEN "3" THEN "🥉"
							ELSE final.`rank`
						END
						, final.`name`, final.`gender`, -- final.`start_time`, -- 如果是分批出发则需要取消注释该行 -- list:
						final.`time`, IFNULL(final.`pace`, 'N/A') -- 此处的 DNS 是为了处理退赛的情况 -- list:
				) -- JSON_ARRAY() END -- list:
			) -- JSON_OBJECT() END
	-- )  -- JSON_ARRAYAGG() END
	AS "result"
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
			p1.personal_id AS "personal_id",
			p1.video_rank AS "video_rank",
			DATE_FORMAT(start_time, '%H:%i:%s') AS "start_time",
			IFNULL(
				DATE_FORMAT(
					SUBTIME(p1.record_time, p1.start_time) , '%H:%i:%s')  -- 减去分批出发的时间差
				, "DNS") AS "time", -- 对弃赛或者未开始的选手成绩数据转为 DNS
			-- 注意这里要包一个格式化函数 包在 TIME_TO_SEC(time)start_time
			DATE_FORMAT( -- 使用特定的格式输出配速
					SEC_TO_TIME( -- 将取整后的整数转回分钟数
						FLOOR( -- SEC_TO_TIME 函数不能处理含有小数点的数值，对数值向下取整
							TIME_TO_SEC( -- SUBTIME 得到的结果是分钟数，转为秒数
								SUBTIME(p1.record_time, p1.start_time) -- 减去分批出发的时间差
							) / @distance -- 除以公里数获得平均配速
						)
					)
				, "%i′%s″") AS "pace"
		FROM
			PR20220619 p1
		WHERE
-- 			record_time -- 筛选条件要求 record_time 数值存在，用于接力赛及时更新数据
-- 		AND
-- 	FIND_IN_SET(gender, '男')	-- tag:man rank:man
-- 	FIND_IN_SET(gender, '女')	-- tag:woman rank:woman
-- 	FIND_IN_SET(gender, '男,女')	-- tag:overall
	) result -- 设置一级 alias
) final -- 设置二级 alias
-- 	INTO OUTFILE 'man.json';	-- tag:man
-- 	INTO OUTFILE 'woman.json';	-- tag:woman
-- 	INTO OUTFILE 'overall.json';	-- tag:overall
-- ------------------------------------------------
-- 	INTO OUTFILE 'man_rank.json';	-- rank:man
-- 	INTO OUTFILE 'woman_rank.json';	-- rank:woman