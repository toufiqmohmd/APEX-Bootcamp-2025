-- Create a trigger to auto-populate USER_ID
 
Create or replace TRIGGER trg_users_biu
BEFORE INSERT OR UPDATE ON users
FOR EACH ROW
BEGIN
  -- Always force lowercase email
  :NEW.email := LOWER(:NEW.email);
 
  -- Ensure CREATED_AT is set (only on insert)
  IF INSERTING AND :NEW.created_at IS NULL THEN
    :NEW.created_at := SYSDATE;
  END IF;
 
  -- Hash password when inserting or when password changes
  IF :NEW.password IS NOT NULL THEN
    IF INSERTING OR (UPDATING('password') AND :NEW.password <> :OLD.password) THEN
      :NEW.password := custom_authentication.hash_password(
                         :NEW.email,
                         :NEW.password,
                         :NEW.created_at
                       );
    END IF;
  END IF;
 
  -- Auto-generate USER_ID if not provided (only on insert)
  IF INSERTING AND :NEW.user_id IS NULL THEN
    :NEW.user_id := users_seq.NEXTVAL;
  END IF;
END;
/