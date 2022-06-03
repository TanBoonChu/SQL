# Created schema and use 
use example;
DROP TABLE airline;
# Step 4 - Create table with attribute name and type
CREATE TABLE airline(year int, month int, carrier char(10),
                    carrier_name char(30), airport char(10),
                    airport_name char(255), arr_flights int,
                    arr_del15 int, carrier_ct double,
                    weather_ct double, nas_ct double, 
                    security_ct double, late_aircraft_ct int,
                    arr_cancelled int, arr_diverted int, arr_delay int,
                    carrier_delay int, weather_delay int, nas_delay int,
                    security_delay int, late_aircraft_delay int);
SELECT * FROM airline;
# 6(a)
SELECT DISTINCT carrier, year, airport_name FROM airline;
SELECT DISTINCT carrier FROM airline;
SELECT DISTINCT year FROM airline;
# 6(b)
SELECT year, month, airport_name, carrier_name, arr_flights 
FROM airline 
Order by arr_flights DESC
LIMIT 10;
# 6(c)
SELECT count(arr_cancelled), carrier FROM airline
Group by carrier;
# 6(d)
SELECT year, carrier, airport, security_ct FROM airline
WHERE year = '2003' and carrier='AA';
# 6(e)
SELECT weather_ct, carrier, year, airport FROM airline
WHERE carrier='AS' and weather_ct BETWEEN 10 and 20;
# 6(f)
SELECT airport_name, year, month, arr_flights FROM airline
WHERE arr_flights > 500;
# 6(g)
SELECT avg(security_delay), airport FROM airline
WHERE airport = 'OAK';
# 6(h)
SELECT avg(arr_flights) as average_flights, arr_delay, carrier FROM airline
Group by carrier
HAVING arr_delay >= 15 ;