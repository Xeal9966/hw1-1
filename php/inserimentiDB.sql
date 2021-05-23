CREATE TABLE `User` (
	`CF` VARCHAR(20) NOT NULL,
	`User` ADD `Email` VARCHAR(40) NOT NULL,
	`Name` VARCHAR(50) NOT NULL,
	`Surname` VARCHAR(50) NOT NULL,
	`Residence` VARCHAR(40) NOT NULL,
	`Phone` VARCHAR(20) NOT NULL, 
	`Passwd` VARCHAR(120) NOT NULL,
	`Profile_Img` VARCHAR(30) DEFAULT 'default.jpg', 
	`Dob` DATE NOT NULL,
	PRIMARY KEY (`CF`)
) ENGINE=InnoDB;

CREATE TABLE `Account` (
	`Account_ID` INT NOT NULL AUTO_INCREMENT,
	`Fee` FLOAT NOT NULL,
	`Balance` INT NOT NULL DEFAULT '0',
	`Type` VARCHAR(30) NOT NULL,
	PRIMARY KEY (`Account_ID`)
) ENGINE=InnoDB;

CREATE TABLE `Subscription` (
	`CF` VARCHAR(16) NOT NULL,
	`Account_ID` INT NOT NULL,
	`StartDate` DATE NOT NULL DEFAULT CURRENT_TIMESTAMP;,
	PRIMARY KEY (`CF`, `Account_ID`),
	FOREIGN KEY (Account_ID) REFERENCES Account(Account_ID),
	FOREIGN KEY (CF) REFERENCES User(CF),
	index idx_1(Account_ID),
	index idx_2(CF)
) ENGINE=InnoDB;

CREATE TABLE `SafeDepositBox` (
	`Branch_ID` INT NOT NULL,
	`Sector` VARCHAR(4) NOT NULL,
	`Fee` SMALLINT NOT NULL,
	`Level` TINYINT NOT NULL,
	`StartDate` DATE,
	`Account_ID` INT , 
	PRIMARY KEY (`Branch_ID`, `Sector`),
	FOREIGN KEY (Branch_ID) REFERENCES Branch(Branch_ID),
	FOREIGN KEY (Account_ID) REFERENCES Account(Account_ID),
	index idx_4(Account_ID),
	index idx_5(Branch_ID)
) ENGINE=InnoDB;


CREATE TABLE `Branch` (
	`Branch_ID` INT NOT NULL AUTO_INCREMENT,
	`City` VARCHAR(40) NOT NULL,
	`Address` VARCHAR(70) NOT NULL,
	PRIMARY KEY (`Branch_ID`)
) ENGINE=InnoDB;


CREATE TABLE `Loan` (
	`Loan_ID` INT NOT NULL AUTO_INCREMENT,
	`Amount` MEDIUMINT NOT NULL,
	`Tax` TINYINT NOT NULL,
	`StartDate` DATE NOT NULL,
	`Returned` MEDIUMINT NOT NULL DEFAULT '0',
	`Total` MEDIUMINT NOT NULL,
	`Fee` INT NOT NULL DEFAULT '150', 
	`Account_ID` INT NOT NULL,
	`Favorite` BOOLEAN NOT NULL DEFAULT '0',
	PRIMARY KEY (`Loan_ID`),
	FOREIGN KEY (Account_ID) REFERENCES Account(Account_ID),
	index idx_3(Account_ID)
) ENGINE=InnoDB;


CREATE TABLE `Card_Type` (
	`ID` INT NOT NULL AUTO_INCREMENT,
	`Name` VARCHAR(30) NOT NULL,
	`Type` VARCHAR(30) NOT NULL,
	`Vendor` VARCHAR(20) NOT NULL,
	`Monthly_Max` INT NOT NULL,
	`Daily_Max` INT NOT NULL,
	`Tax` INT NOT NULL,
	PRIMARY KEY (`ID`)
) ENGINE=InnoDB;

