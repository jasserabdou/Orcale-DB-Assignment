-- START OF FILE ================================================================
--
--		    ===============================
--
--          TravelCo TRAVEL -- ASSIGNMENT 3
--
--          ===============================
--
-- TASK ONE - Insertion of data ( 3 parts )
-- TASK TWO - Queries ( 12 in total )
--
-- PLESE READ THIS DOCUMENT CAREFULLY.
-- -----------------------------------
--
-- BEFORE YOU START you must check you have completed the following:
--  
--  0 Download both TracelCo_Tour_Table_and_Data.sql from Canvas.
--    It is available from the assignment specification description.
--
--  0 Open the file TravelCo_Tour_Table_and_Data.sql in SQL Developer and
--    use the Run Script icon (icon with page and small green triangle) or
--    accelerator F5 to run the script.
--    Output may show old versions of tables being removed if run multiple
--    times, before creating clean tables and populating with supplied data.
--    First time through the output should be as follows:
--
--     Dropping Tables ...
--
--       *** Your previous A3_ tables will be removed ***
--
--     Create Tables ...
--      ... A3_TOUR
--      ... A3_LOCATION
--      ... A3_GUIDE
--      ... A3_CLIENT
--      ... A3_OUTING
--      ... A3_PARTICIPANT
--      ... A3_NEXT_OF_KIN
--      ... A3_QUALIFICATION
--      ... A3_ITINERARY_ITEM
--     Populate Tables ...
--      ... A3_TOUR
--      ... A3_LOCATION
--      ... A3_ITINERARY_ITEM
--      ... A3_GUIDE
--      ... A3_QUALIFICATION
--      ... A3_NEXT_OF_KIN
--      ... A3_OUTING
--      ... A3_CLIENT
--      ... A3_PARTICIPANT
--
--     All tables re-created and populated.
--
--
--     PL/SQL procedure successfully completed.
--
--
--  0 Confirm that 9 new tables exist all ending starting A3_
--	  ( A3_Client, A3_Guide, A3_Itinerary_Item, A3_Location, A3_Next_of_Kin,
--      A3_Outing, A3_Participant, A3_Qualification, A3_Tour )
--
--  0 Check each table contains data records in each as follows:
--		SELECT COUNT(*) FROM <table>;
--
--	A3_Client           100
--  A3_Guide              8
--  A3_Itinerary_Item    43
--  A3_Location          38
--  A3_Next_of_Kin       12
--  A3_Outing            42
--  A3_Participant      256
--  A3_Qualification     23
--  A3_Tour              10
--
--  0 Only once you are happy with the tables and data, then progress to the two
--    tasks:
----
-- ======================
-- TASK ONE - ADDING DATA
-- ======================
--
-- You must add the following data to that already inserted into the 9 table
-- schema.
-- Add the INSERT commands used to a SQL script file called aa99aaa-newdata.sql,
-- where aa99aaa is replaced by your username.
--
-- DO NOT remove any existing records
--
-- ADD the following:
--
--  1 - 3 records in A3_Client which represents you and two (fictitious) friends. [ 6 marks ]
--
--      You should not use your real address or phone number or dob, make these
--      up, but make them realistic, especially dates!!
--
--      However, your name should be correct using the given and family name
--      recorded on the student system.
--      Create a unique number for the Client_No entry.
--
--  2 - Create a new outing of an existing tour. [ 4 marks ]
--      Use any existing tour for this purpose, the date of the outing should be 17th June 2022.
--
--  3 - Book yourself and the two "friends" you created on the new outing. [ 6 marks ]
--
--      As stated, make all 3 of you participants on the outing created.
--
--  Note:
--
--	    Store your final INSERT commands in a script file and name it
--      aa99aaa-newdata.sql, where aa99aaa is replaced by your oracle username.
--
--      If during this process, you corrupt the dataset, go back and use the
--      script downloaded to reset the original tables and data
--      Once you are happy ALL INSERTS are correct, it may be a good idea to run
--      the supplied script and your script again to refresh the dataset before
--      starting ...
--
--      DO NOT include the INSERT commands in this file.
--
-- END OF ASSIGNMENT TASK ONE ----------------------------------------------------
--
-- TASK TWO - QUERYING  [ 8 marks per query ] 84 in total
-- ===================
--
-- For this task use SQL Developer to build queries that provide the correct
-- answer to the question asked. Once the query is correct, copy the script into
-- this file in the spaces provided. Answer as many questions if you can. 
--
-- Submission instructions are given at the end of this file.
--
-- QUESTION 1
-- ==========
--
-- Provide a list of all clients who live in Sandley, listing their name, their address
-- and their phone number.
--
-- Hint: All towns (like Sandley) are listed at the end of the address string
-- 
-- Solution Test: The original data provided gives 4 records.
-- The provided data set should look as below
--
-- NAME                 ADDRESS                             PHONE_NO   
-- -------------------- ----------------------------------- -----------
-- Martha Robbins       74b, Sandley Towers, Sandley        09389863734
-- Vital Singh          11, Brentway, Sandley               02349856763
-- Rex Masters          1, Maynard's Drive, Sandley         04526611721
-- Clyde Rusman         10, Brownlee Grange, Sandley        05382811759
--
-- Type your query below:

