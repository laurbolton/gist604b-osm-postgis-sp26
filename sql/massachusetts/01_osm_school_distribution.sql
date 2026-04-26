-- Query 1: School Distribution
-- Purpose: Extract school locations for spatial distribution analysis

-- Requirements:
-- - Use pois for point features
-- - Filter POIs where fclass = 'school'
-- - Return raw point geometries

-- Expected Output:
-- - geom

SELECT
    geom
FROM
    pois
WHERE
    fclass = 'school';