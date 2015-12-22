CREATE TABLE APM_APP_HITS (
    UUID VARCHAR2(500) NOT NULL,
    APP_NAME VARCHAR2(200) NOT NULL,
    VERSION VARCHAR2(50),
    CONTEXT VARCHAR2(256) NOT NULL,
    USER_ID VARCHAR2(50) NOT NULL,
    TENANT_ID INTEGER,
    HIT_TIME DATE NOT NULL,
    FOREIGN KEY (TENANT_ID,USER_ID) REFERENCES APM_SUBSCRIBER(TENANT_ID,USER_ID),
    PRIMARY KEY (APP_NAME, VERSION, USER_ID, TENANT_ID, HIT_TIME)
)
/
CREATE TABLE APM_EXTERNAL_STORES (
    APP_STORE_ID INTEGER,
    APP_ID INTEGER,
    STORE_ID VARCHAR2(255) NOT NULL,
    FOREIGN KEY(APP_ID) REFERENCES APM_APP(APP_ID) ON DELETE CASCADE,
    PRIMARY KEY (APP_STORE_ID)
)
/

CREATE SEQUENCE APM_EXTERNAL_STORES_SEQUENCE START WITH 1 INCREMENT BY 1
/

CREATE OR REPLACE TRIGGER APM_EXTERNAL_STORES_TRIGGER
		    BEFORE INSERT
                    ON APM_EXTERNAL_STORES
                    REFERENCING NEW AS NEW
                    FOR EACH ROW
                    BEGIN
                    SELECT APM_EXTERNAL_STORES_SEQUENCE.nextval INTO :NEW.APP_STORE_ID FROM dual;
                    END;
/