SELECT
    name,
    address,
    phone_no
FROM
    a3_client
WHERE
    address LIKE '%Sandley'

-- QUESTION 2
-- ==========
--
-- List all tours which visit the "Palace of Westminster". Report the name
-- and the order number of the Palace of Westminster on the tour Itinerary.
--
-- Solution Test: The output from this query should list 3 records.
--
-- Tour                                        Visited
-- ---------------------------------------- ----------
-- Taste of London                                   5
-- The Red Bus 1                                     2
-- The Red Bus 2                                     5
--
-- Type your query below:

SELECT
    t.tour_name            AS "Tour",
    i.order_visited_number AS "Visited"
FROM
         a3_itinerary_item i
    JOIN a3_location l ON i.location = l.location_id
    JOIN a3_tour     t ON t.tour_id = i.tour
WHERE
    l.name = 'Palace of Westminster'

-- QUESTION 3
-- ==========
--
-- Using a nested select, list tours, by name, that the guide Lars Zimmer
-- is listed to be the guide for. Also, report how many outings of these tour they
-- are listed to undertake.
--
-- Solution Test:
--
-- Tour                                        Outings
-- ---------------------------------------- ----------
-- The Red Bus 2                                     1
-- The Red Bus 1                                     2
-- The West End                                      1
-- Cambridge Colleges                                1
-- London at Night                                   3
--
-- Type your query below:
SELECT
    t.tour_name        AS "Tour",
    COUNT(o.outing_id) AS "Outings"
FROM
         a3_tour t
    JOIN a3_outing o ON t.tour_id = o.tour_id
WHERE
    o.guide IN (
        SELECT
            guide_no
        FROM
            a3_guide
        WHERE
                given_name = 'Lars'
            AND family_name = 'Zimmer'
    )
GROUP BY
    t.tour_name

-- QUESTION 4 - DIFFICULT
-- ==========
--
-- List all locations that are finishing points for a tour.
-- List the name of these locations and name of the tour that ends there how many
-- locations are visited.
--
-- Hint: This will require a nested SELECT to create an interim table including the
--       tour details and a value representing the final location number which is
--       then joined to the relevant location data.
-- 
-- Solution Test: The following 9 records should be output.
--
-- Tour                        Visits Last Location                                     
-- --------------------------- ------ --------------------------------------------------
-- London at Night                  4 O2 Arena                                          
-- The Red Bus 2                    5 Palace of Westminster                             
-- Shakespeare's Home               4 Royal Shakespeare Theatre                         
-- Scenes of Edinburgh              6 John Knox House                                   
-- The West End                     4 Covent Garden                                     
-- Cambridge Colleges               4 Queen's College                                   
-- Royal Windsor                    4 Bel and the Dragon                                
-- Taste of London                  5 Palace of Westminster                             
-- Roman Bath                       4 Herschel Museum of Astronomy                      
--
-- Type your query below:
WITH location_data AS (
    SELECT
        tour,
        location,
        DENSE_RANK()
        OVER(PARTITION BY tour
             ORDER BY
                 order_visited_number DESC
        ) AS last_loc
    FROM
        a3_itinerary_item
), tour_count AS (
    SELECT
        tour,
        COUNT(location) AS count_loc
    FROM
        a3_itinerary_item
    GROUP BY
        tour
)
SELECT
    t.tour_name AS "Tour",
    l.name AS "Visits",
    tc.count_loc AS "Last Location"
FROM
         location_data lv
    JOIN tour_count  tc ON tc.tour = lv.tour
    JOIN a3_tour     t ON t.tour_id = lv.tour
    JOIN a3_location l ON l.location_id = lv.location
WHERE
    lv.last_loc = 1

