SELECT * 
FROM (
    SELECT
        a.ID AS contactid,
        a.vorname AS firstname,
        a.nachname AS lastname,
        f.name AS companyname,
        a.email AS email,

        -- Geschäftsnummer normalisiert
        CASE
            WHEN LEFT(REPLACE(REPLACE(REPLACE(a.tel_durchwahl, ' ', ''), '-', ''), '/', ''), 1) = '0' 
            THEN CONCAT('+49', RIGHT(REPLACE(REPLACE(REPLACE(a.tel_durchwahl, ' ', ''), '-', ''), '/', ''), LENGTH(REPLACE(REPLACE(REPLACE(a.tel_durchwahl, ' ', ''), '-', ''), '/', '')) - 1))
            ELSE REPLACE(REPLACE(REPLACE(a.tel_durchwahl, ' ', ''), '-', ''), '/', '')
        END AS phonebusiness,

        -- Mobilnummer normalisiert
        CASE
            WHEN LEFT(REPLACE(REPLACE(REPLACE(a.tel_mobil, ' ', ''), '-', ''), '/', ''), 1) = '0' 
            THEN CONCAT('+49', RIGHT(REPLACE(REPLACE(REPLACE(a.tel_mobil, ' ', ''), '-', ''), '/', ''), LENGTH(REPLACE(REPLACE(REPLACE(a.tel_mobil, ' ', ''), '-', ''), '/', '')) - 1))
            ELSE REPLACE(REPLACE(REPLACE(a.tel_mobil, ' ', ''), '-', ''), '/', '')
        END AS phonebusiness2

    FROM ansprechpartner a
    JOIN firmen f ON a.firmaID = f.ID
    -- Optional: weitere Joins wie standorte falls relevant
) AS SubQuery
WHERE 
    (CHAR_LENGTH(phonebusiness) > 0 OR CHAR_LENGTH(phonebusiness2) > 0)
    AND (
        firstname LIKE '%[SearchText]%' 
        OR lastname LIKE '%[SearchText]%' 
        OR companyname LIKE '%[SearchText]%' 
        OR phonebusiness LIKE '%[SearchText]%' 
        OR phonebusiness2 LIKE '%[SearchText]%'
    );
