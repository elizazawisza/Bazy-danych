CREATE TRIGGER usun_film
AFTER DELETE
ON filmy FOR EACH ROW
BEGIN
Delete from zagrali where zagrali.film_id=filmy.film_id;
END
