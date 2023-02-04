--creare tabele
CREATE TABLE CLIENTI
(             id_client NUMBER(4) NOT NULL,
              nume VARCHAR2(30)NOT NULL,
              prenume VARCHAR2(30) NOT NULL,
              email VARCHAR2(40) NOT NULL,
              telefon VARCHAR2(10) NOT NULL,
              tara VARCHAR2(25) NOT NULL,
              localitate VARCHAR2(30) NOT NULL,
              adresa VARCHAR2(100),
              
              CONSTRAINT pk_client PRIMARY KEY(id_client),
              UNIQUE(telefon)
);
CREATE TABLE PLATI
(             id_plata NUMBER(4) NOT NULL,
              modalitate_plata VARCHAR2(10) CHECK (modalitate_plata='ramburs' OR modalitate_plata='card'),
              numar_card VARCHAR2(20),
              nume_detinator_card VARCHAR2(40),
              suma NUMBER(6) NOT NULL,
              CONSTRAINT pk_plata PRIMARY KEY(id_plata)
);
CREATE TABLE LIVRARI
(             id_livrare NUMBER(4) NOT NULL,
              numar VARCHAR2(10) NOT NULL,
              data DATE NOT NULL,
              firma_curierat VARCHAR2(40),
              status VARCHAR(30) CHECK(status='in depozit' OR status='in curs de livrare' OR status='livrata'),
              CONSTRAINT pk_livrare PRIMARY KEY(id_livrare)
);
CREATE TABLE DEPOZITE_PRODUSE
(             id_depozit NUMBER(4) NOT NULL,
              nume VARCHAR2(30) NOT NULL,
              locatie VARCHAR2(30),
              CONSTRAINT pk_depozit PRIMARY KEY(id_depozit)
);


CREATE TABLE FURNIZORI
(             id_furnizor NUMBER(4) NOT NULL,
              nume VARCHAR2(30)NOT NULL,
              adresa VARCHAR2(70) NOT NULL,
              email VARCHAR2(40) NOT NULL,
              telefon VARCHAR2(10) NOT NULL,
              
              CONSTRAINT pk_furnizor PRIMARY KEY(id_furnizor),
              UNIQUE(telefon)
);

CREATE TABLE DEPARTAMENTE
(             id_departament NUMBER(4) NOT NULL,
              nume VARCHAR2(30)NOT NULL,
              locatie VARCHAR2(70) NOT NULL,
              CONSTRAINT pk_departament PRIMARY KEY(id_departament)
);

CREATE TABLE ANGAJATI
(             id_angajat NUMBER(4) NOT NULL,
              id_departament NUMBER(4) NOT NULL,
              nume VARCHAR2(30) NOT NULL,
              prenume VARCHAR2(30) NOT NULL,
              salariu NUMBER(6) NOT NULL,
              email VARCHAR2(40) NOT NULL,
              telefon VARCHAR2(10) NOT NULL,
        
              CONSTRAINT pk_angajat PRIMARY KEY(id_angajat),
              CONSTRAINT fk_angajat FOREIGN KEY(id_departament) REFERENCES DEPARTAMENTE(id_departament),
              UNIQUE(telefon)
);

CREATE TABLE PRODUSE
(             id_produs NUMBER(4) NOT NULL,
              id_depozit NUMBER(4) NOT NULL,
              id_furnizor NUMBER(4) NOT NULL,
              nume VARCHAR2(30) NOT NULL,
              descriere VARCHAR2(200),
              stoc NUMBER(4),
              pret NUMBER(4),
              discount NUMBER(4,2) NOT NULL,
        
              CONSTRAINT pk_produs PRIMARY KEY(id_produs),
              CONSTRAINT fk1_angajat FOREIGN KEY(id_depozit) REFERENCES DEPOZITE_PRODUSE(id_depozit),
              CONSTRAINT fk2_angajat FOREIGN KEY(id_furnizor) REFERENCES FURNIZORI(id_furnizor)
);

CREATE TABLE COMENZI
(             id_comanda NUMBER(4) NOT NULL,
              id_client NUMBER(4)NOT NULL,
             
              id_angajat NUMBER(4)NOT NULL,
              id_plata NUMBER(4)NOT NULL,
              id_livrare NUMBER(4)NOT NULL,
              data DATE NOT NULL,
              cantitate NUMBER(4),
              
              CONSTRAINT fk1_comanda FOREIGN KEY(id_client) REFERENCES CLIENTI(id_client),
              
              CONSTRAINT fk2_comanda FOREIGN KEY(id_angajat) REFERENCES ANGAJATI(id_angajat),
              CONSTRAINT fk3_comanda FOREIGN KEY(id_plata) REFERENCES PLATI(id_plata),
              CONSTRAINT fk4_comanda FOREIGN KEY(id_livrare) REFERENCES LIVRARI(id_livrare),
              CONSTRAINT pk_comanda PRIMARY KEY(id_comanda)
);

