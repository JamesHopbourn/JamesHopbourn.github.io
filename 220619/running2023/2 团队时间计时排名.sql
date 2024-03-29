SELECT
json_object(
	team_name,TIME_FORMAT( MAX( record_time ), "%H:%i:%s" )
	) AS "team.json"
FROM
	PR20220115
GROUP BY
	team_name 
ORDER BY
	MAX(record_time);


-- 个人成绩排名
SELECT
json_object(
		m1.`personal_name`,
		JSON_ARRAY(
			m1.`team_name`, -- '战队名字'
			m1.`personal_bib`, -- '参赛号码'
			m1.`gender`, -- '性别'
			TIME_FORMAT(m1.`record_time`, "%H:%i:%s"), -- '计时时间'
			COALESCE ((
					SELECT
						DATE_FORMAT(
							SEC_TO_TIME(
								TIMESTAMPDIFF( SECOND, m2.record_time, m1.record_time )
						) , '%i:%s')
					FROM
						PR20220115 AS m2
					WHERE
						m2.`personal_bib` = m1.`personal_bib` - 1
						AND
						m1.`team_name` = m2.`team_name`
				),
				DATE_FORMAT( m1.`record_time`, '%i:%s' )
			), -- '净时间'
			-- 下面是配速计算函数
			COALESCE ((
				SELECT
				DATE_FORMAT(
					SEC_TO_TIME(
						FLOOR( 
							TIMESTAMPDIFF(
								SECOND,m2.record_time, m1.record_time
							)/6.76 -- TIMESTAMPDIFF
						) -- FLOOR
					), -- SEC_TO_TIME
				'%i′%s″')	 -- DATE_FORMAT
				FROM
					PR20220115 AS m2
				WHERE
					m2.`personal_bib`+1 = m1.`personal_bib`
				AND
					m1.`team_name` = m2.`team_name`
					), -- COALESCE
				DATE_FORMAT(
					SEC_TO_TIME(
						FLOOR(
							TIME_TO_SEC( m1.`record_time` )/ 6.76)
						), '%i′%s″' -- FLOOR
					) -- SEC_TO_TIME
				) -- DATE_FORMAT
			) -- '配速'
			) -- json_object
AS "result.json"
FROM PR20220115 m1
GROUP BY m1.`personal_bib`