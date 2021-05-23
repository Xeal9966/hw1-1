//TRIGGERS

//calcola totale restituire

delimiter //
drop trigger if exists calc_tot_restit;
create trigger calc_tot_restit
before insert on prestito
for each row
begin
set NEW.Totale_Restituire = NEW.Somma + NEW.Somma * (NEW.TassoInteresse/100);
end//
delimiter ;


//aggiorna capitale restituito
delimiter //
drop trigger if exists agg_rata;
create trigger agg_rata
after insert on rata 
for each row
begin
update prestito set capitale_restituito = capitale_restituito + NEW.somma
where prestito.id_prestito = NEW.id_prestito;
end //
delimiter ;


//controlla inserimento bancomat (MAX 1 per intestatario)
delimiter //
drop trigger if exists controllo_bancomat ;
create trigger controllo_bancomat
before insert on carta
for each row 
begin
declare msg2 varchar(255);
set msg2 = "Numero massimo di bancomat raggiunto per questo conto";
if ((select count(*) from carta c, TipoDiCarta tc where tc.Tipo = "bancomat" and c.id_conto = NEW.`ID_conto`) >= (select  count(*) from sottoscrizione where id_conto =  NEW.`ID_Conto`))
then 
	signal sqlstate '45000' 
    set message_text = msg2;
end if;
end //
delimiter ;

insert into carta(Numero,Mese, Anno, CVV, PIN, ID_Carta, ID_Conto)
VALUES('5189804083117512', '12', '2022', '707', '1554', '3', '2');


//aggiorna saldo movimenti
delimiter //
drop trigger if exists agg_saldo_movimenti;
create trigger agg_saldo_movimenti
before insert on movimento
for each row
begin
declare msg1 varchar(255);
set msg1 = "Saldo insufficiente o superato limite";
IF (New.`Importo` > (
	select saldo from carta ca, conto co where ca.numero = NEW.`Numero` and ca.id_conto = co.id_conto))
then
    signal sqlstate '45000' 
    set message_text = msg1;
elseif (New.`Importo` > (
	select tc.Max_Giornaliero from TipoDiCarta tc, carta c where c.ID_Carta = tc.ID and c.numero = NEW.`Numero`))
then 
	signal sqlstate '45000' 
    set message_text = msg1;
else update conto set saldo = saldo - NEW.`Importo`;
end if;
end //
delimiter ;

insert into movimento(Importo, Data, Numero)
VALUES('1000000', '2020-12-22', '5189807302607437');


insert into movimento(Importo, Data, Numero)
VALUES('50', '2020-12-22', '5189807302607437');


//aggiorna saldo operazioni

delimiter //
drop trigger if exists aggiorna_saldo_operazioni ;
create trigger aggiorna_saldo_operazioni
before insert on operazione
for each row 
begin
update conto set saldo = 
CASE 
when NEW.`Tipo` = 'Versamento' then saldo + NEW.`Somma` 
else  saldo +NEW.`Somma` 
end
where id_conto = NEW.`Id_Conto`;
end //
delimiter ;

insert into operazione(Data, Somma, Tipo, ID_Conto, ID_Filiale)
VALUES ('2020-12-22', '10', 'Versamento', '5', '1');




//controlla se il conto è di tipo "a pacchetto" prima di assegnare una cassetta
delimiter //
drop trigger if exists impedisciInserimentoCassetta;
create trigger impedisciInserimentoCassetta
before update on CassettaDiSicurezza
for each row 
begin
declare msg varchar(255);
set msg = "Il cliente non possiede un conto di tipo a pacchetto";
if ( NEW.`ID_Conto` not in(
	select id_conto
	from conto 
	where tipo = "a pacchetto"
))
then 
    signal sqlstate '45000' 
    set message_text = msg;
end if;
end //

call assegna_cassetta('1c', 1, 6, '2020-12-11');




//calcola costi mensili conto

delimiter //
drop trigger if exists calc_costo_mensile1;
create trigger calc_costo_mensile1
before update on conto
for each row 
begin
if (New.Tipo <> Old.Tipo)  then 
set NEW.Costo_Mensile = CASE 
		when NEW.tipo = 'a pacchetto' then OLD.costo_mensile + 40
		else OLD.costo_mensile - 40
END;
end if;
end //
delimiter ;

update conto set tipo = "A pacchetto" where id_conto = 6;


delimiter //
drop trigger if exists calc_costo_mensile;
create trigger calc_costo_mensile
before insert on conto
for each row
begin 
set NEW.Costo_Mensile = CASE 
	when NEW.tipo = 'a pacchetto' then '70'
	else '30'
end;
end //
delimiter ;

INSERT INTO conto (Saldo, Tipo)
VALUES ('2344','Ordinario');
	
//calcola costo cassetta in base a livello di sicurezza

delimiter //
drop trigger if exists calcola_costo_cassetta;
create trigger calcola_costo_cassetta
before insert on CassettaDiSicurezza
for each row 
begin 
set NEW.costo = 20 * NEW.Livello_Sicurezza;
end//
delimiter ;

