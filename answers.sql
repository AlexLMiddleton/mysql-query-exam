/*1. Select a distinct list of ordered airports codes. Be sure to name the column correctly. Be sure to order the results correctly. */

SELECT departAirport as Airports FROM flight GROUP BY Airports ORDER BY Airports ASC;

/*2. Provide a list of delayed flights departing from San Francisco (SFO). */

SELECT airline.name, flight.flightNumber, flight.scheduledDepartDateTime, flight.arriveAirport, flight.status FROM airline INNER JOIN flight ON airline.ID = flight.airlineID WHERE departAirport = 'SFO' AND flight.status = 'delayed';

/*3. Provide a distinct list of cities that American airlines departs from. */

SELECT flight.departAirport as Cities FROM flight INNER JOIN airline ON airline.ID = flight.airlineID WHERE airline.name = 'American' GROUP BY departAirport ASC;

/*4. Provide a distinct list of airlines that conducts flights departing from ATL. */

SELECT airline.name as Airline from airline INNER JOIN flight ON airline.ID = flight.airlineID WHERE flight.departAirport = 'ATL' GROUP BY Airline ASC;

/*5. Provide a list of airlines, flight numbers, departing airports, and arrival airports where flights departed on time. */

SELECT airline.name, flight.flightNumber, flight.departAirport, flight.arriveAirport FROM airline INNER JOIN flight ON airline.ID = flight.airlineID WHERE flight.scheduledDepartDateTime = flight.actualDepartDateTime;

/*6. *** Provide a list of airlines, flight numbers, gates, status, and arrival times arriving into Charlotte (CLT) on 10-30-2017. Order your results by the arrival time. */

SELECT airline.name as Airline, flight.flightNumber as Flight, flight.gate as Gate, TIME(flight.scheduledArriveDateTime) as Arrival, flight.status as Status FROM flight INNER JOIN airline ON airline.ID = flight.airlineID WHERE arriveAirport = 'CLT' AND DATE(flight.scheduledArriveDateTime) = '2017-10-30';

/*7. List the number of reservations by flight number. Order by reservations in descending order. */

SELECT flightNumber as flight, COUNT(reservation.flightID) as reservations FROM flight INNER JOIN reservation ON flight.ID = reservation.flightID  GROUP BY reservation.flightID ORDER BY reservations DESC;

/*8.  *** List the average ticket cost for coach by airline and route. Order by AverageCost in descending order. */

SELECT airline.name as airline, flight.departAirport, flight.arriveAirport, AVG(reservation.cost) as AverageCost FROM airline INNER JOIN flight ON airline.ID = flight.airlineID INNER JOIN reservation on flight.id = reservation.flightID WHERE reservation.class = 'coach' GROUP BY airline, flight.departAirport, flight.arriveAirport ORDER BY AverageCost DESC;

/*9. Which route is the longest? */

SELECT departAirport, arriveAirport, miles FROM flight ORDER BY miles DESC LIMIT 1;

/*10. List the top 5 passengers that have flown the most miles. Order by miles. */

SELECT passenger.firstName as firstName, passenger.lastName as lastName, SUM(flight.miles) as miles FROM passenger INNER JOIN reservation ON passenger.ID = reservation.passengerID INNER JOIN flight ON flight.ID = reservation.flightID GROUP BY passenger.firstName, passenger.lastName ORDER BY miles DESC, firstName ASC LIMIT 5;

/*11. Provide a list of American airline flights ordered by route and arrival date and time. */

SELECT airline.name as Name, CONCAT(departAirport, ' --> ', arriveAirport) as Route, DATE(scheduledArriveDateTime) as 'Arrive Date', TIME(scheduledArriveDateTime) as 'Arrive Time' FROM flight INNER JOIN airline ON airline.ID = flight.airlineID WHERE Name='American' ORDER BY Route, DATE(scheduledArriveDateTime), TIME(scheduledArriveDateTime);

/*12. Provide a report that counts the number of reservations and totals the reservation costs (as Revenue) by Airline, flight, and route. Order the report by total revenue in descending order.*/

SELECT airline.name as Airline, flight.flightNumber as Flight, CONCAT(departAirport, ' --> ', arriveAirport) as Route, COUNT(reservation.flightID) as 'Reservation Count', SUM(reservation.cost) as Revenue FROM airline INNER JOIN flight ON airline.id = flight.airlineID INNER JOIN reservation ON flight.ID = reservation.flightID GROUP BY Airline, Flight, Route ORDER BY Revenue DESC;

/*13. List the average cost per reservation by route. Round results down to the dollar. */

SELECT CONCAT(departAirport, ' --. ', arriveAirport) as Route, FLOOR(AVG(reservation.cost)) as 'Avg Revenue' FROM flight INNER JOIN reservation ON flight.ID = reservation.flightID GROUP BY Route ORDER BY FLOOR(AVG(reservation.cost)) DESC;

/*14. List the average miles per flight by airline. */

SELECT airline.name as Airline, AVG(flight.miles) FROM airline INNER JOIN flight ON airline.ID = flight.airlineID GROUP BY Airline;

/*15. Which airlines had flights that arrived early? */

SELECT airline.name as Airline FROM airline INNER JOIN flight ON airline.ID = flight.airlineID WHERE TIME(scheduledArriveDateTime) > TIME(actualArriveDateTime) GROUP BY Airline;