CREATE TABLE `History` (
	`Account_ID` INT NOT NULL,
	`Month`  VARCHAR(2) NOT NULL,
	`Year` YEAR(4) NOT NULL,
	`Balance` INT NOT NULL,
	PRIMARY KEY (`Account_ID`, `Month`, `Year`),
	FOREIGN KEY (Account_ID) REFERENCES Account(Account_ID),
	index idx_8(Account_ID)
) ENGINE=InnoDB;

CREATE TABLE `Transaction` (
	`Transaction_ID` INT NOT NULL AUTO_INCREMENT,
	`InOut` VARCHAR(4) NOT NULL,
	`Agent` VARCHAR(60)) NOT NULL, 
	`Type` VARCHAR (30) NOT NULL, 
	`Amount` FLOAT NOT NULL,
	`Date` DATE NOT NULL,
	`Number` VARCHAR(16) NOT NULL,
	PRIMARY KEY (`Transaction_ID`),
	FOREIGN KEY (Number) REFERENCES Card(Number),
	index idx_11(Number)
) ENGINE=InnoDB;

CREATE TABLE `Card` (
	`Status` VARCHAR (20) NOT NULL DEFAULT 'Active',
	`Number` VARCHAR(16) NOT NULL,
	`Month` VARCHAR(2) NOT NULL,
	`Year` VARCHAR(4) NOT NULL,
	`CVV` VARCHAR(4) NOT NULL,
	`PIN` VARCHAR(6) NOT NULL,
	`Balance` INT DEFAULT NULL, 
	`Payment_Date` VARCHAR(2),
	`Card_ID` INT NOT NULL,
	`Account_ID` INT NOT NULL,
	`ActivationDate` DATE NOT NULL,
	`Favorite` BOOLEAN NOT NULL DEFAULT '0',
	PRIMARY KEY (`Number`), 
	FOREIGN KEY (Card_ID) REFERENCES Card_Type(ID),
	FOREIGN KEY (Account_ID) REFERENCES Account(Account_ID),
	index idx_9(Account_ID),
	index idx_10(Card_ID)
) ENGINE=InnoDB;










CREATE TABLE `Rata` (
	`ID_Pagamento` INT NOT NULL AUTO_INCREMENT,
	`Amount` MEDIUMINT NOT NULL,
	`Data` DATE NOT NULL,
	`Loan_ID` INT NOT NULL, 
	PRIMARY KEY (`ID_Pagamento`),
	FOREIGN KEY (Loan_ID) REFERENCES Loan(Loan_ID)
) ENGINE=InnoDB;




CREATE TABLE `Operazione` (
	`ID_Operazione` INT NOT NULL AUTO_INCREMENT,
	`Data` DATE NOT NULL,
	`Amount` INT NOT NULL,
	`Type` VARCHAR(25) NOT NULL,
	`Account_ID` INT NOT NULL,
	`Branch_ID` INT NOT NULL,
	PRIMARY KEY (`ID_Operazione`),
	FOREIGN KEY (Branch_ID) REFERENCES Branch(Branch_ID),
	FOREIGN KEY (Account_ID) REFERENCES Account(Account_ID),
	index idx_6(Account_ID),
	index idx_7(Branch_ID)
) ENGINE=InnoDB;









// INSERIMENTO


// CLIENTE

INSERT INTO cliente (CF, Name, Cognome, Residenza, Data_Nascita)
VALUES ('TRVMNL49S57H501A','Manuela','Trevisano', 'Roma', '1945-11-17');

INSERT INTO cliente (CF, Name, Cognome, Residenza, Data_Nascita)
VALUES ('BNVNLM70B12F839T','Anselmo ','Beneventi', 'Napoli', '1970-02-12');

INSERT INTO cliente (CF, Name, Cognome, Residenza, Data_Nascita)
VALUES ('MNCNZR72A15L219F','Nazzareno ','Mancini', 'Torino', '1972-01-15');

INSERT INTO cliente (CF, Name, Cognome, Residenza, Data_Nascita)
VALUES ('CCCFNZ66C41H501I','Fiorenza','Cocci', 'Roma', '1966-03-01');

INSERT INTO cliente (CF, Name, Cognome, Residenza, Data_Nascita)
VALUES ('LMBGCM60R04H501N','Giacomo','Lombardo', 'Roma', '1960-10-04');