CREATE TABLE COSURI_PRODUSE 
(           id_cos_produse NUMBER(4) NOT NULL,
            id_comanda NUMBER(4) NOT NULL,
            id_produs NUMBER(4) NOT NULL,
            
            CONSTRAINT fk1_cos_produse FOREIGN KEY(id_comanda) REFERENCES COMENZI(id_comanda),
            CONSTRAINT fk2_cos_produse FOREIGN KEY(id_produs) REFERENCES PRODUSE(id_produs),
            CONSTRAINT pk_cos_produse PRIMARY KEY(id_comanda, id_produs, id_cos_produse)
);
--inserari
INSERT INTO CLIENTI
    VALUES(1, 'Popescu', 'Dragos','pop@mail.com', '0752725387', 'Romania','Craiova', 'Str. N. Titulescu nr. 3, 303');
INSERT INTO CLIENTI
    VALUES(2, 'Comanescu', 'Bogdan','bog@mail.com', '0752725380', 'Romania','Vaslui', 'Str. Zambilelor nr. 7');
INSERT INTO CLIENTI
    VALUES(3, 'Dragu', 'Viorel','vio@mail.com', '0752725381', 'Belgia','Bruxelles', 'Str. Willem nr. 4');
INSERT INTO CLIENTI
    VALUES(4, 'Maxilu', 'Veronica','vera@mail.com', '0752725382', 'Spania','Zaragoza', 'Str. Zanahoria nr. 2, 20');
INSERT INTO CLIENTI
    VALUES(5, 'Adam', 'Anda','andadam@mail.com', '0752725383', 'Ungaria','Budapesta', 'Str. Kovacs nr. 4');
INSERT INTO CLIENTI
    VALUES(6,'Rosu','Daiana','rdai@mail.com','0876592919','Canada','Montreal','Str. Baker nr 5');
INSERT INTO CLIENTI
    VALUES(7,'Popescu','Mircea','popmir@mail.com','0876592920','Romania','Constanta','Str. Drumului nr 34');
INSERT INTO CLIENTI
    VALUES(8,'Radu','Ionut','radion@mail.com','0876592921','Romania','Slatina','Str. Basarab nr 19');
INSERT INTO CLIENTI
    VALUES(9,'Monete','Maria','mmaria@mail.com','0876592922','Romania','Bucuresti','Str. Virtutii nr 40');
INSERT INTO CLIENTI
    VALUES(10,'Buzatu','Rares','rdbuz@mail.com','0876592923','Italia','Roma','Str. Artiza nr 8');
    
INSERT INTO PLATI
    VALUES(1,'ramburs',NULL,NULL,300);
INSERT INTO PLATI
    VALUES(2,'card','4140 4980','Matei Basarab',1500);
INSERT INTO PLATI
    VALUES(3,'card','4140 4000 3','Rares Buzatu',50);
INSERT INTO PLATI
    VALUES(4,'ramburs',NULL,NULL,278);
INSERT INTO PLATI
    VALUES(5,'card','4140 4220 2222','Maria Monete',2370);  
INSERT INTO PLATI
    VALUES(6,'ramburs',NULL,NULL,300);
INSERT INTO PLATI
    VALUES(7,'card','4140 5678','Popescu Mircea',1230);
INSERT INTO PLATI
    VALUES(8,'card','4140 3345','Radu Ionut',500);
INSERT INTO PLATI
    VALUES(9,'ramburs',NULL,NULL,278);
INSERT INTO PLATI
    VALUES(10,'card','4140 4859','Buzatu Rares',2300);
INSERT INTO PLATI
    VALUES(11,'ramburs',NULL,NULL,450);
    
INSERT INTO LIVRARI
    VALUES(1,'1000',to_date('01-01-2023', 'dd-mm-yyyy'),'Fan Courier','in depozit');
INSERT INTO LIVRARI
    VALUES(2,'1001',to_date('01-11-2022','dd-mm-yyyy'),'Sameday','in curs de livrare');
INSERT INTO LIVRARI
    VALUES(3,'1002',to_date('21-08-2021','dd-mm-yyyy'),'Fan Courier','livrata');
INSERT INTO LIVRARI
    VALUES(4,'1003',to_date('09-06-2022','dd-mm-yyyy'),'Fan Courier','livrata');
INSERT INTO LIVRARI
    VALUES(5,'1004',to_date('29-12-2022','dd-mm-yyyy'),'Sameday','in curs de livrare');
INSERT INTO LIVRARI
    VALUES(6,'1005',to_date('11-01-2022', 'dd-mm-yyyy'),'DPD','livrata');
INSERT INTO LIVRARI
    VALUES(7,'1006',to_date('22-05-2022','dd-mm-yyyy'),'Sameday','in curs de livrare');
INSERT INTO LIVRARI
    VALUES(8,'1007',to_date('09-02-2022','dd-mm-yyyy'),'Fan Courier','livrata');
