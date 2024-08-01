CREATE OR REPLACE FUNCTION check_exam_score()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.score < 0 OR NEW.score > 100 THEN
        RAISE EXCEPTION 'Score must be between 0 and 100';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER exam_score_trigger
BEFORE INSERT OR UPDATE ON exam_results
FOR EACH ROW
EXECUTE FUNCTION check_exam_score();
