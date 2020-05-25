--A user opens an account.
INSERT INTO ACCOUNT VALUES('21', 'uaubri0@cyberchimps.com', 'NLHokv0', 'Ursuline Aubri', '9866 Ridgeview Junction', '236105411', '341000165174', sysdate, sysdate);
INSERT INTO BALANCE VALUES('21', '1' ,0, sysdate, sysdate);
INSERT INTO BALANCE VALUES('21', '2' ,0, sysdate, sysdate);
INSERT INTO BALANCE VALUES('21', '3' ,0, sysdate, sysdate);
COMMIT;

--The user deposits money.
SELECT * FROM BALANCE WHERE ACCOUNT_ID = '21' and (CURRENCY_ID = '1' OR CURRENCY_ID = '2');
INSERT INTO TRANSACTION VALUES('11', 'DEPOSIT', '21', '2', 0, '2', 10000, sysdate, sysdate, '236105411', '341000165174', null, null, null, null, null, null);
UPDATE BALANCE SET BALANCE=10000, UPDATED_DATE = sysdate WHERE ACCOUNT_ID = '21' and CURRENCY_ID = '2'; 
COMMIT;

--The user places an order.
SELECT * FROM ORDER_ WHERE ORDER_CURRENCY_ID = '1' and ORIGINAL_CURRENCY_ID = '2' and STATUS = 'ACTIVE';
INSERT INTO ORDER_ VALUES('12', '21', 'BUY', '1', 7100, 0.1, '2', 710, 'ACTIVE', sysdate, sysdate);
COMMIT;

--The order is settled.
SELECT * FROM ORDER_ WHERE ORDER_CURRENCY_ID = '1' and ORIGINAL_CURRENCY_ID = '2' and STATUS = 'ACTIVE';
INSERT INTO ORDER_ VALUES('13', '1', 'SELL', '1', 7100, 0.1, '2', 710, 'SETTLED', sysdate, sysdate);
UPDATE ORDER_ SET STATUS = 'SETTLED', UPDATED_DATE = sysdate WHERE ORDER_ID = '12';
INSERT INTO TRANSACTION VALUES('12', 'SETTLEMENT', '21', '2', 7100, '1', 0.1, sysdate, sysdate, null, null, null, '12', '13', null, null, null);
INSERT INTO TRANSACTION VALUES('13', 'SETTLEMENT', '1', '1', 0.1, '2', 7100, sysdate, sysdate, null, null, null, '13', '12', null, null, null);
SELECT * FROM BALANCE WHERE ACCOUNT_ID = '21' and (CURRENCY_ID = '1' OR CURRENCY_ID = '2');
SELECT * FROM BALANCE WHERE ACCOUNT_ID = '1' and (CURRENCY_ID = '1' OR CURRENCY_ID = '2');
UPDATE BALANCE SET BALANCE = 0.1, UPDATED_DATE = sysdate WHERE ACCOUNT_ID = '21' and CURRENCY_ID = '1';
UPDATE BALANCE SET BALANCE = 2900, UPDATED_DATE = sysdate WHERE ACCOUNT_ID = '21' and CURRENCY_ID = '2';
UPDATE BALANCE SET BALANCE = 666124.9, UPDATED_DATE = sysdate WHERE ACCOUNT_ID = '1' and CURRENCY_ID = '1';
UPDATE BALANCE SET BALANCE = 913351, UPDATED_DATE = sysdate WHERE ACCOUNT_ID = '1' and CURRENCY_ID = '2';
COMMIT;

--The user withdraws cryptocurrency.
SELECT * FROM BALANCE WHERE ACCOUNT_ID = '21' and CURRENCY_ID = '1';
UPDATE BALANCE SET BALANCE = 0, UPDATED_DATE = sysdate WHERE ACCOUNT_ID = '21' and CURRENCY_ID = '1';
INSERT INTO TRANSACTION VALUES('14', 'WITHDRAW', '21', '1', 0.1, '1', 0, sysdate, sysdate, null, null, null, null, null, null, null, '18MnkkPLjQZJiZvQbjcUbrx56LCkRyXFXP');
COMMIT;
