Create or replace PACKAGE "CUSTOM_AUTHENTICATION"
AS
  -- global username holder
  g_username VARCHAR2(1000);
 
  -- hash password function
  FUNCTION Hash_password (
    p_email      IN VARCHAR2,
    p_password   IN VARCHAR2,
    p_created_at IN DATE
  )
  RETURN VARCHAR2;
 
  -- main authentication function
  FUNCTION Authenticate_user (
    p_username IN VARCHAR2,
    p_password IN VARCHAR2
  )
  RETURN BOOLEAN;
 
END "CUSTOM_AUTHENTICATION";
/

create or replace PACKAGE BODY "CUSTOM_AUTHENTICATION"
AS
  FUNCTION Hash_password (
    p_email      IN VARCHAR2,
    p_password   IN VARCHAR2,
    p_created_at IN DATE
  )
  RETURN VARCHAR2
  IS
    encrp_password VARCHAR2(255);
  BEGIN
    encrp_password := apex_util.get_hash(
                        apex_t_varchar2(p_password, p_email, TO_CHAR(p_created_at,'YYYYMMDDHH24MISS')),
                        FALSE
                      );
    RETURN encrp_password;
  END Hash_password;
 
  FUNCTION Authenticate_user (
    p_username IN VARCHAR2,
    p_password IN VARCHAR2
  )
  RETURN BOOLEAN
  IS
    l_email           users.email%TYPE;
    l_password        users.password%TYPE;
    l_created_at      users.created_at%TYPE;
    l_hashed_password VARCHAR2(1000);
  BEGIN
    -- always fetch email, password, created_at in one query
    BEGIN
      SELECT email, password, created_at
      INTO   l_email, l_password, l_created_at
      FROM   users
      WHERE  email = p_username;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RETURN FALSE; -- user not found, return false
    END;
 
    -- compute hash and compare
    l_hashed_password := Hash_password(l_email, p_password, l_created_at);
 
    RETURN l_hashed_password = l_password;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN FALSE;
  END Authenticate_user;
 
END "CUSTOM_AUTHENTICATION";
/