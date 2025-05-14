SELECT * 
FROM (
    SELECT
        a.ID AS contactid,
        a.vorname AS firstname,
        a.nachname AS lastname,
        f.name AS companyname,
        a.email AS email,
        
        -- Telefon geschäftlich
        CASE
            WHEN LEFT(REPLACE(REPLACE(REPLACE(a.tel_durchwahl, ' ', ''), '-', ''), '/', ''), 1) = '0' 
            THEN CONCAT('+49', RIGHT(REPLACE(REPLACE(REPLACE(a.tel_durchwahl, ' ', ''), '-', ''), '/', ''), LENGTH(REPLACE(REPLACE(REPLACE(a.tel_durchwahl, ' ', ''), '-', ''), '/', '')) - 1))
            ELSE REPLACE(REPLACE(REPLACE(a.tel_durchwahl, ' ', ''), '-', ''), '/', '')
        END AS phonebusiness,
        
        -- Telefon mobil
        CASE
            WHEN LEFT(REPLACE(REPLACE(REPLACE(a.tel_mobil, ' ', ''), '-', ''), '/', ''), 1) = '0' 
            THEN CONCAT('+49', RIGHT(REPLACE(REPLACE(REPLACE(a.tel_mobil, ' ', ''), '-', ''), '/', ''), LENGTH(REPLACE(REPLACE(REPLACE(a.tel_mobil, ' ', ''), '-', ''), '/', '')) - 1))
            ELSE REPLACE(REPLACE(REPLACE(a.tel_mobil, ' ', ''), '-', ''), '/', '')
        END AS phonebusiness2
        
    FROM ansprechpartner a
    JOIN firmen f ON a.firmaID = f.ID
    -- ggf. weitere Tabellen JOINen, z. B. standorte oder verträge
) AS SubQuery
WHERE phonebusiness LIKE '%[Number]%';
