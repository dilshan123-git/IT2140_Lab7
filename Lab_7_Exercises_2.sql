
DELIMITER //

CREATE PROCEDURE UpdateMovieStarRanks()
BEGIN
    UPDATE MovieStar m
    SET m.rank = (
        SELECT COUNT(*) 
        FROM StarsIn s 
        WHERE s.starname = m.name 
          AND s.role = 'Lead'
    );
END //

DELIMITER ;


DELIMITER //

CREATE TRIGGER trg_update_star_rank
AFTER INSERT ON StarsIn
FOR EACH ROW
BEGIN
    IF NEW.role = 'Lead' THEN
        UPDATE MovieStar
        SET rank = rank + 1
        WHERE name = NEW.starname;
    END IF;
END //

DELIMITER ;