INSERT INTO cliente (CF, Name, Cognome, Residenza, Data_Nascita)
VALUES ('CRMSVS80P19F205X','Silvestro ','Cremonesi', 'Milano', '1980-09-19');

INSERT INTO cliente (CF, Name, Cognome, Residenza, Data_Nascita)
VALUES ('DLLFNC82E47F205T','Francesca','Dellucci', 'Milano', '1982-05-07');

INSERT INTO cliente (CF, Name, Cognome, Residenza, Data_Nascita)
VALUES ('RCRCLL90B57L781K','Camilla ','Arcuri', 'Verona', '1990-02-17');

INSERT INTO cliente (CF, Name, Cognome, Residenza, Data_Nascita)
VALUES ('FRNLDA59T20D612B','Aldo','Fiorentini', 'Firenze', '1959-12-20');

INSERT INTO cliente (CF, Name, Cognome, Residenza, Data_Nascita)
VALUES ('MZZMNL47M08A326E','Emanuele','Mazzi', 'Aosta', '1947-08-08');



//Account

INSERT INTO Account (Fee_Mensile, Balance, Type)
VALUES ('30','5780','Ordinario');

INSERT INTO Account (Fee_Mensile, Balance, Type)
VALUES ('30','10506','Ordinario');

INSERT INTO Account (Fee_Mensile, Balance, Type)
VALUES ('30','15401','Ordinario');

INSERT INTO Account (Fee_Mensile, Balance, Type)
VALUES ('30','2506','Ordinario');

INSERT INTO Account (Fee_Mensile, Balance, Type)
VALUES ('30','8522','Ordinario');

INSERT INTO Account (Fee_Mensile, Balance, Type)
VALUES ('30','25609','Ordinario');

INSERT INTO Account (Fee_Mensile, Balance, Type)
VALUES ('70','87389','A pacchetto');

INSERT INTO Account (Fee_Mensile, Balance, Type)
VALUES ('70','32140','A pacchetto');


// SOTTOSCRIZIONE
INSERT INTO sottoscrizione (CF, Account_ID, Data_Sottoscrizione)
VALUES ('TRVMNL49S57H501A','1','2005-10-01');

INSERT INTO sottoscrizione (CF, Account_ID, Data_Sottoscrizione)
VALUES ('CCCFNZ66C41H501I','2','2010-01-07');

INSERT INTO sottoscrizione (CF, Account_ID, Data_Sottoscrizione)
VALUES ('LMBGCM60R04H501N','2','2010-01-07');

INSERT INTO sottoscrizione (CF, Account_ID, Data_Sottoscrizione)
VALUES ('CRMSVS80P19F205X','7','2008-08-01');

INSERT INTO sottoscrizione (CF, Account_ID, Data_Sottoscrizione)
VALUES ('DLLFNC82E47F205T','7','2008-08-01');

INSERT INTO sottoscrizione (CF, Account_ID, Data_Sottoscrizione)
VALUES ('BNVNLM70B12F839T','3','2015-10-15');

INSERT INTO sottoscrizione (CF, Account_ID, Data_Sottoscrizione)
VALUES ('RCRCLL90B57L781K','4','2000-02-11');

INSERT INTO sottoscrizione (CF, Account_ID, Data_Sottoscrizione)
VALUES ('MNCNZR72A15L219F','5','2019-12-10');

INSERT INTO sottoscrizione (CF, Account_ID, Data_Sottoscrizione)
VALUES ('FRNLDA59T20D612B','6','2013-01-18');

INSERT INTO sottoscrizione (CF, Account_ID, Data_Sottoscrizione)
VALUES ('MZZMNL47M08A326E','8','2014-07-07');

//Branch

INSERT INTO Branch (City, Address)
VALUES ('Roma','Via dei cerchi 92');

INSERT INTO Branch (City, Address)
VALUES ('Roma','Via del casaletto 200');

INSERT INTO Branch (City, Address)
VALUES ('Roma','Via Arno 36');

INSERT INTO Branch (City, Address)
VALUES ('Firenze','Via Toselli 99');

