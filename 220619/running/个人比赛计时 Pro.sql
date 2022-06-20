SELECT 
	json_arrayagg(
		json_object(
		personal_id, -- JSON KEY START
			JSON_ARRAY(
				personal_name, DATE_FORMAT(`record_time`, '%H:%i:%s')
			)
		) -- JSON KEY END
	) -- JSON_ARRAYAGG() END
AS
	"result.json"
FROM
	PR20220619
WHERE
	record_time IS NOT NULL