-- QUESTION 5
-- ==========
--
-- For each guide, list the number of qualifications each guide has achieved.
--
-- Solution Test: The following 9 records should be output.
--
-- Guide                    Qualifications passed
-- ------------------------ ---------------------
-- McLinlay, Grace                              3
-- March, Claire                                4
-- Dzabo, Clive                                 1
-- Simmonds, Michael                            3
-- Zimmer, Lars                                 5
-- D'Ville, Reuben                              4
-- Govern, Michelle                             3
--
-- Type your query below:
SELECT
    g.family_name
    || ', '
    || g.given_name AS "Guide",
    COUNT(q.tour) AS "Qualifications passed"
FROM
         a3_guide g
    JOIN a3_qualification q ON q.guide = g.guide_no
GROUP BY
    g.family_name,
    g.given_name

-- QUESTION 6
-- ==========
--  
-- The company needs a list of all qualifications that have expired. Qualifications
-- must all be renewed after 10 years. The report must list the guides name,
-- the tour name and the date the qualification expires.
-- Please provide headings to the columns that are meaningful as below, and
-- order the output with the earliest expiry date first.
--
-- Hint: Use some of the date functions provided in the SQL Manual.
--       Documentation on other Date datatype function examples can be found here:
--          http://www.dba-oracle.com/t_oracle_date_functions.htm
--
-- Solution Set: Run on May 25th 2022
--
-- Guide               Tour Qualification     Expires             
-- ------------------- ---------------------- -----------
-- March, Claire       Shakespeare's Home     03-Jun-2021         
-- McLinlay, Grace     Scenes of Edinburgh    12-May-2022         
-- D'Ville, Reuben     Cambridge Colleges     10-Nov-2019         
-- D'Ville, Reuben     The West End           02-Dec-2020         
--
-- Type your query below:
SELECT
    g.family_name
    || ', '
    || g.given_name AS "Guide",
    t.tour_name     AS "Tour Qualification ",
    ADD_MONTHS(date_passed,120)   AS "Expires"
FROM
         a3_guide g
    INNER JOIN a3_qualification q ON q.guide = g.guide_no
    INNER JOIN a3_tour          t ON t.tour_id = q.tour
WHERE
    ADD_MONTHS(date_passed,120) < TO_DATE('2022-05-25', 'yyyy-mm-dd')
ORDER BY
    date_passed ASC

-- QUESTION 7
-- ==========
--  
-- List the tour names of all tours with the number of outings scheduled.
-- Order by the highest number of outings first. 
--
-- Tour                  Outings Scheduled
-- --------------------- -----------------
-- London at Night                      10
-- Cambridge Colleges                    8
-- The Red Bus 1                         6
-- Taste of London                       5
-- The Red Bus 2                         4
-- Scenes of Edinburgh                   3
-- Roman Bath                            2
-- Shakespeare's Home                    2
-- The West End                          2
-- Royal Windsor                         1
--
-- Type your query below:
SELECT
    t.tour_name        AS "Tour",
    COUNT(o.outing_id) AS "Outings Scheduled"
FROM
         a3_outing o
    JOIN a3_tour t ON t.tour_id = o.tour_id
GROUP BY
    t.tour_name
ORDER BY
    COUNT(o.outing_id) DESC

-- QUESTION 8
-- ==========
--
-- Identify if any guides have yet to register both next of kin. Report just the
-- full names of those guides who have one or less next of kin recorded.
--
-- Hint: Review all members of tennis clubs query in slides
--
-- Guide without N-o-K            Number Recorded
-- ------------------------------ ---------------
-- Dzabo, Clive                                 1
-- Tulane, Grant                                1
-- D'Ville, Reuben                              1

-- Type your query below:
SELECT
    g.family_name
    || ', '
    || g.given_name   AS "Guide without N-o-K",
    COUNT(kin_number) AS "Number Recorded"
FROM
         a3_guide g
    JOIN a3_next_of_kin k ON k.guide_no = g.guide_no
GROUP BY
    g.family_name,
    g.given_name
HAVING
    COUNT(kin_number) <= 1

-- QUESTION 9
-- ==========
--
-- Identify the popularity of historic location.
-- Popularity is identified by the number of participants on all outings of all tours
-- that visit each location. For the purposes of this query, assume ALL participants
-- registered do attend the tour. List the location and the number of individual visits.
--
-- Location                                           Total Visits
-- -------------------------------------------------- ------------
-- Edinburgh Castle                                             25
-- Roman Baths                                                  21
-- Tower of London                                              56
-- Tower Bridge                                                105
-- Anne Hathaway's Cottage                                      18
-- Shakespeare's Birthplace                                     18
-- St. John's College                                           36
-- Queen's College                                              36
-- Herschel Museum of Astronomy                                 21
-- Palace of Holyroodhouse                                      25
-- Porterhouse College                                          36
-- 
-- Type your query below:
SELECT
    l.name          AS "Location",
    COUNT(p.client) AS "Total Visits"