INSERT INTO Branch (City, Address)
VALUES ('Firenze','Via Traversari 81');

INSERT INTO Branch (City, Address)
VALUES ('Napoli','Via Loffredi 2');

INSERT INTO Branch (City, Address)
VALUES ('Napoli','Via Duomo 81');

INSERT INTO Branch (City, Address)
VALUES ('Aosta','Via Chambery 5');

INSERT INTO Branch (City, Address)
VALUES ('Verona','Via Pontida 22');

INSERT INTO Branch (City, Address)
VALUES ('Torino','Via Perrone 10');

INSERT INTO Branch (City, Address)
VALUES ('Torino','Via Guastalla 33');

INSERT INTO Branch (City, Address)
VALUES ('Milano','Viale Montenero 44');

INSERT INTO Branch (City, Address)
VALUES ('Milano','Via Vignola 2');

//Type DI Card
INSERT INTO Card_Type (Name, Type, Year_Max, Monthly_Max, Daily_Max, Tax)
VALUES ('Credit Gold','Credito','1000000','150000','15000','7');

INSERT INTO Card_Type (Name, Type, Year_Max, Monthly_Max, Daily_Max, Tax)
VALUES ('Credit Five','Credito','500000','75000','7500','5');

INSERT INTO Card_Type (Name, Type, Year_Max, Monthly_Max, Daily_Max, Tax)
VALUES ('Easy Debit','Debito','5000','1000','500','0');

INSERT INTO Card_Type (Name, Type, Year_Max, Monthly_Max, Daily_Max, Tax)
VALUES ('Superflash','Debito','9000','2000','750','0');

INSERT INTO Card_Type (Name, Type, Year_Max, Monthly_Max, Daily_Max, Tax)
VALUES ('Easy Bancomat','Bancomat','20000','6000','2500','0');



//Card

INSERT INTO Card (Number, Month, Year, CVV, PIN, Payment_Date, Card_ID, Account_ID)
VALUES ('5189807376736385','07', '2025','874','1235', NULL ,'3','1');

INSERT INTO Card (Number, Month, Year, CVV, PIN, Payment_Date, Card_ID, Account_ID)
VALUES ('5189807320836224','03', '2024','335','4830', NULL ,'3','2');

INSERT INTO Card (Number, Month, Year, CVV, PIN, Payment_Date, Card_ID, Account_ID)
VALUES ('5189807302607437','08', '2023','112','1568', NULL ,'3','2');

INSERT INTO Card (Number, Month, Year, CVV, PIN, Payment_Date, Card_ID, Account_ID)
VALUES ('5189807372000281','10', '2022','055','0548', NULL ,'3','3');

INSERT INTO Card (Number, Month, Year, CVV, PIN, Payment_Date, Card_ID, Account_ID)
VALUES ('5189807375582772','02', '2021','587','3258', NULL ,'3','4');

INSERT INTO Card (Number, Month, Year, CVV, PIN, Payment_Date, Card_ID, Account_ID)
VALUES ('5189807338471048','05', '2023','861','9884', NULL ,'3','5');

INSERT INTO Card (Number, Month, Year, CVV, PIN, Payment_Date, Card_ID, Account_ID)
VALUES ('5189807357304633','12', '2025','014','1538', NULL ,'3','6');

INSERT INTO Card (Number, Month, Year, CVV, PIN, Payment_Date, Card_ID, Account_ID)
VALUES ('5189807368225488','01', '2025','233','5687', NULL ,'3','7');

INSERT INTO Card (Number, Month, Year, CVV, PIN, Payment_Date, Card_ID, Account_ID)
VALUES ('5189807361564503','04', '2024','888','1568', NULL ,'3','7');

INSERT INTO Card (Number, Month, Year, CVV, PIN, Payment_Date, Card_ID, Account_ID)
VALUES ('5189807312408834','05', '2024','158','1598', NULL ,'3','8');


INSERT INTO Card (Number, Month, Year, CVV, PIN, Payment_Date, Card_ID, Account_ID)
VALUES ('5189827307116804','09', '2024','158','1598', NULL ,'1','7');

