-- Query 3: 
-- Purpose: The third query should use a spatial relationship or derived spatial metric, 
-- such as proximity, clipped area, clipped length, or density.

-- Requirements:
-- - Use adminareas_a for counties (fclass = 'admin_level6')
-- - Use waterways for river features
-- - Use ST_Intersects to match rivers to counties
-- - Use ST_Intersection to clip river segments to town boundaries
-- - Use ST_Length(geom::geography) for accurate river lengths
-- - Convert meters to kilometers (divide by 1,000)
-- - Use ST_Area(geom::geography) for town area
-- - Convert square meters to square kilometers (divide by 1,000,000)
-- - Use a CTE to calculate intermediate metrics
-- - Calculate river density = total_river_length_km / town_area_sq_km
-- - Order results by river density (highest first)

-- Expected Output:
-- - town_name
-- - total_river_length_km
-- - town_area_sq_km
-- - river_density_km_per_sq_km
-- - geom

WITH town_metrics AS (
    SELECT
        aa.name AS town_name,
        SUM(ST_Length(ST_Intersection(w.geom, aa.geom)::geography)) / 1000 AS total_river_length_km,
        ST_Area(aa.geom::geography) / 1000000 AS town_area_sq_km,
        aa.geom
    FROM
        adminareas_a AS aa
    JOIN
        waterways AS w ON ST_Intersects(aa.geom, w.geom)
    WHERE
        w.fclass = 'river' AND aa.fclass = 'admin_level8'
    GROUP BY
        aa.name, aa.geom
)

SELECT
    town_name,
    total_river_length_km,
    town_area_sq_km,
    total_river_length_km / town_area_sq_km AS river_density_km_per_sq_km,
    geom
FROM
    town_metrics
ORDER BY
    river_density_km_per_sq_km DESC;