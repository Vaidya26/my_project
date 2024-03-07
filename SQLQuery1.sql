SELECT * FROM album

1.Senior most Employee based on job title

SELECT * FROM employee

SELECT top 1 first_name, last_name, levels
FROM employee
ORDER BY levels desc


2.Countries have the most invoices

SELECT count(*) as c, billing_country
from invoice
GROUP BY billing_country
ORDER BY c desc


3.Top 3 values of total invoice

SELECT TOP 3 total FROM invoice
ORDER BY total desc


4.City has the best customers & would like to throw a promotional music festival in the city most money made

SELECT sum(total) as invoice_total, billing_city
FROM invoice
GROUP BY billing_city
ORDER BY invoice_total desc

SELECT * FROM customer
5.The person who has spent the most money

SELECT TOP 1 customer.customer_id, customer.last_name, customer.first_name, sum(invoice.total) as total
FROM customer
join invoice on customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id, customer.last_name, customer.first_name, invoice.total
ORDER BY invoice.total DESC


6.Return the email, first name, last name & genre of all rock music listeners. and list ordered alphabetically by email starting with A.

SELECT DISTINCT first_name, last_name, email 
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE track_id IN(
      SELECT track_id FROM track
	  JOIN genre ON track.genre_id = genre.genre_id
	  WHERE genre.name LIKE 'Rock'
)
ORDER BY email;


7. Returns the Artist name and total track count of the top 10 rock bands.

SELECT TOP 10 artist.artist_id, artist.name, COUNT(artist.artist_id) as number_of_songs
FROM track
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id, artist.name
ORDER BY number_of_songs DESC


8. Return the name and milliseconds for each track. order by the song lengh with  the longest songs listed first.

SELECT name, milliseconds 
FROM track
WHERE milliseconds > (
      SELECT AVG(milliseconds) as avg_track_length
	  FROM track)
ORDER BY milliseconds DESC;