INSERT INTO LIVRARI
    VALUES(9,'1008',to_date('16-05-2021','dd-mm-yyyy'),'DPD','livrata');
INSERT INTO LIVRARI
    VALUES(10,'1009',to_date('08-07-2022','dd-mm-yyyy'),'Sameday','in curs de livrare');
INSERT INTO LIVRARI 
    VALUES(11,1000,to_date('04-07-2022','dd-mm-yyyy'),'DPD','livrata');
    
   
INSERT INTO DEPOZITE_PRODUSE
    VALUES(1,'Depozit Bucuresti','Bucuresti');
INSERT INTO DEPOZITE_PRODUSE
    VALUES(2,'Depozit Pitesti','Pitesti');
INSERT INTO DEPOZITE_PRODUSE
    VALUES(3,'Depozit Timisoara','Timisoara');
INSERT INTO DEPOZITE_PRODUSE
    VALUES(4,'Depozit Cluj','Cluj');
INSERT INTO DEPOZITE_PRODUSE
    VALUES(5,'Depozit Iasi','Iasi'); 
    
INSERT INTO FURNIZORI
    VALUES(1,'Arabian Scent','Bucuresti Sector 6 Str Uverturii nr 21','arabscent@mail.com','0786543244');
INSERT INTO FURNIZORI
    VALUES(2,'French essence','Timisoara Bd Mihail Kogalniceanu nr 158','frenchessence@mail.com','0786543245');
INSERT INTO FURNIZORI
    VALUES(3,'Parfumuri Romania','Bucuresti Sector 3 Str Dreptatii nr 100','ropar@mail.com','0786543246');
INSERT INTO FURNIZORI
    VALUES(4,'Esente tari','Craiova Str Libertatii nr 39','esta@mail.com','0786543247');
INSERT INTO FURNIZORI
    VALUES(5,'Parfumas','Sibiu Str Pacii nr 40','parfumas3@mail.com','0786543248');
    
INSERT INTO DEPARTAMENTE
    VALUES(1,'Serviciu clienti','Bucuresti');
INSERT INTO DEPARTAMENTE
    VALUES(2,'Call-center','Bucuresti');
INSERT INTO DEPARTAMENTE
    VALUES(3,'Logistica','Bucuresti');
INSERT INTO DEPARTAMENTE
    VALUES(4,'Sesizari','Pitesti');
INSERT INTO DEPARTAMENTE
    VALUES(5,'Livrari','Ilfov');
    
INSERT INTO ANGAJATI
    VALUES(1,1,'Pop','Alexandru',1200,'popalex@gmail.com','0777777777');
INSERT INTO ANGAJATI
    VALUES(2,1,'Lulea','Ana',2300,'lola23@gmail.com','0777777760');
INSERT INTO ANGAJATI
    VALUES(3,1,'Monea','Rares',4670,'morares@gmail.com','0777777761');
INSERT INTO ANGAJATI
    VALUES(4,2,'Ilea','Bianca',5000,'bibixoxo@gmail.com','0777777762');
INSERT INTO ANGAJATI
    VALUES(5,2,'Luzi','Ioana',9000,'luzilz@gmail.com','0777777763');
INSERT INTO ANGAJATI
    VALUES(6,2,'Popa','Sandu',4000,'popasan@gmail.com','0777777764');
INSERT INTO ANGAJATI
    VALUES(7,3,'Aluza','Enola',3500,'enola@gmail.com','0777777765');
INSERT INTO ANGAJATI
    VALUES(8,3,'Mutacu','Darius',1500,'mudarius@gmail.com','0777777766');
INSERT INTO ANGAJATI
    VALUES(9,3,'Radoi','Alexandru',6000,'radoialex@gmail.com','0777777767');
INSERT INTO ANGAJATI
    VALUES(10,4,'Selini','Paula',4500,'paula@gmail.com','0777777768');
INSERT INTO ANGAJATI
    VALUES(11,4,'Filip','Vlad',8000,'filvald@gmail.com','0777777769');
INSERT INTO ANGAJATI
    VALUES(12,4,'Ieftiimie','Raluca',3900,'ralucya@gmail.com','0777777888');
INSERT INTO ANGAJATI
    VALUES(13,5,'Destiper','Mircea',7000,'destiperola@gmail.com','077777999');
INSERT INTO ANGAJATI
    VALUES(14,5,'Puscasu','Mihai',2500,'mihpusc@gmail.com','0777777000');
INSERT INTO ANGAJATI
    VALUES(15,5,'Anton','Andreea',5700,'andreeant@gmail.com','0777777222');
    