FROM
         a3_participant p
    JOIN a3_outing         o ON o.outing_id = p.outing_id
    JOIN a3_itinerary_item i ON i.tour = o.tour_id
    JOIN a3_location       l ON i.location = l.location_id
GROUP BY
    l.name

-- QUESTION 10, 11, 12
-- ===================
-- Write three queries to provide the basic information needed about YOUR tour.
-- 
-- 10
-- ==
--
-- List details about the three new clients, you and your new "friends". Follow the 
-- layout shown below.
--
-- Solution Set:
--
-- Name                        Address                       Tel         Discount %
-- --------------------------- ----------------------------- ----------- ----------
-- Rebecca Martins (03846455)  34, Mount Drive, Lindon       07256882974          0
-- Craig Legion (62822277)     8, Mandela Walk, Southlands   06399823840         20
-- Thomas Grace (82636780)     23, High Street, Lindon       06398364024          0
--
-- Type your query below:
SELECT
    name
    || ','
    || ( client_no ) AS "Name",
    address AS "Address",
    phone_no AS "Tel",
    discount
FROM
    a3_client
WHERE
    client_no IN ( 12345678, 34789056, 56767965 )
--
-- 11
-- ==
--
-- Print the details of the new outing you created as shown below including the number 
-- of participants on the outing.
--
-- Number   Tour                                     Date/Time                  Participants
-- -------- ---------------------------------------- -------------------------- ------------
-- 21000196 The West End                             17.Jun.2021 13:30                     8
--
-- Type your query below:
SELECT
    o.outing_id     AS "Number",
    t.tour_name     AS "Tour",
    o.outing_start  AS "Date/Time",
    COUNT(p.client) AS "Participants"
FROM
         a3_participant p
    JOIN a3_outing o ON ( o.outing_id = p.outing_id )
    JOIN a3_tour   t ON ( t.tour_id = o.tour_id )
WHERE
    o.outing_id = 21000209
GROUP BY
    o.outing_start,
    t.tour_name,
    o.outing_id;

--
-- 12
-- ==
--
-- List the itinerary (in the correct order) for the outing you and your friends
-- are booked on reproducing the format shown below.
--
-- Solution Set:
--
-- Location                             Detailed Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
-- ------------------------------------ -----------------------------------------
-- Tower of London (Historic)           Home of the Crown Jewels                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
-- Tower Bridge (Historic)              Iconic opening bridge over River Thames                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
-- Buckingham Palace (Cultural)         Home of the British Monarch in London                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
-- Palace of Westminster (Cultural)     Houses British Parliament and Big Ben                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
-- Trafalgar Square (Landmark)          Contains Nelson's Column                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
--
-- Type your query below:
SELECT
    l.name as "Location",
    l.description
FROM
         a3_itinerary_item i
    JOIN a3_location l ON i.location = l.location_id
WHERE
    i.tour = 100345
ORDER BY
    order_visited_number ASC


-- END OF ASSIGNMENT TASK TWO -----------------------------------------------------------------------------------------------------------

-- SUBMISSION REQUIREMENTS
-- =======================
--
-- Once your queries are tested and the final version placed in the file above in
-- the appropriate place, the following should be done in order to meet the
-- submission requirements:
--
--  1  Rename this file in the following format:
--
--			aa99aaa-Ass3.sql
--
--     where the aa99aaa is replaced by your Oracle username
--
--  2  Open this file in an SQL Worksheet in SQL Developer, clear the Script
--     Output window using the eraser icon, and ensure your 9 table schema is
--     correct and includes your entered data.
--
--  3  Use the "Run Script (F5)" icon (sheet of paper with small green triangle)
--     to run your script completely. Ensure all commands are run without errors.
--
--  4  Save the Script Output text by clicking on the "floppy disk" icon, use the
--     popup window to save the file as aa99aaa-Ass3.txt, again, where the
--     aa99aaa is replaced by your Oracle username
--
--  5  Double check the aa99aaa-Ass3.sql and aa99aaa-Ass3.txt files, then upload
--     them onto CANVAS in the Assignment point.
--
--  6  Congratulations, you are done!
--
-- END OF FILE ASS3.SQL ==================================================================================================================