INSERT INTO Card (Number, Month, Year, CVV, PIN, Payment_Date, Card_ID, Account_ID)
VALUES ('5189827800622050','11', '2025','158','1598', NULL ,'2','1');

INSERT INTO Card (Number, Month, Year, CVV, PIN, Payment_Date, Card_ID, Account_ID)
VALUES ('5189827868637313','12', '2023','158','1598', NULL ,'4','3');

INSERT INTO Card (Number, Month, Year, CVV, PIN, Payment_Date, Card_ID, Account_ID)
VALUES ('5189827808175515','08', '2021','158','1598', NULL ,'5','5');

INSERT INTO Card (Number, Month, Year, CVV, PIN, Payment_Date, Card_ID, Account_ID)
VALUES ('5189827863074132','02', '2024','158','1598', NULL ,'5','4');

INSERT INTO Card (Number, Month, Year, CVV, PIN, Payment_Date, Card_ID, Account_ID)
VALUES ('5189827850477405','01', '2022','158','1598', NULL ,'4','2');



// Transaction

INSERT INTO Transaction (Amount, Data, Number)
VALUES ('15','2020-01-08','5189827850477405');

INSERT INTO Transaction (Amount, Data, Number)
VALUES ('20','2020-02-07','5189807312408834');

INSERT INTO Transaction (Amount, Data, Number)
VALUES ('1000','2020-03-06','5189827800622050');

INSERT INTO Transaction (Amount, Data, Number)
VALUES ('150','2020-04-05','5189807357304633');

INSERT INTO Transaction (Amount, Data, Number)
VALUES ('5','2020-05-04','5189807372000281');

INSERT INTO Transaction (Amount, Data, Number)
VALUES ('18','2020-06-03','5189807372000281');

INSERT INTO Transaction (Amount, Data, Number)
VALUES ('55','2020-07-02','5189827850477405');

INSERT INTO Transaction (Amount, Data, Number)
VALUES ('60','2020-08-01','5189807302607437');
	

//STORICO Balance
INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('1','01','2020', '5000');
INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('1','02','2020', '8100');
INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('1','03','2020', '6000');
INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('1','12','2019', '3600');
INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('1','12','2018', '5841');


INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('2','01','2020', '9806');
INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('2','02','2020', '7805');
INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('2','03','2020', '8885');
INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('2','12','2019', '6005');
INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('2','12','2018', '7005');

INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('3','01','2020', '12550');
INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('3','02','2020', '11785');
INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('3','03','2020', '15600');
INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('3','12','2019', '17885');
INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('3','12','2018', '25006');

INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('4','01','2020', '5000');
INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('4','02','2020', '3500');
INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('4','03','2020', '2005');
INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('4','12','2019', '3688');
INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('4','12','2018', '4192');

INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('5','01','2020', '8900');
INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('5','02','2020', '5685');
INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('5','03','2020', '7560');
INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('5','12','2019', '6658');
INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('5','12','2018', '8688');

INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('6','01','2020', '28840');
INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('6','02','2020', '27898');
INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('6','03','2020', '25658');
INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('6','12','2019', '32500');
INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('6','12','2018', '31400');

INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('7','01','2020', '88900');
INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('7','02','2020', '85006');
INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('7','03','2020', '90004');
INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('7','12','2019', '92000');
INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('7','12','2018', '94000');

INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('8','01','2020', '33400');
INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('8','02','2020', '30000');
INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('8','03','2020', '29500');
INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('8','12','2019', '29800');
INSERT INTO History (Account_ID, Month, Year, Balance)
VALUES ('8','12','2018', '31544');


// CASSETTA DI SICUREZZA

INSERT INTO SafeDepositBox (Branch_ID, Sector, Level, StartDate, Account_ID)
VALUES ('1','1A','1','2018-10-10','8');
INSERT INTO SafeDepositBox (Branch_ID, Sector, Level, StartDate, Account_ID)
VALUES ('1','1B','2',NULL, NULL);
INSERT INTO SafeDepositBox (Branch_ID, Sector,  Level, StartDate, Account_ID)
VALUES ('1','1C','3',NULL, NULL);