INSERT INTO PRODUSE
    VALUES(1, 1, 1,'Versace-Bright-Crystal', 'Note varf rodie, acorduri de gheata, yuzu;Note inima	lotus, magnolie, bujor;
            Note baza	cihlimbar, lemn, mosc', 56,3000, 0.10);
INSERT INTO PRODUSE
    VALUES(2, 2, 1,'Versace-Crystal-Noir', 'Note varf	coacaze negre, Fig negru, violeta;Note inima tuberoza, frangipani, iasomie;
            Note baza	lemn de santal, kasmeran, vanilie, heliotrop', 25,2000, 0);
INSERT INTO PRODUSE
    VALUES(3, 1, 2,'Versace-Yellow-Diamond', 'Note varf extras din portocala amara, para, bergamota, lamaie;Note inima	iasomie, osmanthusl
            Note baza cihlimbar, benzoin', 38,1750, 0.05);
INSERT INTO PRODUSE
    VALUES(4, 2, 3,'Dior-Jadore', 'Compozitie extras din portocala amara, Jasmine (arab), magnolie;Grupe de parfumuri	florale, acvatice', 16, 230,0.05);
INSERT INTO PRODUSE
    VALUES(5, 3, 3,'Dior-Miss-Dior', 'Note varf lacramioare, bujor, iris;Note inima	trandafir;Note baza	mosc, vanilie, benzoin, tonka, lemn de santal;
            Grupe de parfumuri	florale', 12,1230, 0);
INSERT INTO PRODUSE
    VALUES(6, 2, 3,'Dior-Poison-Girl', 'Note varf portocala amara;Note inima trandafiri din Grasse;
            Note baza tonka;Grupe de parfumuri orientale', 4, 1100,0.10);
INSERT INTO PRODUSE
    VALUES(7, 3, 4,'CH-Good-Girl', 'Note varf	migdale;Note inima	iasomie Sambac, tuberoza;Note baza	tonka, cacao;
            Grupe de parfumuri	orientale, florale', 123, 500, 0);
INSERT INTO PRODUSE
    VALUES(8, 4, 4,'CH-212-VIP', 'Note varf bergamota, piper;Note inima	gardenie, geranium;Note baza	vata de zahar, mosc, lemn de santal, vanilie;
            Grupe de parfumuri	orientale, florale', 56, 2099,0);
INSERT INTO PRODUSE
    VALUES(9, 5, 3,'CH-GG-Legere', 'Compozitie	absolut de vanilie;Note varf	cires, migdale amare;Note inima	trandafir, crin;Note baza	vetiver, vanilie Bourbon, absolut de vanilie;
            Grupe de parfumuri	florale, lemnoase', 47, 3400, 0.05);
INSERT INTO PRODUSE
    VALUES(10, 1, 5,'Pacco-Rabane-OneMil', 'Note varf zmeura, extras din portocala amara;Note inima	gardenie, Jasmine (arab), 
        floare de portocal african;Note baza	patchouli, miere alba, cihlimbar;', 87, 1299,0.20);
    
INSERT INTO COMENZI
    VALUES(1,1,5,1,1,to_date('12-12-2022', 'dd-mm-yyyy'),2);
INSERT INTO COMENZI
    VALUES(2,2,5,2,2,to_date('29-07-2022', 'dd-mm-yyyy'),5);
INSERT INTO COMENZI
    VALUES(3,3,5,3,3,to_date('04-08-2022', 'dd-mm-yyyy'),1);
INSERT INTO COMENZI
    VALUES(4,4,4,4,4,to_date('23-09-2022', 'dd-mm-yyyy'),4);
INSERT INTO COMENZI
    VALUES(5,5,4,5,5,to_date('14-11-2022', 'dd-mm-yyyy'),1);
INSERT INTO COMENZI
    VALUES(6,6,3,6,6,to_date('12-12-2022', 'dd-mm-yyyy'),2);
INSERT INTO COMENZI
    VALUES(7,7,5,7,7,to_date('29-07-2022', 'dd-mm-yyyy'),5);
INSERT INTO COMENZI
    VALUES(8,8,1,8,8,to_date('04-08-2022', 'dd-mm-yyyy'),1);
INSERT INTO COMENZI
    VALUES(9,9,5,9,9,to_date('23-09-2022', 'dd-mm-yyyy'),4);
INSERT INTO COMENZI
    VALUES(10,10,4,10,10,to_date('14-11-2022', 'dd-mm-yyyy'),1);
INSERT INTO COMENZI
    VALUES(11,2,3,11,11,to_date('02-07-2022', 'dd-mm-yyyy'),2);
    
INSERT INTO COSURI_PRODUSE
    VALUES(1,1,2);
INSERT INTO COSURI_PRODUSE
    VALUES(2,2,3);
INSERT INTO COSURI_PRODUSE
    VALUES(3,3,5);
INSERT INTO COSURI_PRODUSE
    VALUES(4,4,4);   
INSERT INTO COSURI_PRODUSE
    VALUES(5,5,1);
INSERT INTO COSURI_PRODUSE
    VALUES(6,6,8);
INSERT INTO COSURI_PRODUSE
    VALUES(7,7,6);
INSERT INTO COSURI_PRODUSE
    VALUES(8,8,7);   
INSERT INTO COSURI_PRODUSE
    VALUES(9,9,10);
INSERT INTO COSURI_PRODUSE
    VALUES(10,10,9); 
    

    
--6 Afisati toti angajatii(si salariile lor) care 
--lucreaza intr-un departament care se afla intr-o locatie introdusa de la tastatura

CREATE OR REPLACE PROCEDURE proc_ex6(v_oras in departamente.locatie%TYPE) IS

--tablou indexat
    TYPE tab_ind IS TABLE OF angajati.nume%TYPE INDEX BY PLS_INTEGER;
--var care vor stoca numele si prenumele
    v_nume tab_ind;
    v_prenume tab_ind;

--vector
    TYPE vector IS VARRAY(30) OF angajati.salariu%TYPE;
--var care va stoca salariul angajatului
    v_sal vector;
BEGIN
--introducem in vector salariile angajatilor din acea locatie
    SELECT salariu
    BULK COLLECT INTO v_sal
    FROM angajati
    JOIN departamente on departamente.id_departament=angajati.id_departament
    WHERE UPPER(departamente.locatie)=upper(v_oras)
    ORDER BY salariu DESC;
--gasim numele si prenumele angajatilor din dep respectiv   
    FOR i IN v_sal.first..v_sal.last LOOP
        SELECT angajati.nume
        INTO v_nume(i)
        FROM ANGAJATI
        JOIN DEPARTAMENTE ON departamente.id_departament=angajati.id_departament
        WHERE upper(departamente.locatie)=upper(v_oras)
        AND angajati.salariu=v_sal(i);
    END LOOP;
    
    --gasim numele si prenumele angajatilor din dep respectiv   
    FOR i IN v_sal.first..v_sal.last LOOP
        SELECT angajati.prenume
        INTO v_prenume(i)
        FROM ANGAJATI
        JOIN DEPARTAMENTE ON departamente.id_departament=angajati.id_departament
        WHERE upper(departamente.locatie)=upper(v_oras)
        AND angajati.salariu=v_sal(i);
    END LOOP;
    
--parcurgem tabelelele si vectorul
    IF v_nume.count>0 THEN
        FOR i in v_sal.first..v_sal.last LOOP
            DBMS_OUTPUT.PUT_LINE('In departamentul din locatia '||v_oras ||' lucreaza angajatul '||v_nume(i)||' '||v_prenume(i)||' cu salariul de '||v_sal(i));
        END LOOP;
    ELSE
        DBMS_OUTPUT.PUT_LINE('In departamentul din '||v_oras||' nu lucreaza niciun angajat');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nu s-au gasit date');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('S-au gasit prea multe linii');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Altceva');
END proc_ex6;

--apelam procedura
ACCEPT locatie PROMPT 'Introduceti orasul ';
DECLARE
    loc departamente.locatie%TYPE:='&locatie';
BEGIN
    proc_ex6(loc);
END;

--7
--afisati cele mai scumpe 2 produse care se afla in depozitul cu numele introdus de la tastatura 

CREATE OR REPLACE PROCEDURE proc_ex7(v_numedep in depozite_produse.nume%TYPE) IS
--cursor clasic
    CURSOR c1 IS 
        SELECT id_depozit
        FROM depozite_produse
        WHERE INITCAP(nume)=INITCAP(v_numedep);
--cursor parametrizat
    CURSOR c2(v_id depozite_produse.id_depozit%type) IS
        SELECT nume, pret
        FROM produse
        WHERE id_depozit=v_id
        ORDER BY pret desc;

    c_pret produse.pret%TYPE;
    c_denumire produse.nume%TYPE;
    c_id depozite_produse.id_depozit%TYPE;

BEGIN
    OPEN c1;
    LOOP
    FETCH c1 INTO c_id;
    EXIT WHEN c1%NOTFOUND;
    END LOOP;
    --cautam id-ul depozitului cu numele dat
    
    OPEN c2(c_id);
    LOOP
    FETCH c2 INTO c_denumire, c_pret;
    EXIT WHEN c2%NOTFOUND OR c2%ROWCOUNT>2;
    DBMS_OUTPUT.PUT_LINE('In depozitul '||v_numedep||' se afla parfumul '||c_denumire||' care costa '||c_pret);
    END LOOP;
    --gasim primele 2 produse in functie de pret
 
    IF c2%ROWCOUNT = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Nu exista produse in acest depozit');
    END IF;
    CLOSE c2;
    DBMS_OUTPUT.NEW_LINE;
    CLOSE c1;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nu s-au gasit date');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('S-au gasit prea multe linii');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Altceva');
END proc_ex7;

ACCEPT numedep PROMPT 'Introduceti numele depozitului ';
DECLARE
    nume depozite_produse.nume%TYPE:='&numedep';
BEGIN
    proc_ex7(nume);
END;

--8
--afisati pentru un numele unui angajat introdus de la tastatura,
--pretul total al comenzilor la care lucreaza


CREATE OR REPLACE FUNCTION functie8(v_numeang ANGAJATI.nume%TYPE)
RETURN plati.suma%TYPE IS

    suma_totala plati.suma%TYPE;
    nr_ang NUMBER;
    nr_com NUMBER;
BEGIN
--vedem cati angajati exista( cu numele de familie dat)
    SELECT COUNT(*)
    INTO nr_ang
    FROM angajati
    WHERE UPPER(nume)=UPPER(v_numeang);
 
 --aruncam exceptii in caz ca sunt 0/mai multi ang cu numele dat
    IF nr_ang=0
        THEN RAISE_APPLICATION_ERROR(-20000,'Nu exista niciun angajat cu acest nume de familie');
    ELSIF nr_ang>1
        THEN RAISE_APPLICATION_ERROR(-20001,'Exista mai multi angajati cu acest nume de familie');
    END IF;
 
--vedem la cate comenzi lucreaza angajatul
    SELECT COUNT(*)
    INTO nr_com
    FROM comenzi
    JOIN angajati ON angajati.id_angajat=comenzi.id_angajat
    WHERE UPPER(angajati.nume)=UPPER(v_numeang);
    
--aruncam exceptie in caz ca angajatul nu lucreaza la nicio comanda
    IF nr_com=0
        THEN RAISE_APPLICATION_ERROR(-20002,'Nu exista nicio comanda la care se lucreaza');
    END IF;
    
--calcualm pretul tuturor comenzilor la care lucreaza angajatul
    SELECT SUM(suma)
    INTO suma_totala
    FROM plati
    JOIN comenzi ON plati.id_plata=comenzi.id_plata
    JOIN angajati ON  comenzi.id_angajat=angajati.id_angajat
    WHERE UPPER(angajati.nume)=UPPER(v_numeang);
--am facut join pe 3 tabele pt a obtine rezultatul    

    RETURN suma_totala;

END functie8;

--apelam functia pt un angajat care nu exista
SELECT functie8('Popescu') FROM DUAL;

--apelam functia pentru un nume care se gaseste la 2 angajati
SELECT functie8('Anton') FROM DUAL;

--apelam functia pentru un angajat care nu lucreaza la nicio comanda
SELECT functie8('Popa') FROM DUAL;

--apelam functia pt un angajat care exista sie unul singur, si lucreaza la cel putin o comanda
SELECT functie8('Pop') FROM DUAL;


--9
--livrari si depozit produse
--se da numarul unei livrari. afisati pt aceasta id-ul comenzii care ii 
--corespune, numele produsului din comanda si numele depozitului in care se afla acest produs

CREATE OR REPLACE PROCEDURE proc_ex9 (nr_liv livrari.numar%TYPE) IS
    CURSOR c9 IS 
        SELECT c.id_comanda, p.nume, dp.nume
        FROM livrari l 
        JOIN comenzi c ON l.id_livrare=c.id_livrare
        JOIN cosuri_produse cp ON cp.id_comanda=c.id_comanda
        JOIN produse p ON p.id_produs=cp.id_produs
        JOIN depozite_produse dp ON p.id_depozit=dp.id_depozit
        WHERE l.numar=nr_liv;
    CURSOR c9_1 IS
        SELECT COUNT(*)
        FROM livrari
        WHERE numar=nr_liv;
    id_com comenzi.id_comanda%TYPE;
    nume_prod produse.nume%TYPE;
    nume_dep depozite_produse.nume%TYPE;
    nr NUMBER;
BEGIN
    OPEN c9_1;
    LOOP
    FETCH c9_1 INTO nr;
    EXIT WHEN c9_1%NOTFOUND;
    END LOOP;
    
    IF nr>1
        THEN RAISE_APPLICATION_ERROR(-20004, 'Exista mai multe comenzi cu acest numar');
    END IF;
    CLOSE c9_1;
    
    
    OPEN c9;
    LOOP
    FETCH c9 INTO id_com, nume_prod, nume_dep;
    EXIT WHEN c9%NOTFOUND;
    END LOOP;
    
    IF c9%ROWCOUNT = 0
        THEN RAISE_APPLICATION_ERROR(-20003, 'Nu exista nicio livrare cu acest numar');
    END IF;
    
    IF c9%ROWCOUNT =1  
        THEN DBMS_OUTPUT.PUT_LINE('Livrarii cu numarul '||nr_liv||' ii corespunde comanda cu id-ul '||id_com||' care contine produsul '||
        nume_prod||' aflat in depozitul cu numele '||nume_dep);
    END IF;

    CLOSE c9;


    
END proc_ex9;

EXECUTE proc_ex9(1002);  

EXECUTE proc_ex9(1010);

EXECUTE proc_ex9(1000);

--ACCEPT nrliv PROMPT 'Introduceti numarul livrarii';
--DECLARE
--    numar_liv livrari.numar%TYPE:='&nrliv';
--BEGIN
--    proc_ex9(numar_liv);
--END;

--10
--sa se creeze un trigger care nu permite plasarea(insert) 
--unei comenzi in intervalul orar 02:00-07:00

CREATE OR REPLACE TRIGGER t_ex10
    BEFORE INSERT OR DELETE OR UPDATE ON comenzi
BEGIN
--daca ora este intre 2 si 7, se declanseaza exceptia 
    IF(to_char(SYSDATE,'HH24')BETWEEN 2 AND 7)THEN
        IF INSERTING THEN
            RAISE_APPLICATION_ERROR(-20005,'Plasarea unei comenzi se realizeaza in
            intervalul orar 07:00-23:59 si 00:00-02:00');
        END IF;
    END IF;
END t_ex10;

INSERT INTO plati VALUES(12,'ramburs',NULL,NULL,2000);
INSERT INTO livrari VALUES(12,'1011',to_date('11-02-2023','dd-mm-yyyy'),'Sameday','in depozit');
--declansare
INSERT INTO comenzi VALUES(13,9,2,12,12,to_date('11-02-2023','dd-mm-yyyy'),1);

--11
--creati un trigger care nu perminte modificarea statusului
--unei livrare care are statusul 'livrata'
CREATE OR REPLACE TRIGGER t_ex11
    BEFORE INSERT OR UPDATE OF status on livrari
    FOR EACH ROW
BEGIN
--daca statusul nou e diferit de cel vechi, iar cel nou=status, declanseaza eroare
    IF :OLD.status='livrata' AND :NEW.status<>:OLD.status
        THEN RAISE_APPLICATION_ERROR(-20006,'Nu puteti modifica statusul unei livrari deja efectuate');
    END IF;
END t_ex11;
--declansare
UPDATE livrari
SET status='in curs de livrare'
WHERE id_livrare=3;

--12
--creati un trigger care nu permite
--stergerea unui tabel
CREATE OR REPLACE TRIGGER t_ex12
    BEFORE DROP ON SCHEMA
BEGIN
    DBMS_OUTPUT.PUT_LINE('Nu puteti sterge un tabel');
    ROLLBACK;
END t_ex12;

CREATE TABLE test
(   id_test NUMBER(2)
);
--declansare
DROP TABLE test;

--13

CREATE OR REPLACE PACKAGE pachet_ex13 IS
    FUNCTION functie8(v_numeang ANGAJATI.nume%TYPE) RETURN plati.suma%TYPE;
    PROCEDURE proc_ex6(v_oras in departamente.locatie%TYPE);
    PROCEDURE proc_ex7(v_numedep in depozite_produse.nume%TYPE);
    PROCEDURE proc_ex9 (nr_liv livrari.numar%TYPE);
END pachet_ex13;

CREATE OR REPLACE PACKAGE BODY pachet_ex13 IS

--functie ex8
FUNCTION functie8(v_numeang ANGAJATI.nume%TYPE)
RETURN plati.suma%TYPE IS

    suma_totala plati.suma%TYPE;
    nr_ang NUMBER;
    nr_com NUMBER;
BEGIN

    SELECT COUNT(*)
    INTO nr_ang
    FROM angajati
    WHERE UPPER(nume)=UPPER(v_numeang);

    IF nr_ang=0
        THEN RAISE_APPLICATION_ERROR(-20000,'Nu exista niciun angajat cu acest nume de familie');
    ELSIF nr_ang>1
        THEN RAISE_APPLICATION_ERROR(-20001,'Exista mai multi angajati cu acest nume de familie');
    END IF;

    SELECT COUNT(*)
    INTO nr_com
    FROM comenzi
    JOIN angajati ON angajati.id_angajat=comenzi.id_angajat
    WHERE UPPER(angajati.nume)=UPPER(v_numeang);

    IF nr_com=0
        THEN RAISE_APPLICATION_ERROR(-20002,'Nu exista nicio comanda la care se lucreaza');
    END IF;

    SELECT SUM(suma)
    INTO suma_totala
    FROM plati
    JOIN comenzi ON plati.id_plata=comenzi.id_plata
    JOIN angajati ON  comenzi.id_angajat=angajati.id_angajat
    WHERE UPPER(angajati.nume)=UPPER(v_numeang);   

    RETURN suma_totala;

END functie8;

--procedura ex 6
PROCEDURE proc_ex6(v_oras in departamente.locatie%TYPE) IS

    TYPE tab_ind IS TABLE OF angajati.nume%TYPE INDEX BY PLS_INTEGER;
    v_nume tab_ind;
    v_prenume tab_ind;
    TYPE vector IS VARRAY(30) OF angajati.salariu%TYPE;
    v_sal vector;
BEGIN

    SELECT salariu
    BULK COLLECT INTO v_sal
    FROM angajati
    JOIN departamente on departamente.id_departament=angajati.id_departament
    WHERE UPPER(departamente.locatie)=upper(v_oras)
    ORDER BY salariu DESC;
  
    FOR i IN v_sal.first..v_sal.last LOOP
        SELECT angajati.nume
        INTO v_nume(i)
        FROM ANGAJATI
        JOIN DEPARTAMENTE ON departamente.id_departament=angajati.id_departament
        WHERE upper(departamente.locatie)=upper(v_oras)
        AND angajati.salariu=v_sal(i);
    END LOOP;
       
    FOR i IN v_sal.first..v_sal.last LOOP
        SELECT angajati.prenume
        INTO v_prenume(i)
        FROM ANGAJATI
        JOIN DEPARTAMENTE ON departamente.id_departament=angajati.id_departament
        WHERE upper(departamente.locatie)=upper(v_oras)
        AND angajati.salariu=v_sal(i);
    END LOOP;

    IF v_nume.count>0 THEN
        FOR i in v_sal.first..v_sal.last LOOP
            DBMS_OUTPUT.PUT_LINE('In departamentul din locatia '||v_oras ||' lucreaza angajatul '||v_nume(i)||' '||v_prenume(i)||' cu salariul de '||v_sal(i));
        END LOOP;
    ELSE
        DBMS_OUTPUT.PUT_LINE('In departamentul din '||v_oras||' nu lucreaza niciun angajat');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nu s-au gasit date');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('S-au gasit prea multe linii');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Altceva');
END proc_ex6;

--procedura ex 7
PROCEDURE proc_ex7(v_numedep in depozite_produse.nume%TYPE) IS

    CURSOR c1 IS 
        SELECT id_depozit
        FROM depozite_produse
        WHERE nume=v_numedep;

    CURSOR c2(v_id depozite_produse.id_depozit%type) IS
        SELECT nume, pret
        FROM produse
        WHERE id_depozit=v_id
        ORDER BY pret desc;

    c_pret produse.pret%TYPE;
    c_denumire produse.nume%TYPE;
    c_id depozite_produse.id_depozit%TYPE;

BEGIN
    OPEN c1;
    LOOP
    FETCH c1 INTO c_id;
    EXIT WHEN c1%NOTFOUND;
    END LOOP;
    
    OPEN c2(c_id);
    LOOP
    FETCH c2 INTO c_denumire, c_pret;
    EXIT WHEN c2%NOTFOUND OR c2%ROWCOUNT>2;
    DBMS_OUTPUT.PUT_LINE('In depozitul '||v_numedep||' se afla parfumul '||c_denumire||' care costa '||c_pret);
    END LOOP;
 
    IF c2%ROWCOUNT = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Nu exista produse in acest depozit');
    END IF;
    CLOSE c2;
    DBMS_OUTPUT.NEW_LINE;
    CLOSE c1;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nu s-au gasit date');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('S-au gasit prea multe linii');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Altceva');
END proc_ex7;

--procedura ex 9
PROCEDURE proc_ex9 (nr_liv livrari.numar%TYPE) IS
    CURSOR c9 IS 
        SELECT c.id_comanda, p.nume, dp.nume
        FROM livrari l 
        JOIN comenzi c ON l.id_livrare=c.id_livrare
        JOIN cosuri_produse cp ON cp.id_comanda=c.id_comanda
        JOIN produse p ON p.id_produs=cp.id_produs
        JOIN depozite_produse dp ON p.id_depozit=dp.id_depozit
        WHERE l.numar=nr_liv;
    CURSOR c9_1 IS
        SELECT COUNT(*)
        FROM livrari
        WHERE numar=nr_liv;
    id_com comenzi.id_comanda%TYPE;
    nume_prod produse.nume%TYPE;
    nume_dep depozite_produse.nume%TYPE;
    nr NUMBER;
BEGIN
    OPEN c9_1;
    LOOP
    FETCH c9_1 INTO nr;
    EXIT WHEN c9_1%NOTFOUND;
    END LOOP;
    
    IF nr>1
        THEN RAISE_APPLICATION_ERROR(-20004, 'Exista mai multe comenzi cu acest numar');
    END IF;
    CLOSE c9_1;
 
    OPEN c9;
    LOOP
    FETCH c9 INTO id_com, nume_prod, nume_dep;
    EXIT WHEN c9%NOTFOUND;
    END LOOP;
    
    IF c9%ROWCOUNT = 0
        THEN RAISE_APPLICATION_ERROR(-20003, 'Nu exista nicio livrare cu acest numar');
    END IF;
    
    IF c9%ROWCOUNT =1  
        THEN DBMS_OUTPUT.PUT_LINE('Livrarii cu numarul '||nr_liv||' ii corespunde comanda cu id-ul '||id_com||' care contine produsul '||
        nume_prod||' aflat in depozitul cu numele '||nume_dep);
    END IF;

    CLOSE c9;

END proc_ex9;

END pachet_ex13;

SELECT pachet_ex13.functie8('Monea') FROM DUAL;

EXECUTE pachet_ex13.proc_ex6('Ilfov');

EXECUTE pachet_ex13.proc_ex7('Depozit Cluj');

EXECUTE pachet_ex13.proc_ex9(1002);

