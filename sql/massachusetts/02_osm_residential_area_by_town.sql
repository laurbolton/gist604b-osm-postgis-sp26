-- Query 2: Residential Land Use by Town
-- Purpose: The second query should summarize or aggregate results by an administrative unit or category.

-- Requirements:
-- - Use adminareas_a for towns (fclass = 'admin_level8')
-- - Use landuse_a for residential (fclass = 'residential')
-- - Use ST_Intersects to join residential area to towns
-- - Use ST_Intersection to clip residential geometries to town boundaries
-- - Use ST_Area(geom::geography) for accurate measurements on WGS84
-- - Convert square meters to square kilometers (divide by 1,000,000)
-- - Group results by town name
-- - Include geom column for spatial visualization

-- Expected Output:
-- - town_name
-- - residential_area_sq_km
-- - geom

SELECT
    aa.name AS town_name,
    SUM(ST_Area(ST_Intersection(l.geom, aa.geom)::geography)) / 1000000 AS residential_area_sq_km,
    aa.geom
FROM
    adminareas_a AS aa
JOIN
    landuse_a AS l ON ST_Intersects(aa.geom, l.geom)
WHERE
    aa.fclass = 'admin_level8'
    AND l.fclass = 'residential'
GROUP BY
    aa.name, aa.geom
ORDER BY
    residential_area_sq_km DESC
LIMIT 15;