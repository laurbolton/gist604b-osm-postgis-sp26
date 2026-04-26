-- Query 1: Fire Station Distribution
-- Purpose: Extract fire station locations for spatial distribution analysis

-- Requirements:
-- - Use pois for point features
-- - Filter POIs where fclass = 'fire_station'
-- - Return raw point geometries

-- Expected Output:
-- - geom

SELECT
    geom
FROM
    pois
WHERE
    fclass = 'fire_station';