CREATE OR REPLACE FUNCTION restrict_after_7pm()
RETURNS TRIGGER AS $$
BEGIN
    IF EXTRACT(HOUR FROM CURRENT_TIME) >= 19 THEN
        RAISE EXCEPTION 'Updates, inserts, or deletes are not allowed after 7:00 PM';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER restrict_time_trigger
BEFORE INSERT OR UPDATE OR DELETE ON student
FOR EACH ROW
EXECUTE FUNCTION restrict_after_7pm();