INSERT INTO SafeDepositBox (Branch_ID, Sector, Level, StartDate, Account_ID)
VALUES ('13','1A','2','2019-01-08', '7');
INSERT INTO SafeDepositBox (Branch_ID, Sector, Level, StartDate, Account_ID)
VALUES ('13','1B','3',NULL, NULL);

//OPERAZIONE

INSERT INTO Operazione (Data, Amount, Type, Account_ID, Branch_ID)
VALUES ('2019-08-19','500', 'Prelievo', '1', '1');

INSERT INTO Operazione (Data, Amount, Type, Account_ID, Branch_ID)
VALUES ('2020-09-09','100', 'Versamento', '2', '6');

INSERT INTO Operazione (Data, Amount, Type, Account_ID, Branch_ID)
VALUES ('2020-05-29','20', 'Prelievo', '5', '10');

INSERT INTO Operazione (Data, Amount, Type, Account_ID, Branch_ID)
VALUES ('2020-05-26','200', 'Versamento', '7', '11');

INSERT INTO Operazione (Data, Amount, Type, Account_ID, Branch_ID)
VALUES ('2020-02-19','500', 'Versamento', '8', '3');

INSERT INTO Operazione (Data, Amount, Type, Account_ID, Branch_ID)
VALUES ('2020-02-18','100', 'Versamento', '4', '6');

INSERT INTO Operazione (Data, Amount, Type, Account_ID, Branch_ID)
VALUES ('2020-02-05','80', 'Prelievo', '3', '7');

INSERT INTO Operazione (Data, Amount, Type, Account_ID, Branch_ID)
VALUES ('2019-12-20','70', 'Prelievo', '3', '8');

INSERT INTO Operazione (Data, Amount, Type, Account_ID, Branch_ID)
VALUES ('2019-08-26','556', 'Versamento', '6', '5');

INSERT INTO Operazione (Data, Amount, Type, Account_ID, Branch_ID)
VALUES ('2019-04-26','800', 'Prelievo', '6', '4');

INSERT INTO Operazione (Data, Amount, Type, Account_ID, Branch_ID)
VALUES ('2020-02-13','100', 'Versamento', '7', '3');

INSERT INTO Operazione (Data, Amount, Type, Account_ID, Branch_ID)
VALUES ('2020-05-21','300', 'Versamento', '8', '4');

INSERT INTO Operazione (Data, Amount, Type, Account_ID, Branch_ID)
VALUES ('2020-06-18','400', 'Versamento', '1', '7');

INSERT INTO Operazione (Data, Amount, Type, Account_ID, Branch_ID)
VALUES ('2020-07-24','10', 'Prelievo', '2', '9');

INSERT INTO Operazione (Data, Amount, Type, Account_ID, Branch_ID)
VALUES ('2020-07-27','50', 'Prelievo', '3', '2');

INSERT INTO Operazione (Data, Amount, Type, Account_ID, Branch_ID)
VALUES ('2020-08-21','70', 'Prelievo', '4', '5');

INSERT INTO Operazione (Data, Amount, Type, Account_ID, Branch_ID)
VALUES ('2020-10-12','80', 'Prelievo', '5', '4');

INSERT INTO Operazione (Data, Amount, Type, Account_ID, Branch_ID)
VALUES ('2020-11-13','1000', 'Prelievo', '5', '1');


// Loan

INSERT INTO Loan (Amount, Tax, StartDate, Account_ID)
VALUES ('2000','8','2020-07-07', '1');

INSERT INTO Loan (Amount, Tax, StartDate, Account_ID)
VALUES ('5000','7','2020-07-07', '3');

INSERT INTO Loan (Amount, Tax, StartDate, Account_ID)
VALUES ('1500','12','2020-07-07', '5');


// RATA

INSERT INTO rata (Amount, Data, Loan_ID)
VALUES ('100','2020-01-01','10');

INSERT INTO rata (Amount, Data, Loan_ID)
VALUES ('100','2020-02-01','10');

INSERT INTO rata (Amount, Data, Loan_ID)
VALUES ('100','2020-03-01','10');