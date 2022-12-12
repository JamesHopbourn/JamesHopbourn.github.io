SELECT
	d1.date AS '日期',
	d1.confirmed_count AS '确诊总数',
	COALESCE(
		(
			SELECT
				 d1.confirmed_count - d2.confirmed_count
			FROM
				detailCount d2
			WHERE
				province_name='北京市'
			AND
				d2.date = DATE_SUB(d1.date, INTERVAL 1 DAY)
		),
	"0"
	) AS '新增确诊'
FROM
	detailCount d1
WHERE
	province_name='北京市'
ORDER BY
	d1.date DESC