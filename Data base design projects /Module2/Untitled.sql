

SELECT Phone_model,to_char (phone_price,'$9999.99')
FROM Phone;


SELECT Phone_model,to_char((phone_price-50),'$9999.99')
FROM Phone;



SELECT customer.customer_name ||'('|| phone.phone_model || '  -  ' || to_char(phone_price,'$9999.99')|| ')'
FROM phone
JOIN  customer
ON phone.phone_id = customer.phone_id

SELECT customer_name, phone_model
from phone
full join customer
on phone.phone_id = customer.phone_id;


SELECT 
	(Phone_model) AS "deluxe Phone",
	to_char(phone_price,'$9999.99') as price,
	release_date
FROM Phone
WHERE Phone_model = 'Galaxy S21+' OR
	  Phone_model = 'Xenos 360' AND
	  release_date >= CAST('01-JUL-2020' AS DATE) AND
	  phone_price  BETWEEN 750 AND 1000;
	  
SELECT 
	(Phone_model) AS "deluxe Phone",
	to_char(phone_price,'$9999.99') as price,
	release_date
FROM Phone
WHERE NOT(Phone_model = 'Apple iPhone X') AND
	  release_date >= CAST('01-MAY-2020' AS DATE) AND
	  phone_price >=900;
	  
	  
SELECT phone_model,to_char(phone_price,'$9999.99') as regular_price,
	  to_char (phone_price-75,'$9999.99') as reduce_price
FROM Phone
Where phone_price>400;

ALTER TABLE Phone
ADD is_high_end Boolean GENERATED ALWAYS AS

(CASE
 	WHEN phone_price >700  AND release_date >= CAST('19-MAY-2020' AS DATE) THEN true
 	
 	Else false
END)STORED;


ALTER TABLE Phone
DROP COLUMN is_high_end



SELECT*,
'True' as "is_high_end"

from Phone
WHERE phone_price >700  AND release_date >= CAST('19-MAY-2020' AS DATE)

UNION

SELECT*,
'False' as "is_high_end"
from Phone
WHERE phone_price <=700  AND release_date < CAST('19-MAY-2020' AS DATE)





 