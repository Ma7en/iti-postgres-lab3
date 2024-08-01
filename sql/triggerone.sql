CREATE OR REPLACE FUNCTION check_course_name_length()
RETURNS TRIGGER AS $$
BEGIN
    IF LENGTH(NEW.name) > 20 THEN
        RAISE EXCEPTION 'Course name cannot exceed 20 characters';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER course_name_length_trigger
BEFORE INSERT ON Courses
FOR EACH ROW
EXECUTE FUNCTION check_course_name_length();

