-- Query 1: 
-- Purpose: The first query should extract or filter a set of features from one OSM layer.

-- Requirements:
-- - Use pois for point features
-- - Filter POIs where fclass = 'restaurant'
-- - Return raw point geometries
-- - (Optional) Clip to a specific region if needed

-- Expected Output:
-- - geom

SELECT
    geom
FROM
    pois
WHERE
    fclass = 'restaurant';