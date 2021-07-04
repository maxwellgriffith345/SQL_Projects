--SOURCE:https://mode.com/sql-tutorial/sql-data-types/
--using schemas from "Mode Public Warehouse"

--joining info on players and schools
--figure out which conference has the highest average weight.
SELECT teams.conference AS conference,
       AVG(players.weight) AS average_weight
  FROM benn.college_football_players players
  JOIN benn.college_football_teams teams
    ON teams.school_name = players.school_name
 GROUP BY teams.conference
 ORDER BY AVG(players.weight) DESC

 --EX1 USING ALIASES
 /*Write a query that selects the school name, player name,
 position, and weight for every player in Georgia,
 ordered by weight (heaviest to lightest).
 Be sure to make an alias for the table,
 and to reference all column names in relation to the alias */

SELECT players.school_name,
       players.player_name,
       players.position,
       players.weight
  FROM benn.college_football_players players
 WHERE players.state = 'GA'
 ORDER BY players.weight DESC

 --INNER JOIN
 --EX2
 /*Write a query that displays player names, school names and
 conferences for schools in the "FBS (Division I-A Teams)" division.*/
 SELECT players.player_name,
        players.school_name,
        teams.conference
   FROM benn.college_football_players players
   JOIN benn.college_football_teams teams
     ON teams.school_name = players.school_name
  WHERE teams.division = 'FBS (Division I-A Teams)'

  --LEFT JOIN
  /*LEFT JOIN command tells the database to return all rows in
  the table in the FROM clause, regardless of whether or not
  they have matches in the table in the LEFT JOIN clause*/

  --EX3
  /*Write a query that performs an inner join between
  the tutorial.crunchbase_acquisitions table and
  the tutorial.crunchbase_companies table,
  but instead of listing individual rows, count the number
  of non-null rows in each table.*/
  SELECT COUNT(companies.permalink) AS companies_rowcount,
       COUNT(acquisitions.company_permalink) AS acquisitions_rowcount
  FROM tutorial.crunchbase_companies companies
  JOIN tutorial.crunchbase_acquisitions acquisitions
    ON companies.permalink = acquisitions.company_permalink

--EX4
/*Modify the query above to be a LEFT JOIN.
Note the difference in results. */
SELECT COUNT(companies.permalink) AS companies_rowcount,
       COUNT(acquisitions.company_permalink) AS acquisitions_rowcount
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_acquisitions acquisitions
    ON companies.permalink = acquisitions.company_permalink

--EX5
/*Count the number of unique companies (don't double-count companies)
and unique acquired companies by state. Do not include results for
which there is no state data, and order by the number of
acquired companies from highest to lowest.*/

SELECT companies.state_code,
       COUNT(DISTINCT companies.permalink) AS unique_companies,
       COUNT(DISTINCT acquisitions.company_permalink) AS unique_companies_acquired
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_acquisitions acquisitions
    ON companies.permalink = acquisitions.company_permalink
 WHERE companies.state_code IS NOT NULL
 GROUP BY 1
 ORDER BY 3 DESC

 --JOINS USING WHERE OR ON
 --you might want to filter one or both of the tables before joining them
 SELECT companies.permalink AS companies_permalink,
       companies.name AS companies_name,
       acquisitions.company_permalink AS acquisitions_permalink,
       acquisitions.acquired_at AS acquired_date
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_acquisitions acquisitions
    ON companies.permalink = acquisitions.company_permalink
   AND acquisitions.company_permalink != '/company/1000memories'
 ORDER BY 1

 --EX6
 /*Write a query that shows a company's name, "status" (found in the Companies table),
 and the number of unique investors in that company.
  Order by the number of investors from most to fewest.
  Limit to only companies in the state of New York. */

SELECT companies.name AS company_name,
       companies.status,
       COUNT(DISTINCT investments.investor_name) AS unqiue_investors
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_investments investments
    ON companies.permalink = investments.company_permalink
 WHERE companies.state_code = 'NY'
 GROUP BY 1,2
 ORDER BY 3 DESC

--EX7
/*Write a query that lists investors based on the number of
companies in which they are invested. Include a row for
companies with no investor, and order from most companies to least. */

SELECT CASE WHEN investments.investor_name IS NULL THEN 'No Investors'
            ELSE investments.investor_name END AS investor,
       COUNT(DISTINCT companies.permalink) AS companies_invested_in
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_investments investments
    ON companies.permalink = investments.company_permalink
 GROUP BY 1
 ORDER BY 2 DESC