INSERT INTO CassettaDiSicurezza(ID_Filiale, Posto, Livello_Sicurezza)
VALUES('13', '1C', 3 );



//EVENT

//Ogni 20 secondi salva il saldo in una tabella fittizia
delimiter //
drop event if exists salvasaldo;
CREATE EVENT salvasaldo
    ON SCHEDULE EVERY 20 SECOND
	DO
	insert into t_salva_saldo(id_conto, mese, anno, saldo, d_t) 
	select id_conto, MONTH(CURRENT_DATE()), YEAR(CURRENT_DATE()), saldo, CURRENT_TIMESTAMP from conto //
delimiter ;


// PROCEDURES 

//Stampare tutti i bancomat associati a conti cointestati

delimiter //
drop procedure if exists stampa_bancomat_coint;
create procedure stampa_bancomat_coint ()
begin
drop temporary table if exists temp1;
create temporary table temp1 (`Numero` VARCHAR(16) ,`Mese` VARCHAR(2),`Anno` VARCHAR(4),`CVV` VARCHAR(4) , `PIN` VARCHAR(6), `Tipo` VARCHAR(25), `ID_Conto` int);
insert into temp1
	select  c.numero, c.mese, c.anno, c.cvv, c.pin , tc.Tipo, c.id_conto
	from Carta c, TipoDiCarta tc
	where c.ID_Carta = tc.ID and tc.tipo = "Bancomat" and c.id_conto in (
		select s.id_conto
		from  sottoscrizione s 
		group by s.id_conto
		having count(*) >=2
		);
select * from temp1;
end //
delimiter ;

call stampa_bancomat_coint ();

//Dato il numero di conto stampare saldo attuale e il saldo medio per anno 

delimiter //
drop procedure if exists stampa_saldo;
create procedure stampa_saldo(in n_conto int)
begin
drop table if exists temp2;
create table temp2(SaldoAttuale int);
insert into temp2 select saldo from conto where id_conto = n_conto;
drop table if exists temp3;
create table temp3(SaldoMedio int, Anno varchar(4));
insert into temp3 
select avg(saldo), anno from StoricoSaldo 
where id_conto = n_conto
group by anno;
select * from temp2;
select * from temp3;
end //
delimiter ;


// Dato un determinato prestito , aggiornare la somma richiesta e quindi il totale da restituire

delimiter //
drop procedure if exists aggiorna_totale_restituire;
create procedure aggiorna_totale_restituire(in v_id_prestito int, in nuova_somma int)
begin 
update prestito set somma = nuova_somma, Totale_Restituire = (nuova_somma + (nuova_somma * TassoInteresse/100)) where id_prestito = v_id_prestito;
end //
delimiter ;

call aggiorna_totale_restituire(1, 4000);

//Dato un determinato prestito , stampare il valore del capitale restituito
delimiter //
drop procedure if exists stampa_capitale;
create procedure stampa_capitale(in v_id_prestito int)
begin 
drop table if exists temp6;
create table temp6(Capitale_Restituito int);
insert into temp6 
select capitale_restituito from prestito where id_prestito = v_id_prestito;
select * from temp6;
end //
delimiter ;

call stampa_capitale(1);

//assegna cassetta
delimiter //
drop procedure if exists assegna_cassetta;
create procedure assegna_cassetta 
(in v_posto varchar(4), in v_id_filiale int, in v_id_conto int, in v_data date)
begin
update CassettaDiSicurezza set DataAcquisizione = v_data, id_conto = v_id_conto
where v_posto = posto and ID_Filiale = v_id_filiale;
update conto set costo_mensile = costo_mensile + (select costo from CassettaDiSicurezza where id_filiale = v_id_filiale and posto = v_posto ) where id_conto = v_id_conto;
end//
delimiter ;

call assegna_cassetta('1c', 1, 7, '2020-12-11');

//svuota cassetta

delimiter //
drop procedure if exists svuota_cassetta;
create procedure svuota_cassetta 
(in v_posto varchar(4), in v_id_filiale int)
begin
update conto set costo_mensile = costo_mensile - (select costo from CassettaDiSicurezza where posto = v_posto and id_filiale = v_id_filiale) where id_conto = (select id_conto from CassettaDiSicurezza where id_filiale = v_id_filiale and posto = v_posto);
update CassettaDiSicurezza set DataAcquisizione = null, id_conto = null
where v_posto = posto and ID_Filiale = v_id_filiale;
end //
delimiter ;

call svuota_cassetta('1c', 1);


// VIEWS 



//mostra conti cointestati
create view contiCointestati as
select s.id_conto
from  sottoscrizione s 
group by s.id_conto
having count(*) >=2;


//mostra prestiti con relative rate
create view prestiti_rate as 
select p.*
from prestito p, rata r 
where p.id_prestito = r.id_prestito;


conti che non hanno avuto movimenti nell'ultimo mese'

select id_conto from conto where id_conto not in (
select c.id_conto from conto c, carta ca, movimento m where m.numero = ca.numero and ca.id_conto = c.id_conto and MONTH(m.data) = 12);


