create database BD_project
on primary
(
	name = mdf,
	filename = 'C:\BD_project\projectMDF.mdf',
	size = 10 MB,
	maxsize = unlimited,
	filegrowth = 1 GB
),
filegroup fg
(
	name = ndf1,
	filename = 'C:\BD_project\projectNDF1.ndf',
	size = 10 MB,
	maxsize = unlimited,
	filegrowth = 1 GB
),
(
	name = ndf2,
	filename = 'C:\BD_project\projectNDF2.ndf',
	size = 10 MB,
	maxsize = unlimited,
	filegrowth = 1 GB
)
log on
(
	name = log1,
	filename = 'C:\BD_project\projectLOG1.ldf',
	size = 10 MB,
	maxsize = unlimited,
	filegrowth = 1024 MB
),
(
	name = log2,
	filename = 'C:\BD_project\projectLOG2.ldf',
	size = 10 MB,
	maxsize = unlimited,
	filegrowth = 1024 MB
)

CREATE TABLE Voluntari (
    id_voluntar INT PRIMARY KEY,
    nume_voluntar VARCHAR(100),
    adresa VARCHAR(255),
    email VARCHAR(100),
    telefon VARCHAR(20),
    experienta_anterioara VARCHAR(255),
    disponibilitate_orar VARCHAR(100),
    abilitati VARCHAR(255)
);

CREATE TABLE Organizatii (
    id_organizatie INT PRIMARY KEY,
    nume_organizatie VARCHAR(100),
    adresa VARCHAR(255),
    email VARCHAR(100),
    telefon VARCHAR(20),
    tip_organizatie VARCHAR(100)
);

CREATE TABLE Activitati_voluntariat (
    id_activitate INT PRIMARY KEY,
    nume_activitate VARCHAR(100),
    data_inceperii DATE,
    data_finalizarii DATE,
    descriere TEXT,
    id_organizatie INT,
    FOREIGN KEY (id_organizatie) REFERENCES Organizatii(id_organizatie)
);

CREATE TABLE Proiecte (
    id_proiect INT PRIMARY KEY,
    nume_proiect VARCHAR(100),
    descriere TEXT,
    data_inceperii DATE,
    data_finalizarii DATE,
    buget DECIMAL(10, 2),
    id_organizatie INT,
    FOREIGN KEY (id_organizatie) REFERENCES Organizatii(id_organizatie)
);

CREATE TABLE Participari_voluntari (
    id_participare INT PRIMARY KEY,
    id_voluntar INT,
    id_activitate INT,
    data_participare DATE,
    ore_lucrate INT,
    feedback TEXT,
    FOREIGN KEY (id_voluntar) REFERENCES Voluntari(id_voluntar),
    FOREIGN KEY (id_activitate) REFERENCES Activitati_voluntariat(id_activitate)
);

CREATE TABLE Competente (
    id_competenta INT PRIMARY KEY,
    nume_competenta VARCHAR(100)
);

CREATE TABLE Voluntari_Competente (
    id_voluntar INT,
    id_competenta INT,
    nivel INT,
    FOREIGN KEY (id_voluntar) REFERENCES Voluntari(id_voluntar),
    FOREIGN KEY (id_competenta) REFERENCES Competente(id_competenta)
);

CREATE TABLE Evenimente (
    id_eveniment INT PRIMARY KEY,
    nume_eveniment VARCHAR(100),
    data_inceperii DATE,
    data_finalizarii DATE,
    locatie VARCHAR(255),
    descriere TEXT,
    id_organizatie INT,
    FOREIGN KEY (id_organizatie) REFERENCES Organizatii(id_organizatie)
);

CREATE TABLE Participari_evenimente (
    id_participare_eveniment INT PRIMARY KEY,
    id_voluntar INT,
    id_eveniment INT,
    data_participare DATE,
    FOREIGN KEY (id_voluntar) REFERENCES Voluntari(id_voluntar),
    FOREIGN KEY (id_eveniment) REFERENCES Evenimente(id_eveniment)
);

CREATE TABLE Feedback_voluntari (
    id_feedback INT PRIMARY KEY,
    id_voluntar INT,
    id_activitate INT,
    rating INT,
    comentariu TEXT,
    FOREIGN KEY (id_voluntar) REFERENCES Voluntari(id_voluntar),
    FOREIGN KEY (id_activitate) REFERENCES Activitati_voluntariat(id_activitate)
);

CREATE TABLE Competente_Activitati (
    id_activitate INT,
    id_competenta INT,
    FOREIGN KEY (id_activitate) REFERENCES Activitati_voluntariat(id_activitate),
    FOREIGN KEY (id_competenta) REFERENCES Competente(id_competenta)
);

CREATE TABLE Evenimente_Voluntari (
    id_eveniment INT,
    id_voluntar INT,
    FOREIGN KEY (id_eveniment) REFERENCES Evenimente(id_eveniment),
    FOREIGN KEY (id_voluntar) REFERENCES Voluntari(id_voluntar)
);


ALTER TABLE Voluntari ADD CONSTRAINT UC_Voluntari_Email UNIQUE (email);
ALTER TABLE Organizatii ADD CONSTRAINT UC_Organizatii_Email UNIQUE (email);
ALTER TABLE Competente ADD CONSTRAINT UC_NumeCompetenta UNIQUE (nume_competenta);

ALTER TABLE Activitati_voluntariat ADD CONSTRAINT DF_Activ_Descriere DEFAULT '' FOR descriere;
ALTER TABLE Proiecte ADD CONSTRAINT DF_Proiecte_Descriere DEFAULT '' FOR descriere;
ALTER TABLE Participari_voluntari ADD CONSTRAINT DF_OreLucrate DEFAULT 0 FOR ore_lucrate;

ALTER TABLE Activitati_voluntariat ADD CONSTRAINT Check_Date_Activ CHECK (data_finalizarii >= data_inceperii);
ALTER TABLE Proiecte ADD CONSTRAINT Check_Date_Proiecte CHECK (data_finalizarii >= data_inceperii);
ALTER TABLE Participari_voluntari ADD CONSTRAINT Check_OreLucrate CHECK (ore_lucrate >= 0);
ALTER TABLE Feedback_voluntari ADD CONSTRAINT Check_Rating CHECK (rating BETWEEN 1 AND 5);

-- Inserare în tabelul Voluntari
INSERT INTO Voluntari (id_voluntar, nume_voluntar, adresa, email, telefon, experienta_anterioara, disponibilitate_orar, abilitati)
VALUES 
    (1, 'Ana Popescu', 'Str. Florilor nr. 10', 'ana.popescu@example.com', '0712345678', 'Experienta 1', 'Luni - Vineri dupa-amiaza', 'Abilitati 1'),
    (2, 'Ion Ionescu', 'Str. Mihai Viteazu nr. 5', 'ion.ionescu@example.com', '0723456789', 'Experienta 2', 'Weekend', 'Abilitati 2'),
    (3, 'Maria Georgescu', 'Str. Libertatii nr. 15', 'maria.georgescu@example.com', '0734567890', 'Experienta 3', 'Oricand', 'Abilitati 3'),
    (4, 'Mihai Radulescu', 'Str. Independentei nr. 20', 'mihai.radulescu@example.com', '0745678901', 'Experienta 4', 'Sambata', 'Abilitati 4'),
    (5, 'Cristina Popa', 'Str. Unirii nr. 25', 'cristina.popa@example.com', '0756789012', 'Experienta 5', 'Luni - Miercuri', 'Abilitati 5'),
	(6, 'Gabriel Ionescu', 'Str. Primaverii nr. 30', 'gabriel.ionescu@example.com', '0767890123', 'Experienta 6', 'Weekend', 'Abilitati 6'),
    (7, 'Andreea Pop', 'Str. Soarelui nr. 35', 'andreea.pop@example.com', '0778901234', 'Experienta 7', 'Luni - Joi', 'Abilitati 7'),
    (8, 'Marius Stanescu', 'Str. Florilor nr. 40', 'marius.stanescu@example.com', '0789012345', 'Experienta 8', 'Weekend', 'Abilitati 8'),
    (9, 'Elena Dumitrescu', 'Str. Frunzelor nr. 45', 'elena.dumitrescu@example.com', '0790123456', 'Experienta 9', 'Luni - Vineri dimineata', 
	'Abilitati 9'),
    (10, 'Radu Popescu', 'Str. Zorilor nr. 50', 'radu.popescu@example.com', '0801234567', 'Experienta 10', 'Sambata - Duminica', 'Abilitati 10'),
    (11, 'Alexandra Georgescu', 'Str. Luminii nr. 55', 'alexandra.georgescu@example.com', '0812345678', 'Experienta 11', 'Oricand', 'Abilitati 11'),
    (12, 'Cristian Iacob', 'Str. Stelelor nr. 60', 'cristian.iacob@example.com', '0823456789', 'Experienta 12', 'Weekend', 'Abilitati 12'),
    (13, 'Laura Popa', 'Str. Luna nr. 65', 'laura.popa@example.com', '0834567890', 'Experienta 13', 'Luni - Miercuri seara', 'Abilitati 13'),
    (14, 'Stefan Andrei', 'Str. Noptii nr. 70', 'stefan.andrei@example.com', '0845678901', 'Experienta 14', 'Sambata - Duminica', 'Abilitati 14'),
    (15, 'Ioana Marinescu', 'Str. Razei nr. 75', 'ioana.marinescu@example.com', '0856789012', 'Experienta 15', 'Joi - Duminica', 'Abilitati 15'),
    (16, 'Adrian Ionescu', 'Str. Soarelui nr. 80', 'adrian.ionescu@example.com', '0867890123', 'Experienta 16', 'Luni - Vineri dupa-amiaza',
	'Abilitati 16'),
    (17, 'Andrei Popescu', 'Str. Florilor nr. 85', 'andrei.popescu@example.com', '0878901234', 'Experienta 17', 'Weekend', 'Abilitati 17'),
    (18, 'Ana Maria Georgescu', 'Str. Plopilor nr. 90', 'anamaria.georgescu@example.com', '0889012345', 'Experienta 18', 'Oricand', 'Abilitati 18'),
    (19, 'Vlad Dumitrescu', 'Str. Crinilor nr. 95', 'vlad.dumitrescu@example.com', '0890123456', 'Experienta 19', 'Sambata', 'Abilitati 19'),
    (20, 'Catalin Radulescu', 'Str. Magnoliei nr. 100', 'catalin.radulescu@example.com', '0901234567', 'Experienta 20', 'Luni - Miercuri', 
	'Abilitati 20'),
	(21, 'Mihai Popescu', 'Str. Crizantemelor nr. 105', 'mihai.popescu@example.com', '0912345678', 'Experienta 21', NULL, 'Abilitati 21');
	
-- Inserare în tabelul Organizatii
INSERT INTO Organizatii (id_organizatie, nume_organizatie, adresa, email, telefon, tip_organizatie)
VALUES 
    (1, 'Organizatia XYZ', 'Str. Libertatii nr. 10', 'contact@organizatiaxyz.com', '0211234567', 'Tip 1'),
    (2, 'Asociatia ABC', 'Str. Independentei nr. 15', 'contact@asociatieabc.com', '0312345678', 'Tip 2'),
    (3, 'Fundatia DEF', 'Str. Unirii nr. 20', 'contact@fundatiadef.org', '0413456789', 'Tip 3'),
    (4, 'ONG GHI', 'Str. Victoriei nr. 25', 'contact@ongghi.ro', '0514567890', 'Tip 4'),
    (5, 'Fundatia JKL', 'Str. Revolutiei nr. 30', 'contact@fundatiajkl.org', '0615678901', 'Tip 5'),
	(6, 'Centrul de Recuperare Mihai Eminescu', 'Str. Eminescu nr. 5', 'contact@crmihaieminescu.com', '0712345678', 'Tip 6'),
    (7, 'Asociatia Speranta pentru Viitor', 'Str. Sperantei nr. 10', 'contact@speranta.com', '0723456789', 'Tip 7'),
    (8, 'Fundatia Copiii Lumii', 'Str. Copiilor nr. 15', 'contact@copiiilumii.org', '0734567890', 'Tip 8'),
    (9, 'Organizatia Salvati Rosia Montana', 'Str. Rosia Montana nr. 20', 'contact@salvarosiamontana.com', '0745678901', 'Tip 9'),
    (10, 'Asociatia Prietenii Animalelor', 'Str. Animalelor nr. 25', 'contact@prieteniianimalelor.org', '0756789012', 'Tip 10'),
    (11, 'Fundatia pentru Protectia Mediului', 'Str. Mediului nr. 30', 'contact@protejaremediu.ro', '0767890123', 'Tip 11'),
    (12, 'Asociatia pentru Drepturile Omului', 'Str. Drepturilor nr. 35', 'contact@drepturiumane.org', '0778901234', 'Tip 12'),
    (13, 'Centrul pentru Educatie Incluziva', 'Str. Educatiei nr. 40', 'contact@educatieincluziva.com', '0789012345', 'Tip 13'),
    (14, 'Fundatia pentru Cultura si Arta', 'Str. Culturii nr. 45', 'contact@culturasiarta.org', '0790123456', 'Tip 14'),
    (15, 'Asociatia pentru Protectia Copilului', 'Str. Protectiei nr. 50', 'contact@apcopil.ro', '0801234567', 'Tip 15');

-- Inserare în tabelul Activitati_voluntariat
INSERT INTO Activitati_voluntariat (id_activitate, nume_activitate, data_inceperii, data_finalizarii, descriere, id_organizatie)
VALUES 
    (1, 'Curatenie parcul local', '2024-04-01', '2024-04-01', 'Curatenie in parcul din cartierul X.', 1),
    (2, 'Activitate de promovare a reciclarii', '2024-04-05', '2024-04-05',
	'Promovarea reciclarii in scolile din oras.', 2),
    (3, 'Asistenta pentru persoanele in varsta', '2024-04-10', '2024-04-10', 'Asistenta si companie 
	pentru persoanele in varsta din azilul local.', 3),
    (4, 'Activitate sportiva in aer liber', '2024-04-15', '2024-04-15', 'Activitate sportiva in parc.', 4),
    (5, 'Atelier de gatit pentru copii', '2024-04-20', '2024-04-20', 'Atelier de gatit pentru copiii din centrele de plasament.', 5),
	(6, 'Plantare de arbori', '2024-04-25', '2024-04-25', 'Activitate de plantare a arborilor in parcul local.', 6),
    (7, 'Vizita la batranii singuri', '2024-05-05', '2024-05-05', 'Vizita si socializare cu batranii din comunitatea noastra.', 7),
    (8, 'Activitate de igienizare a plajei', '2024-05-15', '2024-05-15', 'Curatenie si igienizare a plajei pentru protejarea mediului.', 8),
    (9, 'Program de lectura pentru copii', '2024-06-01', '2024-06-01', 'Organizare de sesiuni de lectura pentru copiii din orfelinate.', 9),
    (10, 'Asistenta medicala gratuita', '2024-06-15', '2024-06-15', 'Oferirea de consultatii medicale gratuite in comunitatile defavorizate.', 10);

-- Inserare în tabelul Proiecte
INSERT INTO Proiecte (id_proiect, nume_proiect, descriere, data_inceperii, data_finalizarii, buget, id_organizatie)
VALUES 
    (1, 'Proiect educational', 'Proiectul consta in organizarea unor cursuri gratuite pentru copiii din comunitate.', '2024-05-01', '2024-12-31', 
	50000.00, 1),
    (2, 'Proiect social de combatere a saraciei', 'Proiectul urmareste ajutorarea familiilor defavorizate din zona X.', '2024-06-01', 
	'2024-11-30', 75000.00, 2),
    (3, 'Proiect de mediu', 'Proiectul implica plantarea a 1000 de arbori in zona urbana.', '2024-07-01', '2024-08-31', 25000.00, 3),
    (4, 'Proiect cultural', 'Organizarea unui festival de arta si cultura in oras.', '2024-08-01', '2024-08-15', 40000.00, 4),
    (5, 'Proiect medical', 'Dotarea unui spital local cu echipamente medicale moderne.', '2024-09-01', '2024-10-31', 60000.00, 5),
	(6, 'Proiect de promovare a artei si culturii locale', 'Proiectul are ca obiectiv promovarea si dezvoltarea artei si culturii locale prin 
	organizarea de expozitii, spectacole si ateliere creative.', '2024-10-01', '2025-03-31', 55000.00, 6),
    (7, 'Proiect de refacere a infrastructurii scolare', 'Proiectul vizeaza renovarea si modernizarea infrastructurii scolare pentru a oferi un
	mediu educational mai bun pentru elevi.', '2024-11-01', '2025-04-30', 70000.00, 7),
    (8, 'Proiect de sprijinire a comunitatii de varstnici', 'Proiectul urmareste oferirea de suport si asistenta varstnicilor din comunitate prin
	organizarea de activitati recreative si servicii de ingrijire la domiciliu.', '2025-01-01', '2025-06-30', 60000.00, 8),
    (9, 'Proiect de promovare a ecoturismului', 'Proiectul are ca scop promovarea si dezvoltarea ecoturismului in zona naturala protejata prin 
	organizarea de trasee si evenimente tematice.', '2025-02-01', '2025-07-31', 80000.00, 9),
    (10, 'Proiect de revitalizare urbana', 'Proiectul implica reabilitarea si modernizarea infrastructurii urbane pentru a revitaliza centrul
	orasului si a imbunatati calitatea vietii locuitorilor.', '2025-03-15', '2025-09-15', 90000.00, 10);

-- Inserare în tabelul Participari_voluntari
INSERT INTO Participari_voluntari (id_participare, id_voluntar, id_activitate, data_participare, ore_lucrate, feedback)
VALUES 
    (1, 1, 1, '2024-04-01', 4, 'Activitatea a fost foarte placuta.'),
    (2, 2, 2, '2024-04-05', 3, 'Experienta foarte buna, as repeta cu placere.'),
    (3, 3, 3, '2024-04-10', 5, 'Ma simt binecuvantat sa pot ajuta.'),
    (4, 4, 4, '2024-04-15', 6, 'Atmosfera distractiva si prietenoasa.'),
    (5, 5, 5, '2024-04-20', 4, 'Copiii au fost foarte entuziasmati si talentati.'),
	(6, 6, 6, '2024-04-25', 3, 'M-am simtit onorat sa particip la aceasta activitate.'),
    (7, 7, 7, '2024-04-30', 5, 'O experienta minunata, ma bucur ca am putut contribui.'),
    (8, 8, 8, '2024-05-05', 4, 'Activitatea a fost organizata si plina de invataminte.'),
    (9, 9, 9, '2024-05-10', 6, 'Am avut parte de o echipa minunata si de un mediu prietenos.'),
    (10, 10, 10, '2024-05-15', 4, 'Ma simt implinit sa vad impactul pe care l-am avut in comunitate.'),
    (11, 11, 1, '2024-05-20', 3, 'Experienta m-a motivat sa continui sa fiu voluntar.'),
    (12, 12, 2, '2024-05-25', 5, 'O modalitate excelenta de a petrece timpul si de a face o diferenta.'),
    (13, 13, 3, '2024-05-30', 6, 'M-am simtit inspirat de determinarea celor din jur.'),
    (14, 14, 4, '2024-06-05', 4, 'O experienta memorabila pe care o voi tine minte pentru mult timp.'),
    (15, 15, 5, '2024-06-10', 3, 'Ma bucur sa fac parte din acest proiect si sa contribui la comunitate.');


-- Inserare în tabelul Competente
INSERT INTO Competente (id_competenta, nume_competenta)
VALUES 
    (1, 'Lucrul în echipa'),
    (2, 'Comunicare eficienta'),
    (3, 'Organizare si planificare'),
    (4, 'Abilitati tehnice'),
    (5, 'Gestionarea timpului'),
	(6, 'Leadership'),
    (7, 'Creativitate'),
    (8, 'Resilienta'),
    (9, 'Analiz? critica'),
    (10, 'Adaptabilitate');

-- Inserare în tabelul Voluntari_Competente
INSERT INTO Voluntari_Competente (id_voluntar, id_competenta, nivel)
VALUES 
    (1, 1, 4),
    (2, 2, 5),
    (3, 3, 4),
    (4, 4, 3),
    (5, 5, 4),
	(6, 6, 4),
    (7, 7, 5),
    (8, 8, 4),
    (9, 9, 3),
    (10, 10, 4),
    (11, 1, 4),
    (12, 2, 5),
    (13, 3, 4),
    (14, 4, 3),
    (15, 5, 4);

-- Inserare in tabelul Evenimente
INSERT INTO Evenimente (id_eveniment, nume_eveniment, data_inceperii, data_finalizarii, locatie, descriere, id_organizatie)
VALUES 
    (1, 'Concert caritabil', '2024-04-25', '2024-04-25', 'Piata Centrala', 'Concert caritabil pentru strangerea de fonduri pentru copiii bolnavi.'
	, 1),
    (2, 'Targul de sanatate', '2024-05-05', '2024-05-05', 'Parcul Verde', 'Targ de sanatate cu consultatii gratuite.', 2),
    (3, 'Cros pentru mediu', '2024-05-15', '2024-05-15', 'Padurea Frumoasa', 'Cros pentru strangerea de fonduri pentru protectia mediului.', 3),
    (4, 'Ziua mondiala a alimentatiei', '2024-06-01', '2024-06-01', 'Piata Mare', 'Eveniment pentru constientizarea importantei unei alimentatii 
	sanatoase.', 4),
    (5, 'Expozitie de arta', '2024-06-15', '2024-06-15', 'Muzeul de Arta', 'Expozitie de arta pentru sustinerea tinerilor artisti locali.', 5),
	(6, 'Maraton de donare de sange', '2024-07-10', '2024-07-10', 'Spitalul Municipal', 'Eveniment pentru colectarea de sange pentru pacientii
	în nevoie.', 1),
    (7, 'Conferinta despre protectia mediului', '2024-08-05', '2024-08-05', 'Universitatea Centrala', 'Conferinta despre importanta protejarii
	mediului înconjur?tor.', 2),
    (8, 'Festivalul culturii asiatice', '2024-08-20', '2024-08-22', 'Centrul Cultural', 'Festival dedicat promovarii culturii asiatice si
	intelegerii interculturale.', 3),
    (9, 'Curs intensiv de prim ajutor', '2024-09-05', '2024-09-07', 'Crucea Rosie', 'Curs pentru invatarea tehnicilor de prim ajutor în 
	situatii de urgenta.', 4),
    (10, 'Expozitie de fotografie', '2024-10-15', '2024-10-15', 'Galeria de Arta Moderna', 'Expozitie de fotografie pentru promovarea talentelor
	locale.', 5);

-- Inserare in tabelul Participari_evenimente
INSERT INTO Participari_evenimente (id_participare_eveniment, id_voluntar, id_eveniment, data_participare)
VALUES 
    (1, 1, 1, '2024-04-25'),
    (2, 2, 2, '2024-05-05'),
    (3, 3, 3, '2024-05-15'),
    (4, 4, 4, '2024-06-01'),
    (5, 5, 5, '2024-06-15'),
	(6, 6, 6, '2024-07-10'),
    (7, 7, 7, '2024-08-05'),
    (8, 8, 8, '2024-08-20'),
    (9, 9, 9, '2024-09-05'),
    (10, 10, 10, '2024-10-15'),
    (11, 11, 1, '2024-04-25'),
    (12, 12, 2, '2024-05-05'),
    (13, 13, 3, '2024-05-15'),
    (14, 14, 4, '2024-06-01'),
    (15, 15, 5, '2024-06-15'),
    (16, 16, 6, '2024-07-10'),
    (17, 17, 7, '2024-08-05'),
    (18, 18, 8, '2024-08-20'),
    (19, 19, 9, '2024-09-05'),
    (20, 20, 10, '2024-10-15');
	
-- Inserare in tabelul Feedback_voluntari
INSERT INTO Feedback_voluntari (id_feedback, id_voluntar, id_activitate, rating, comentariu)
VALUES
    (1, 1, 1, 5, 'Activitate excelenta, organizare impecabila.'),
    (2, 2, 2, 4, 'Eveniment interesant, dar ar fi putut fi mai bine promovat.'),
    (3, 3, 3, 5, 'Experienta foarte placuta, persoanele in varsta au fost foarte recunoscatoare.'),
    (4, 4, 4, 4, 'Eveniment reusit, cu o atmosfera placuta.'),
    (5, 5, 5, 5, 'Copiii au fost extraordinari, un eveniment minunat.'),
	(6, 6, 6, 4, 'Eveniment interesant, dar organizarea poate fi imbunatatita.'),
    (7, 7, 7, 5, 'Activitate excelenta, cu o echipa bine coordonata.'),
    (8, 8, 8, 4, 'Atmosfera placuta, dar mai multe activitati ar fi fost binevenite.'),
    (9, 9, 9, 5, 'Eveniment de impact, multumit ca am putut contribui.'),
    (10, 10, 10, 5, 'O experienta minunata, evenimentul a fost bine organizat.'),
    (11, 11, 1, 4, 'Activitate interesanta, dar ar fi fost bine sa fie mai multe activitati.'),
    (12, 12, 2, 5, 'Eveniment reusit, cu o promovare eficienta.'),
    (13, 13, 3, 4, 'Oportunitate de a interactiona cu persoanele in varsta, dar mai mult timp ar fi fost benefic.'),
    (14, 14, 4, 5, 'Atmosfera distractiva si prietenoasa, un eveniment de succes.'),
    (15, 15, 5, 4, 'Copiii au fost entuziasmati, dar ar fi fost bine sa fie mai multe activitati.'),
	(16, 16, 6, 5, 'Activitate excelenta, ma bucur ca am putut ajuta.'),
    (17, 17, 7, 4, 'Eveniment interesant, dar organizarea poate fi imbunatatita.'),
    (18, 18, 8, 5, 'M-am simtit binecuvantat sa pot participa la acest eveniment.'),
    (19, 19, 9, 4, 'O experienta minunata, dar ar fi fost bine sa avem mai mult timp.'),
    (20, 20, 10, 5, 'Evenimentul a fost bine organizat si placut.');

-- Inserare în tabelul Competente_Activitati
INSERT INTO Competente_Activitati (id_activitate, id_competenta)
VALUES 
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
	(6, 7),
	(7, 9),
	(8, 10),
	(9, 8),
	(10, 9);

-- Inserare în tabelul Evenimente_Voluntari
INSERT INTO Evenimente_Voluntari (id_eveniment, id_voluntar)
VALUES 
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
	(6, 7),
	(7, 9),
	(8, 19),
	(9, 7),
	(10, 11);

SELECT * FROM Voluntari
SELECT id_voluntar, nume_voluntar FROM Voluntari
SELECT nume_voluntar, email, telefon FROM Voluntari
SELECT id_activitate, rating, comentariu FROM Feedback_voluntari
SELECT nume_activitate, DATEDIFF(DAY, data_inceperii, data_finalizarii) AS durata FROM Activitati_voluntariat
SELECT nume_eveniment, CONCAT(data_inceperii, '<->' ,data_finalizarii) AS interval FROM Evenimente

SELECT * FROM Activitati_voluntariat 
WHERE data_inceperii BETWEEN '2024-04-01' AND '2024-04-05' 

SELECT * FROM Activitati_voluntariat 
WHERE data_inceperii >= DATEADD(DAY, -7, GETDATE()) 

SELECT  
  nume_proiect, 
    LEN(nume_proiect) AS LungimeNume,  
    UPPER(nume_proiect) AS NuMEpROIECTMajuscule,  
    LEFT(nume_proiect, 9) AS PrimeleTreiCaractere  
FROM  
    Proiecte;
	
 SELECT * FROM Voluntari 
ORDER BY nume_voluntar COLLATE Latin1_General_CI_AS 

SELECT TOP 2 * FROM Organizatii ORDER BY telefon DESC 

SELECT TOP 2 * FROM Organizatii WHERE id_organizatie < 4 ORDER BY telefon DESC

SELECT id_eveniment, nume_eveniment FROM Evenimente WHERE (nume_eveniment LIKE 'C%') OR id_organizatie < 5

SELECT * FROM Evenimente ORDER BY id_eveniment DESC, nume_eveniment COLLATE Latin1_General_CI_AS 

SELECT nume_eveniment + '-' + locatie AS concatenare FROM Evenimente 

--1 Vreau data participarii, orele lucrate si feedback-ul din tabelul Participari_voluntari atunci 
-- cand data participarii este mai mica decat '2024-05-05'
SELECT data_participare , ore_lucrate, feedback FROM Participari_voluntari WHERE data_participare < '2024-05-05'

--2 Vreau numele activitatii, lungimea acestuia, numele scris cu majuscule si primele 10 caractere ale numelui scrise de la stanga
-- la dreapta din tabelul Activitati_voluntariat
SELECT nume_activitate, LEN(nume_activitate) AS LungimeNume, UPPER(nume_activitate) AS NumeMajuscule, LEFT(nume_activitate, 10) AS primele10caract FROM Activitati_voluntariat

--3 Vreau toate coloanele din tabelul Voluntari sortate dupa nume_voluntar alfabetic crescator
SELECT * FROM Voluntari ORDER BY nume_voluntar ASC

--4 Vreau primele trei randuri cu toate coloanele din tabelul Feedback_voluntari care au rating-ul mai mare ca 2
SELECT TOP 3 * FROM Feedback_voluntari WHERE rating > 2

--5 Vreau nume_proiect, descriere si buget din tabelul Proiecte care au id_ul mai mare ca 3 si sunt sortate crescator in functie de buget
SELECT nume_proiect, descriere, buget FROM Proiecte WHERE id_proiect > 3 ORDER BY buget ASC

--6 Vreau toate elementele tabelului Competente unde id-ul competentei este mai mare ca 3 si numele competentei incepe cu litera 'C' 
-- (combinarea a doua predicate)
SELECT * FROM Competente WHERE id_competenta > 3 AND nume_competenta LIKE 'C%'

--7 Vreau toate elementele tabelului Activitati_voluntariat sortate dupa id descrescator si nume alfabetic crescator
SELECT * FROM Activitati_voluntariat ORDER BY id_activitate DESC, nume_activitate ASC
-- Obs. In acest caz rezultatul este doar in functie de prima conditie, a doua nefiind executata deoarece ar fi 
-- schimbat ordinea primului

--8 Concateneaza numele voluntarului, email-ul si disponibilitatea orarului sub numele Nume_Email_Disponibilitate din tabelul Voluntari
-- in care este permis si NULL
SELECT CONCAT(nume_voluntar,'->', email) AS Nume_Email FROM Voluntari

--9 Selectarea distincta a numelui competentei si a id-ului competenei din tabelul Competente cu proprietatea ca numele este diferit de 'Leadership' 
-- si id-ul este mai mare decat 4
SELECT DISTINCT nume_competenta, id_competenta FROM Competente WHERE nume_competenta != 'Leadership' AND id_competenta > 4

INSERT INTO Participari_voluntari (id_participare, id_voluntar, id_activitate, data_participare, ore_lucrate, feedback)
VALUES 
    (16, 16, 6, '2024-06-15', 4, 'Activitatea a fost foarte interesantă.');

DELETE FROM Participari_voluntari WHERE id_participare = 16;

select Feedback_voluntari.id_voluntar, Feedback_voluntari.comentariu, Voluntari.nume_voluntar, Voluntari.experienta_anterioara
from Feedback_voluntari cross join Voluntari
where Feedback_voluntari.id_voluntar=Voluntari.id_voluntar

select Voluntari_Competente.nivel, Voluntari.nume_voluntar, Voluntari.abilitati, Competente.nume_competenta
from Voluntari_Competente cross join Voluntari cross join Competente
where Voluntari_Competente.id_voluntar=Voluntari.id_voluntar and Voluntari_Competente.id_competenta=Competente.id_competenta

select Organizatii.nume_organizatie, Organizatii.adresa, Activitati_voluntariat.nume_activitate
from Organizatii inner join Activitati_voluntariat
on Organizatii.id_organizatie=Activitati_voluntariat.id_organizatie

select p.data_participare, v.nume_voluntar, v.email + '<->' + v.telefon as email_telefon
from Participari_evenimente as p inner join Voluntari as v
on p.id_voluntar=v.id_voluntar

select e.id_eveniment, v.nume_voluntar
from Voluntari as v left outer join Evenimente_Voluntari as e
on  e.id_voluntar=v.id_voluntar

select e.id_eveniment, v.nume_voluntar
from Voluntari as v right outer join Evenimente_Voluntari as e
on  e.id_voluntar=v.id_voluntar

select e.id_eveniment, v.nume_voluntar
from Voluntari as v left outer join Evenimente_Voluntari as e
on  e.id_voluntar=v.id_voluntar
where e.id_voluntar < 7

select adresa
from Voluntari 
except
select adresa
from Organizatii 

select adresa
from Voluntari
union
select adresa
from Organizatii

select count(*) as Number_of_volunteers from Voluntari

select id_activitate, count(*) as activitati from Participari_voluntari group by id_activitate

select  month(data_inceperii) as luna_inceperii, count (*) as nr_evenimente from Evenimente
group by month(data_inceperii)

SELECT id_activitate, COUNT(id_voluntar) AS numar_voluntari
FROM Participari_voluntari
GROUP BY id_activitate
HAVING COUNT(id_voluntar) > 0;

select nume_eveniment,
	count (distinct data_inceperii) as date_incepere
from Evenimente
group by nume_eveniment;

SELECT pv.id_participare, v.nume_voluntar, av.nume_activitate
FROM Participari_voluntari pv
INNER JOIN Voluntari v ON pv.id_voluntar = v.id_voluntar
INNER JOIN Activitati_voluntariat av ON pv.id_activitate = av.id_activitate;

SELECT pe.id_participare_eveniment, v.nume_voluntar, e.nume_eveniment
FROM Participari_evenimente pe
INNER JOIN Voluntari v ON pe.id_voluntar = v.id_voluntar
INNER JOIN Evenimente e ON pe.id_eveniment = e.id_eveniment;

SELECT pv.id_participare, av.nume_activitate, fv.rating, fv.comentariu
FROM Participari_voluntari pv
INNER JOIN Activitati_voluntariat av ON pv.id_activitate = av.id_activitate
INNER JOIN Feedback_voluntari fv ON pv.id_voluntar = fv.id_voluntar AND pv.id_activitate = fv.id_activitate;

SELECT v.nume_voluntar, c.nume_competenta, vc.nivel
FROM Voluntari v
INNER JOIN Voluntari_Competente vc ON v.id_voluntar = vc.id_voluntar
INNER JOIN Competente c ON vc.id_competenta = c.id_competenta;

SELECT v.nume_voluntar, pv.id_participare
FROM Voluntari v
LEFT JOIN Participari_voluntari pv ON v.id_voluntar = pv.id_voluntar;

SELECT e.nume_eveniment, pe.id_participare_eveniment
FROM Evenimente e
RIGHT JOIN Participari_evenimente pe ON e.id_eveniment = pe.id_eveniment;

SELECT v.nume_voluntar, vc.nivel
FROM Voluntari v
FULL JOIN Voluntari_Competente vc ON v.id_voluntar = vc.id_voluntar;

SELECT v.nume_voluntar, e.nume_eveniment
FROM Voluntari v
JOIN Participari_voluntari pv ON v.id_voluntar = pv.id_voluntar
JOIN Participari_evenimente pe ON pv.id_participare = pe.id_participare_eveniment
JOIN Evenimente e ON pe.id_eveniment = e.id_eveniment;

SELECT o.tip_organizatie, COUNT(v.id_voluntar) AS numar_voluntari
FROM Organizatii o
LEFT JOIN Activitati_voluntariat a ON o.id_organizatie = a.id_organizatie
LEFT JOIN Participari_voluntari p ON a.id_activitate = p.id_activitate
LEFT JOIN Voluntari v ON p.id_voluntar = v.id_voluntar
GROUP BY o.tip_organizatie;

SELECT v.nume_voluntar, SUM(p.ore_lucrate) AS ore_lucrate
FROM Voluntari v
LEFT JOIN Participari_voluntari p ON v.id_voluntar = p.id_voluntar
GROUP BY v.nume_voluntar;

SELECT a.nume_activitate, AVG(f.rating) AS media_rating
FROM Activitati_voluntariat a
LEFT JOIN Feedback_voluntari f ON a.id_activitate = f.id_activitate
GROUP BY a.nume_activitate;

SELECT v.nume_voluntar, COUNT(vc.id_competenta) AS numar_competente
FROM Voluntari v
LEFT JOIN Voluntari_Competente vc ON v.id_voluntar = vc.id_voluntar
GROUP BY v.nume_voluntar;

SELECT disponibilitate_orar, COUNT(*) AS numar_voluntari
FROM Voluntari
GROUP BY disponibilitate_orar;

SELECT tip_organizatie, SUM(buget) AS suma_buget
FROM Proiecte
JOIN Organizatii ON Proiecte.id_organizatie = Organizatii.id_organizatie
GROUP BY tip_organizatie;

SELECT nume_eveniment, COUNT(*) AS numar_participanti
FROM Evenimente_Voluntari
JOIN Evenimente ON Evenimente_Voluntari.id_eveniment = Evenimente.id_eveniment
GROUP BY nume_eveniment;

SELECT disponibilitate_orar, COUNT(*) AS numar_voluntari
FROM Voluntari
WHERE disponibilitate_orar IS NOT NULL
GROUP BY disponibilitate_orar;

SELECT rating, COUNT(*) AS numar_evaluari
FROM Feedback_voluntari
GROUP BY rating;

SELECT O.nume_organizatie, COUNT(EV.id_eveniment) AS numar_evenimente
FROM Evenimente_Voluntari EV
JOIN Evenimente E ON EV.id_eveniment = E.id_eveniment
JOIN Organizatii O ON E.id_organizatie = O.id_organizatie
GROUP BY O.nume_organizatie;

SELECT adresa
FROM Voluntari
UNION ALL
SELECT adresa
FROM Organizatii;

SELECT adresa
FROM Voluntari
INTERSECT
SELECT adresa
FROM Organizatii;

WITH VoluntariCuComunicare AS (
    SELECT v.nume_voluntar, v.abilitati
    FROM Voluntari v
    JOIN Voluntari_Competente vc ON v.id_voluntar = vc.id_voluntar
    JOIN Competente c ON vc.id_competenta = c.id_competenta
    WHERE c.nume_competenta = 'Comunicare eficienta'
)
SELECT *
FROM VoluntariCuComunicare;

WITH EvenimenteCulturale AS (
    SELECT o.nume_organizatie, e.nume_eveniment
    FROM Organizatii o
    JOIN Evenimente e ON o.id_organizatie = e.id_organizatie
    WHERE e.descriere LIKE '%arta%' OR e.descriere LIKE '%cultur%'
)
SELECT *
FROM EvenimenteCulturale;

WITH ProiecteActive AS (
    SELECT id_organizatie, nume_proiect, data_inceperii, data_finalizarii
    FROM Proiecte
    WHERE YEAR(data_inceperii) = YEAR(GETDATE())
)
SELECT o.nume_organizatie, pa.nume_proiect
FROM Organizatii o
JOIN ProiecteActive pa ON o.id_organizatie = pa.id_organizatie;

WITH ProiecteOrganizatii AS (
    SELECT id_organizatie, COUNT(*) AS numar_proiecte
    FROM Proiecte
    GROUP BY id_organizatie
)
SELECT TOP 1 o.nume_organizatie, po.numar_proiecte
FROM Organizatii o
JOIN ProiecteOrganizatii po ON o.id_organizatie = po.id_organizatie
ORDER BY po.numar_proiecte DESC;

WITH Participari AS (
    SELECT id_voluntar
    FROM Participari_evenimente
)
SELECT v.nume_voluntar
FROM Voluntari v
JOIN Participari p ON v.id_voluntar = p.id_voluntar;

WITH ParticipariVoluntari AS (
    SELECT id_voluntar, COUNT(*) AS numar_evenimente
    FROM Participari_evenimente
    GROUP BY id_voluntar
)
SELECT TOP 5 v.nume_voluntar, pv.numar_evenimente
FROM ParticipariVoluntari pv
JOIN Voluntari v ON pv.id_voluntar = v.id_voluntar
ORDER BY pv.numar_evenimente DESC;

WITH RatingMediuVoluntari AS (
    SELECT id_voluntar, AVG(rating) AS rating_mediu
    FROM Feedback_voluntari
    GROUP BY id_voluntar
)
SELECT TOP 5 v.nume_voluntar, rmv.rating_mediu
FROM RatingMediuVoluntari rmv
JOIN Voluntari v ON rmv.id_voluntar = v.id_voluntar
ORDER BY rmv.rating_mediu DESC;

WITH ParticipariEvenimente AS (
    SELECT id_eveniment, COUNT(*) AS numar_participanti
    FROM Participari_evenimente
    GROUP BY id_eveniment
)
SELECT TOP 5 e.nume_eveniment, pe.numar_participanti
FROM ParticipariEvenimente pe
JOIN Evenimente e ON pe.id_eveniment = e.id_eveniment
ORDER BY pe.numar_participanti DESC;

GO
CREATE VIEW Voluntari_Activitati
AS
SELECT
    v.nume_voluntar,
    v.email,
    v.telefon,
    a.nume_activitate,
    a.data_inceperii,
    a.data_finalizarii,
    a.descriere AS descriere_activitate
FROM
    Voluntari v
JOIN
    Participari_voluntari pv ON v.id_voluntar = pv.id_voluntar
JOIN
    Activitati_voluntariat a ON pv.id_activitate = a.id_activitate;

GO
CREATE VIEW Detalii_Participari_Voluntari AS
SELECT pv.id_participare, v.nume_voluntar, a.nume_activitate, pv.data_participare, pv.ore_lucrate, pv.feedback
FROM Participari_voluntari pv
INNER JOIN Voluntari v ON pv.id_voluntar = v.id_voluntar
INNER JOIN Activitati_voluntariat a ON pv.id_activitate = a.id_activitate;

GO
CREATE VIEW Detalii_Proiecte_Organizatii AS
SELECT p.nume_proiect, p.descriere AS descriere_proiect, p.data_inceperii AS data_inceperii_proiect, p.data_finalizarii AS data_finalizarii_proiect,
       p.buget, o.nume_organizatie, o.adresa AS adresa_organizatie, o.email AS email_organizatie, o.telefon AS telefon_organizatie
FROM Proiecte p
INNER JOIN Organizatii o ON p.id_organizatie = o.id_organizatie;

GO
CREATE VIEW Competente_Voluntari AS
SELECT v.nume_voluntar, c.nume_competenta, vc.nivel
FROM Voluntari_Competente vc
INNER JOIN Voluntari v ON vc.id_voluntar = v.id_voluntar
INNER JOIN Competente c ON vc.id_competenta = c.id_competenta;

GO
CREATE VIEW Detalii_Evenimente_Organizatii AS
SELECT e.nume_eveniment, e.data_inceperii AS data_inceperii_eveniment, e.data_finalizarii AS data_finalizarii_eveniment,
       e.locatie, e.descriere AS descriere_eveniment, o.nume_organizatie, o.tip_organizatie
FROM Evenimente e
INNER JOIN Organizatii o ON e.id_organizatie = o.id_organizatie;

GO
CREATE VIEW Feedback_Participari_Voluntari AS
SELECT fv.id_feedback, v.nume_voluntar, a.nume_activitate, fv.rating, fv.comentariu
FROM Feedback_voluntari fv
INNER JOIN Voluntari v ON fv.id_voluntar = v.id_voluntar
INNER JOIN Activitati_voluntariat a ON fv.id_activitate = a.id_activitate;

GO
CREATE VIEW Ore_Lucrate_Activitati AS
SELECT pv.id_activitate, a.nume_activitate, SUM(pv.ore_lucrate) AS ore_total_lucrate
FROM Participari_voluntari pv
INNER JOIN Activitati_voluntariat a ON pv.id_activitate = a.id_activitate
GROUP BY pv.id_activitate, a.nume_activitate;






--17.05.2024
--proceduri


--1) Este necesară o procedură stocată denumită GetVolunteersByEvent care să primească ca parametru un ID 
-- de eveniment și să returneze toate informațiile despre voluntarii care participă la acel eveniment. 
-- Procedura va face o selecție din tabelul Voluntari (v), folosind o asociere internă (INNER JOIN) cu 
-- tabelul Participari_evenimente (pe), pe baza corespondenței dintre ID-urile voluntarilor.

GO
CREATE PROCEDURE GetVolunteersByEvent
    @EventID INT
AS
BEGIN
    SELECT v.*
    FROM Voluntari v
    INNER JOIN Participari_evenimente pe ON v.id_voluntar = pe.id_voluntar
    WHERE pe.id_eveniment = @EventID;
END;

EXEC GetVolunteersByEvent @EventID = 1;



--2
-- Este necesară o procedură stocată denumită GetActivitiesByVolunteer care să primească ca parametru un 
-- ID de voluntar și să returneze toate informațiile despre activitățile de voluntariat la care a 
-- participat acel voluntar. Procedura va face o selecție din tabelul Activitati_voluntariat (a), folosind 
-- o asociere internă (INNER JOIN) cu tabelul Participari_voluntari (pv), pe baza corespondenței dintre 
-- ID-urile activităților și voluntarilor.

GO
CREATE PROCEDURE GetActivitiesByVolunteer
    @VolunteerID INT
AS
BEGIN
    SELECT a.*
    FROM Activitati_voluntariat a
    INNER JOIN Participari_voluntari pv ON a.id_activitate = pv.id_activitate
    WHERE pv.id_voluntar = @VolunteerID;
END;

EXEC GetActivitiesByVolunteer @VolunteerID = 3;


--3
-- Este necesară o procedură stocată denumită GetVolunteerSkills care să primească ca parametru un ID 
-- de voluntar și să returneze toate informațiile despre competențele voluntarului respectiv, împreună 
-- cu nivelul fiecărei competențe. Procedura va face o selecție din tabelul Competente (c), folosind o
-- asociere internă (INNER JOIN) cu tabelul Voluntari_Competente (vc), pe baza corespondenței dintre 
-- ID-urile competențelor și voluntarilor.
GO
CREATE PROCEDURE GetVolunteerSkills
    @VolunteerID INT
AS
BEGIN
    SELECT c.*, vc.nivel
    FROM Competente c
    INNER JOIN Voluntari_Competente vc ON c.id_competenta = vc.id_competenta
    WHERE vc.id_voluntar = @VolunteerID;
END;

EXEC GetVolunteerSkills @VolunteerID = 1;

--4
-- Elaborați un scenariu în care este necesar să adăugați un voluntar nou în baza de date a organizației 
-- folosind procedura stocată AddVolunteer. Specificați detalii precum ID-ul voluntarului, numele, adresa,
-- email-ul, telefonul, experiența anterioară, disponibilitatea și abilitățile. Apoi, executați procedura 
-- stocată cu aceste detalii.
GO
CREATE PROCEDURE AddVolunteer
    @Id INT,
    @Nume NVARCHAR(100),
    @Adresa NVARCHAR(100),
    @Email NVARCHAR(100),
    @Telefon NVARCHAR(20),
    @Experienta NVARCHAR(100),
    @Disponibilitate NVARCHAR(100),
    @Abilitati NVARCHAR(100)
AS
BEGIN
    INSERT INTO Voluntari (id_voluntar, nume_voluntar, adresa, email, telefon, experienta_anterioara, disponibilitate_orar, abilitati)
    VALUES (@Id, @Nume, @Adresa, @Email, @Telefon, @Experienta, @Disponibilitate, @Abilitati);
END;


EXEC AddVolunteer 
	@Id = 22,
    @Nume = 'Mihai Popescu',
    @Adresa = 'Bucuresti, str. 13 Septembrie',
    @Email = 'mihai@gmail.com',
    @Telefon = '0766567888',
    @Experienta = 'Experienta 1',
    @Disponibilitate = 'Oricand',
    @Abilitati = 'Abilitati 5';

select * from Voluntari

--5
-- Este necesară o procedură stocată denumită UpdateVolunteerDetails care să primească ca parametri un ID 
-- de voluntar și informațiile actualizate despre numele, adresa, email-ul, telefonul, experiența 
-- anterioară, disponibilitatea și abilitățile voluntarului. Procedura va actualiza corespunzător aceste 
-- informații în tabelul Voluntari.
GO
CREATE PROCEDURE UpdateVolunteerDetails
    @VolunteerID INT,
    @Nume NVARCHAR(100),
    @Adresa NVARCHAR(100),
    @Email NVARCHAR(100),
    @Telefon NVARCHAR(20),
    @Experienta NVARCHAR(100),
    @Disponibilitate NVARCHAR(100),
    @Abilitati NVARCHAR(100)
AS
BEGIN
    UPDATE Voluntari
    SET nume_voluntar = @Nume, adresa = @Adresa, email = @Email, telefon = @Telefon,
        experienta_anterioara = @Experienta, disponibilitate_orar = @Disponibilitate, abilitati = @Abilitati
    WHERE id_voluntar = @VolunteerID;
END;

EXEC UpdateVolunteerDetails 
    @VolunteerID = 1,
    @Nume = 'Nume Actualizat',
    @Adresa = 'Adresa Actualizata',
    @Email = 'actualizat@example.com',
    @Telefon = '9876543210',
    @Experienta = 'Experienta Actualizata',
    @Disponibilitate = 'Disponibilitate Actualizata',
    @Abilitati = 'Abilitati Actualizate';

	SELECT * FROM Voluntari


--6
-- Este necesară o procedură stocată denumită GetVolunteerActivities care să primească ca parametru un ID
-- de voluntar și să returneze informațiile relevante despre activitățile de voluntariat la care a 
-- participat acesta, inclusiv numele activității, datele de început și finalizare, descrierea activității
-- și numele organizației care a organizat activitatea.
GO
CREATE PROCEDURE GetVolunteerActivities
    @VolunteerId INT
AS
BEGIN
    SELECT A.nume_activitate, A.data_inceperii, A.data_finalizarii, A.descriere, O.nume_organizatie
    FROM Activitati_voluntariat A
    INNER JOIN Participari_voluntari P ON A.id_activitate = P.id_activitate
    INNER JOIN Organizatii O ON A.id_organizatie = O.id_organizatie
    WHERE P.id_voluntar = @VolunteerId;
END;

DECLARE @VolunteerIdTest INT = 1; 
EXEC GetVolunteerActivities @VolunteerIdTest;


--7
-- Este necesară o procedură stocată denumită GetVolunteerFeedbackAverage care să primească ca parametru 
-- un ID de voluntar și să returneze media evaluărilor primite de acesta, stocate în tabela 
-- Feedback_voluntari.
GO
CREATE PROCEDURE GetVolunteerFeedbackAverage
    @VolunteerId INT
AS
BEGIN
    DECLARE @AverageRating FLOAT;
    SELECT @AverageRating = AVG(rating)
    FROM Feedback_voluntari
    WHERE id_voluntar = @VolunteerId;

    SELECT @AverageRating AS 'AverageRating';
END;

DECLARE @VolunteerIdtest INT = 1; 
EXEC GetVolunteerFeedbackAverage @VolunteerIdtest;



--2
--tranzactii cu prelucrarea erorilor


--1
-- Este necesar să se creeze o tranzacție care să efectueze în mod sigur operația de inserare a unui nou 
-- voluntar în baza de date. În cazul în care apar erori în timpul operației, tranzacția trebuie să fie 
-- anulată (rollback), asigurând astfel consistența datelor.
BEGIN TRY
    BEGIN TRANSACTION;

    INSERT INTO Voluntari (id_voluntar, nume_voluntar, adresa, email, telefon, experienta_anterioara, disponibilitate_orar, abilitati)
    VALUES (23, 'Ana Maria Popescu', 'Str. Crizantemelor nr. 110', 'anamaria.popescu@example.com', '0923456789', 'Experienta 22', 'Weekend', 'Abilitati 22');

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH

    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    PRINT ERROR_MESSAGE();
END CATCH;

SELECT * FROM Voluntari


--2 
-- Este necesar să se creeze o tranzacție care să actualizeze descrierea unei activități de voluntariat în 
-- baza de date. În cazul în care apar erori în timpul operației, tranzacția trebuie să fie anulată 
-- (rollback), asigurând astfel consistența datelor.
BEGIN TRY
    BEGIN TRANSACTION;

    UPDATE Activitati_voluntariat
    SET descriere = 'Activitate de curatenie si ecologizare in parcul din cartier.'
    WHERE id_activitate = 1;

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    PRINT ERROR_MESSAGE();
END CATCH;

SELECT * FROM Activitati_voluntariat


--3
-- Este necesar să se creeze o tranzacție care să șteargă în mod corespunzător un voluntar și toate 
-- participările sale din baza de date. În cazul în care apare o eroare în timpul operației, 
-- tranzacția trebuie să fie anulată (rollback), pentru a asigura consistența datelor.

BEGIN TRY
    BEGIN TRANSACTION;

    DELETE FROM Participari_voluntari WHERE id_voluntar = 22;

    DELETE FROM Voluntari WHERE id_voluntar = 22;

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    PRINT ERROR_MESSAGE();
END CATCH;

select * from Participari_voluntari
select * from Voluntari

--4
-- Este necesar să se creeze o tranzacție care să actualizeze bugetul unui proiect în baza de date. 
-- În cazul în care apare o eroare în timpul operației, tranzacția trebuie să fie anulată (rollback), 
-- pentru a asigura consistența datelor.
BEGIN TRY
    BEGIN TRANSACTION;

    UPDATE Proiecte
    SET buget = buget + 5
    WHERE id_proiect = 1;

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    PRINT ERROR_MESSAGE();
END CATCH;

SELECT * FROM Proiecte

--5
-- Este necesar să se creeze o tranzacție care să actualizeze adresa de email a unui voluntar în baza de 
-- date. În cazul în care apare o eroare în timpul operației, tranzacția trebuie să fie anulată (rollback),
-- pentru a asigura consistența datelor.
BEGIN TRY
    BEGIN TRANSACTION;

    UPDATE Voluntari
    SET email = 'test@tranzactie.com'
    WHERE id_voluntar = 23;

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    PRINT ERROR_MESSAGE();
END CATCH;

Select * from Voluntari


--6
-- Este necesar să se creeze o tranzacție care să efectueze operațiile de inserare a unui eveniment nou și 
-- actualizare a unei evaluări existente în baza de date. În cazul în care apare o eroare în timpul 
-- execuției, tranzacția trebuie să fie anulată (rollback), pentru a asigura consistența datelor.
BEGIN TRY
    BEGIN TRANSACTION;

    INSERT INTO Evenimente (id_eveniment, nume_eveniment, data_inceperii, data_finalizarii, locatie, descriere, id_organizatie)
    VALUES (12, 'Concert pentru caritate', '2024-06-20', '2024-06-20', 'Piata Centrala', 'Concert caritabil pentru colectarea de fonduri pentru copiii defavorizati.', 1);

    UPDATE Feedback_voluntari
    SET rating = 4
    WHERE id_feedback = 2;

    COMMIT;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK;

    PRINT ERROR_MESSAGE();
END CATCH;

select * from Evenimente
select * from Feedback_voluntari where id_feedback = 2

--3
--triggere

--1
-- Să se creeze un trigger în baza de date care să actualizeze automat numărul de ore lucrate pentru
-- fiecare participare voluntară atunci când se adaugă sau se actualizează înregistrări în tabelul 
-- Participari_voluntari. 
GO
CREATE TRIGGER CalculeazaOreLucrate
ON Participari_voluntari
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE Participari_voluntari
    SET Participari_voluntari.ore_lucrate = DATEDIFF(hour, Participari_voluntari.data_participare, GETDATE())
    FROM Participari_voluntari
    JOIN inserted ON Participari_voluntari.id_participare = inserted.id_participare
END;

INSERT INTO Participari_voluntari (id_voluntar, id_participare, data_participare)
VALUES (1, 100, '2024-04-25');

SELECT * FROM Participari_voluntari;

--2
-- Implementați un mecanism de monitorizare a actualizărilor asupra datelor din tabelul Voluntari în baza
-- de date. Acest lucru va permite evidențierea fiecărei operațiuni de actualizare și furnizarea unui 
-- raport despre aceste actualizări.
GO
CREATE TRIGGER AfterUpdateVoluntari
ON Voluntari
AFTER UPDATE
AS
BEGIN
    PRINT 'S-a actualizat un rând în tabelul Voluntari.'
END;

UPDATE Voluntari
SET adresa = 'Str. Nouă nr. 123', telefon = '0777777777'
WHERE id_voluntar = 1;

--3
-- Implementează un trigger care să afișeze numărul total de organizații din tabela Organizatii în 
-- fereastra de mesaje de fiecare dată când sunt efectuate operațiuni de inserare sau ștergere asupra 
-- acestei tabele. Mesajul trebuie să conțină numărul actualizat al organizațiilor. 
GO
CREATE TRIGGER trg_DisplayTotalOrganizatii
ON Organizatii
AFTER INSERT, DELETE
AS
BEGIN
    DECLARE @TotalOrganizatii INT;

    SELECT @TotalOrganizatii = COUNT(*) FROM Organizatii;

    PRINT 'Numarul total de organizatii: ' + CAST(@TotalOrganizatii AS NVARCHAR(10));
END;

INSERT INTO Organizatii (id_organizatie, nume_organizatie, adresa, email, telefon, tip_organizatie)
VALUES 
    (17, 'Asociatia pentru Protejarea Mediului', 'Str. Pădurii nr. 55', 'protectia@protectiamediului.org', '0812345678', 'Tip 16');

--4
-- Implementați o validare a datelor pentru inserările în tabela Evenimente în baza de date. Scopul 
-- acestui trigger este să verifice dacă data de începere a unui eveniment este anterioară datei de 
-- finalizare și, în caz contrar, să arunce o eroare și să anuleze inserarea. 
GO
CREATE TRIGGER trg_validate_evenimente_insert
ON Evenimente
AFTER INSERT
AS
BEGIN
   
    IF EXISTS (SELECT 1 FROM inserted WHERE data_inceperii >= data_finalizarii)
    BEGIN
        RAISERROR ('Data de începere trebuie să fie înainte de data de finalizare!', 16, 1)
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;

INSERT INTO Evenimente (id_eveniment, nume_eveniment, data_inceperii, data_finalizarii, locatie, descriere, id_organizatie)
VALUES 
    (21, 'Concert pentru caritate', '2024-12-01', '2024-11-01', 'Sala de spectacole', 'Concert organizat pentru a strânge fonduri pentru o cauză nobilă.', 1);


--5
-- Validează rating-ului pentru inserările în tabela Feedback_voluntari, asigurându-se că rating-ul se
-- încadrează în intervalul permis (1-5). 
GO
CREATE TRIGGER trg_validate_rating
ON Feedback_voluntari
AFTER INSERT
AS
BEGIN
    DECLARE @Rating INT;

    SELECT @Rating = rating FROM inserted WHERE rating < 1 OR rating > 5;

    IF @Rating IS NOT NULL
    BEGIN
        RAISERROR ('Rating-ul trebuie să fie între 1 și 5!', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;

INSERT INTO Feedback_voluntari (id_feedback, id_voluntar, id_activitate, rating, comentariu)
VALUES 
    (23, 21, 2, 6, 'Comentariu de test pentru a declanșa trigger-ul.');


--6
GO
CREATE TRIGGER trg_validate_competente
ON Competente
AFTER INSERT
AS
BEGIN
    DECLARE @NumeCompetenta NVARCHAR(100);

    SELECT @NumeCompetenta = nume_competenta FROM inserted WHERE nume_competenta LIKE '%[^a-zA-Z0-9]%';

    IF @NumeCompetenta IS NOT NULL
    BEGIN
        RAISERROR ('Numele competenței nu poate conține caractere speciale!', 16, 1);
        ROLLBACK TRANSACTION; 
        RETURN;
    END
END;

INSERT INTO Competente (id_competenta, nume_competenta)
VALUES 
    (11, 'Abilități de programare #SQL');


--7
GO
CREATE TRIGGER trg_auto_increment_feedback_id
ON Feedback_voluntari
AFTER INSERT
AS
BEGIN
    DECLARE @NextFeedbackId INT;
    
    SELECT @NextFeedbackId = ISNULL(MAX(id_feedback), 0) + 1 FROM Feedback_voluntari;
    
    UPDATE Feedback_voluntari SET id_feedback = @NextFeedbackId WHERE id_feedback IS NULL;
END;

INSERT INTO Feedback_voluntari (id_feedback, id_voluntar, id_activitate, rating, comentariu)
VALUES (33, 21, 1, 5, 'Comentariu de test pentru a declansa trigger-ul pentru incrementarea automată a id-ului de feedback.');

INSERT INTO Feedback_voluntari (id_feedback, id_voluntar, id_activitate, rating, comentariu)
SELECT ISNULL(MAX(id_feedback), 0) + 1, 21, 1, 5, 'Comentariu de test pentru a declansa trigger-ul pentru incrementarea automată a id-ului de feedback.'
FROM Feedback_voluntari;

SELECT * FROM Feedback_voluntari

--8
drop trigger trg_update_total_buget_organizatie
GO
CREATE TRIGGER trg_update_total_buget_organizatie
ON Proiecte
AFTER INSERT
AS
BEGIN
    DECLARE @IdOrganizatie INT;
    DECLARE @TotalBuget DECIMAL(18, 2);
    SELECT @IdOrganizatie = id_organizatie FROM inserted;

    SELECT @TotalBuget = SUM(buget) FROM Proiecte WHERE id_organizatie = @IdOrganizatie;

    PRINT 'Bugetul total pentru organizatia cu ID-ul ' + CAST(@IdOrganizatie AS NVARCHAR(10)) + ' a fost actualizat la ' + CAST(@TotalBuget AS NVARCHAR(20));
END;

INSERT INTO Proiecte (id_proiect, nume_proiect, descriere, data_inceperii, data_finalizarii, buget, id_organizatie)
VALUES 
    (39, 'Proiect de renovare a parcurilor', 'Proiectul constă în renovarea și modernizarea parcurilor din oraș.', '2024-05-01', '2024-12-31', 20000.00, 1);


--9
GO
CREATE TRIGGER trg_update_rating_mediu
ON Feedback_voluntari
AFTER INSERT
AS
BEGIN
    DECLARE @IdVoluntar INT;
    DECLARE @RatingMediu DECIMAL(3, 2);

    SELECT @IdVoluntar = id_voluntar FROM inserted;

    SELECT @RatingMediu = AVG(CAST(rating AS DECIMAL(3, 2))) FROM Feedback_voluntari WHERE id_voluntar = @IdVoluntar;

    PRINT 'Rating-ul mediu pentru voluntarul cu ID-ul ' + CAST(@IdVoluntar AS NVARCHAR(10)) + ' este: ' + CAST(@RatingMediu AS NVARCHAR(5));
END;

INSERT INTO Feedback_voluntari (id_feedback, id_voluntar, id_activitate, rating, comentariu)
VALUES (21, 21, 1, 4, 'Feedback care declansează trigger-ul pentru calculul rating-ului mediu.');


--10
DROP TRIGGER trg_print_total_participari
GO
CREATE TRIGGER trg_print_total_participari
ON Participari_evenimente
AFTER INSERT
AS
BEGIN
    PRINT 'Numarul total de participari pentru fiecare voluntar:';
    SELECT id_voluntar, COUNT(*) AS numar_participari
    FROM Participari_evenimente
    GROUP BY id_voluntar;
END;

INSERT INTO Participari_evenimente (id_participare_eveniment, id_voluntar, id_eveniment, data_participare)
VALUES 
    (22, 1, 1, '2024-09-20');

--proceduri
--1
GO
CREATE PROCEDURE GetActivitiesForVolunteer
    @VolunteerID INT
AS
BEGIN
    SELECT a.*
    FROM Activitati_voluntariat a
    INNER JOIN Participari_voluntari p ON a.id_activitate = p.id_activitate
    WHERE p.id_voluntar = @VolunteerID;
END;

EXEC GetActivitiesForVolunteer @VolunteerID = 7;

--2
GO
CREATE PROCEDURE GetTotalWorkHoursForVolunteer
    @VolunteerID INT
AS
BEGIN
    SELECT SUM(ore_lucrate) AS TotalWorkHours
    FROM Participari_voluntari
    WHERE id_voluntar = @VolunteerID;
END;
EXEC GetTotalWorkHoursForVolunteer @VolunteerID = 2;

--3
GO
CREATE PROCEDURE GetFeedbackForActivity
    @ActivityID INT
AS
BEGIN
    SELECT feedback
    FROM Participari_voluntari
    WHERE id_activitate = @ActivityID;
END;

EXEC GetFeedbackForActivity @ActivityID = 6;




BEGIN TRANSACTION;
BEGIN TRY

    INSERT INTO Feedback_voluntari (id_feedback, id_voluntar, id_activitate, rating, comentariu)
    VALUES (40, 21, 7, 5, 'Activitatea a fost foarte inspiratoare și mi-a adus multă bucurie.');
    COMMIT;
END TRY
BEGIN CATCH

    ROLLBACK;
    PRINT ERROR_MESSAGE();
END CATCH;

SELECT * FROM Feedback_voluntari


DECLARE @TotalBuget DECIMAL(18, 2);
BEGIN TRANSACTION;

BEGIN TRY
    INSERT INTO Proiecte (id_proiect, nume_proiect, descriere, data_inceperii, data_finalizarii, buget, id_organizatie)
    VALUES (11, 'Proiect de renovare a parcului', 'Renovarea parcului central al orașului.', '2024-09-15', '2025-05-15', 20000.00, 3);

    COMMIT;

    PRINT 'Bugetul total al organizației după actualizare: ' + CAST(@TotalBuget AS VARCHAR(20));
END TRY
BEGIN CATCH
  
    ROLLBACK;
    PRINT ERROR_MESSAGE();
END CATCH;

SELECT * FROM Proiecte WHERE id_proiect = 11



BEGIN TRANSACTION;
BEGIN TRY
   
    INSERT INTO Organizatii (id_organizatie, nume_organizatie, adresa, email, telefon, tip_organizatie)
    VALUES 
        (24, 'Fundatia pentru Protejarea Patrimoniului Cultural', 'Str. Protejarii Patrimoniului Cultural nr. 95', 'contact@protejarepatrimoniu.org', '0890123456', 'Tip 24'),
        (25, 'Asociatia pentru Dezvoltare Rurala', 'Str. Dezvoltarii Rurale nr. 100', 'contact@dezvoltarerurala.ro', '0901234567', 'Tip 25');

    COMMIT;
    PRINT 'Inserarea datelor în tabelul Organizatii a fost realizată cu succes!';
END TRY
BEGIN CATCH
    ROLLBACK;
    PRINT 'A apărut o eroare în timpul inserării datelor în tabelul Organizatii: ' + ERROR_MESSAGE();
END CATCH;


BEGIN TRANSACTION;
BEGIN TRY

    UPDATE Voluntari
    SET adresa = 'Str. Noua nr. 20', telefon = '0722222222'
    WHERE id_voluntar = 3;

    COMMIT;
END TRY
BEGIN CATCH
    ROLLBACK;
    PRINT ERROR_MESSAGE();
END CATCH;


select * from Voluntari



--update uri

--1

UPDATE e
SET e.descriere = 'Actualizat: Concert caritabil pentru copiii bolnavi si nevoiasi.'
FROM Evenimente e
INNER JOIN Participari_evenimente pe ON e.id_eveniment = pe.id_eveniment
INNER JOIN Feedback_voluntari fv ON pe.id_voluntar = fv.id_voluntar
WHERE e.id_eveniment = 1;

select * from Evenimente


--2

UPDATE fv
SET fv.rating = 1
FROM Feedback_voluntari fv
INNER JOIN Participari_evenimente pe ON fv.id_voluntar = pe.id_voluntar
INNER JOIN Evenimente e ON pe.id_eveniment = e.id_eveniment
WHERE e.id_eveniment = 2
AND fv.id_voluntar = 2;

select * from Feedback_voluntari

--3
UPDATE pe
SET pe.data_participare = '2024-05-06'
FROM Participari_evenimente pe
INNER JOIN Evenimente e ON pe.id_eveniment = e.id_eveniment
INNER JOIN Feedback_voluntari fv ON pe.id_voluntar = fv.id_voluntar
WHERE e.id_eveniment = 2
AND pe.id_voluntar = 2;

select * from Participari_evenimente

--4
UPDATE av
SET av.descriere = 'Activitate de promovare a reciclarii in scolile din cartierul X.'
FROM Activitati_voluntariat AS av
JOIN Organizatii AS o ON av.id_organizatie = o.id_organizatie
WHERE o.nume_organizatie = 'Asociatia ABC' AND av.nume_activitate = 'Activitate de promovare a reciclarii';

select * from Activitati_voluntariat

--5
UPDATE p
SET p.data_finalizarii = '2024-12-20'
FROM Proiecte AS p
JOIN Organizatii AS o ON p.id_organizatie = o.id_organizatie
WHERE o.nume_organizatie = 'ONG GHI' AND p.nume_proiect = 'Proiect cultural';

select * from Proiecte

--6
UPDATE p
SET p.buget = p.buget * 1.1
FROM Proiecte AS p
JOIN Organizatii AS o ON p.id_organizatie = o.id_organizatie
WHERE o.tip_organizatie = 'Tip 1';

select * from Proiecte

--7
UPDATE Organizatii
SET adresa = 'Str. Libertatii nr. 15'
WHERE id_organizatie = 1;

select * from Organizatii

--8
UPDATE Activitati_voluntariat
SET descriere = 'Curatenie in parcul din cartierul Y.'
WHERE id_activitate = 1;

select * from Activitati_voluntariat

--9
UPDATE Proiecte
SET buget = 60000.00
WHERE id_proiect = 1;

select * from Proiecte

--10
UPDATE Proiecte
SET data_finalizarii = '2024-12-15'
WHERE id_proiect = 2;

select * from Proiecte

--11
UPDATE Organizatii
SET telefon = '0219876543'
WHERE id_organizatie = 2;

select * from Organizatii 

--12
UPDATE Voluntari_Competente
SET nivel = 5
WHERE id_voluntar = 3 AND id_competenta = 3;

select * from Voluntari_Competente

--13
UPDATE Evenimente
SET descriere = CONCAT('Conferinta despre protectia mediului la Universitatea Centrala, sustinuta de organizatia ', o.nume_organizatie)
FROM Evenimente AS e
JOIN Organizatii AS o ON e.id_organizatie = o.id_organizatie
WHERE e.nume_eveniment = 'Conferinta despre protectia mediului';

select * from Evenimente

--14
UPDATE Participari_evenimente
SET data_participare = '2024-05-10'
WHERE id_voluntar = 5 AND id_eveniment = 5;

select * from Participari_evenimente

--15
UPDATE Organizatii
SET telefon = '0312345678'
WHERE id_organizatie = 2;

UPDATE Voluntari_Competente
SET nivel = 4
WHERE id_voluntar = 6 AND id_competenta = 6;


--delete-uri

--1
DELETE pv
FROM Participari_voluntari pv
JOIN Activitati_voluntariat av ON pv.id_activitate = av.id_activitate
WHERE av.data_inceperii < '2024-05-01';

--2
DELETE vc
FROM Voluntari_Competente vc
WHERE vc.nivel <= 3;

--3
DELETE fv
FROM Feedback_voluntari fv
JOIN Participari_voluntari pv ON fv.id_voluntar = pv.id_voluntar
JOIN Activitati_voluntariat av ON pv.id_activitate = av.id_activitate
JOIN Proiecte p ON av.id_organizatie = p.id_organizatie
WHERE p.buget <= 30000.00;

--4
DELETE pv
FROM Participari_voluntari pv
JOIN Activitati_voluntariat av ON pv.id_activitate = av.id_activitate
WHERE av.data_inceperii >= '2024-04-01' AND av.data_finalizarii <= '2024-04-30';

--5
DELETE fv
FROM Feedback_voluntari fv
JOIN Participari_voluntari pv ON fv.id_voluntar = pv.id_voluntar
JOIN Activitati_voluntariat av ON pv.id_activitate = av.id_activitate
WHERE av.nume_activitate = 'Activitate de promovare a reciclarii';

--6
DELETE pv
FROM Participari_voluntari pv
JOIN Activitati_voluntariat av ON pv.id_activitate = av.id_activitate
WHERE av.data_inceperii < '2024-05-01'
AND av.id_organizatie = 3;

--7
DELETE FROM Voluntari WHERE id_voluntar = 18;

--8
DELETE FROM Organizatii WHERE id_organizatie = 9;

--9
DELETE FROM Activitati_voluntariat WHERE id_activitate = 9;

--10
DELETE Proiecte 
FROM Proiecte 
JOIN Organizatii ON Proiecte.id_organizatie = Organizatii.id_organizatie
JOIN Participari_voluntari ON Proiecte.id_proiect = Participari_voluntari.id_activitate
WHERE Organizatii.tip_organizatie = 'Tip 8' AND Participari_voluntari.ore_lucrate < 5;

--11
DELETE Participari_voluntari 
FROM Participari_voluntari 
JOIN Voluntari ON Participari_voluntari.id_voluntar = Voluntari.id_voluntar
JOIN Activitati_voluntariat ON Participari_voluntari.id_activitate = Activitati_voluntariat.id_activitate
WHERE Voluntari.nume_voluntar = 'Ion Ionescu' AND Activitati_voluntariat.nume_activitate = 'Curatenie parcul local';

--12
DELETE FROM Competente WHERE id_competenta = 9;

--13
DELETE FROM Voluntari_Competente WHERE id_voluntar = 19;

--14
DELETE Evenimente 
FROM Evenimente 
JOIN Organizatii ON Evenimente.id_organizatie = Organizatii.id_organizatie
JOIN Evenimente_Voluntari ON Evenimente.id_eveniment = Evenimente_Voluntari.id_eveniment
WHERE Organizatii.nume_organizatie = 'Asociatia pentru Drepturile Omului' AND Evenimente_Voluntari.id_voluntar = 17;

--15
DELETE Participari_evenimente 
FROM Participari_evenimente 
JOIN Voluntari ON Participari_evenimente.id_voluntar = Voluntari.id_voluntar
JOIN Evenimente ON Participari_evenimente.id_eveniment = Evenimente.id_eveniment
WHERE Voluntari.nume_voluntar = 'Andrei Popescu' AND Evenimente.nume_eveniment = 'Cros pentru mediu';

-- 1 
-- Creeaza un procedeu stocat numit ActualizareTabele care sa actualizeze numele unui voluntar si al unei organizatii
-- pe baza unor ID-uri date. Procedura trebuie sa primeasca doi parametri de intrare pentru identificarea 
-- inregistrarilor si sa returneze numarul de linii afectate pentru fiecare tabela.

CREATE PROCEDURE ActualizareTabele
    @parametru1 INT,
    @parametru2 INT,
    @numarLinii1 INT OUTPUT,
    @numarLinii2 INT OUTPUT
AS
BEGIN
    UPDATE Voluntari
    SET nume_voluntar = 'Daria Andone'
    WHERE id_voluntar = @parametru1;

    SELECT @numarLinii1 = @@ROWCOUNT;

    UPDATE Organizatii
    SET nume_organizatie = 'Organizatia: Voluntariat pentru toti'
    WHERE id_organizatie = @parametru2;

    SELECT @numarLinii2 = @@ROWCOUNT;
END;


DECLARE @liniiAfectate1 INT;
DECLARE @liniiAfectate2 INT;

EXEC ActualizareTabele @parametru1 = 3, @parametru2 = 2, @numarLinii1 = @liniiAfectate1 OUTPUT, @numarLinii2 = @liniiAfectate2 OUTPUT;

PRINT 'Numarul de linii afectate in prima tabela: ' + CAST(@liniiAfectate1 AS VARCHAR);
PRINT 'Numarul de linii afectate in a doua tabela: ' + CAST(@liniiAfectate2 AS VARCHAR);

SELECT * FROM Voluntari
SELECT * FROM Organizatii


-- 2
-- Creeaza o tabela numita Log_Activitati pentru inregistrarea modificarilor (inserari, actualizari si stergeri). 
-- Creeaza un trigger numit Trigger_Log_Activitati care sa adauge inregistrari atunci cand au loc modificari.

CREATE TABLE Log_Activitati (
    id_log INT PRIMARY KEY IDENTITY,
    tip_modificare NVARCHAR(50),
    id_activitate INT,
    nume_activitate NVARCHAR(100),
    data_modificare DATETIME
);

GO
CREATE TRIGGER Trigger_Log_Activitati
ON Activitati_voluntariat
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    IF EXISTS(SELECT * FROM inserted)
    BEGIN
        INSERT INTO Log_Activitati (tip_modificare, id_activitate, nume_activitate, data_modificare)
        SELECT 'INSERT', id_activitate, nume_activitate, GETDATE()
        FROM inserted;
    END;

    IF EXISTS(SELECT * FROM deleted)
    BEGIN
        INSERT INTO Log_Activitati (tip_modificare, id_activitate, nume_activitate, data_modificare)
        SELECT 'DELETE', id_activitate, nume_activitate, GETDATE()
        FROM deleted;
    END;
END;


INSERT INTO Activitati_voluntariat (id_activitate, nume_activitate, data_inceperii, data_finalizarii, descriere, id_organizatie)
VALUES 
    (11, 'Curatenie drumuri publice', '2024-04-01', '2024-04-01', 'Curatenie pe Soseaua Viilor.', 1),
    (12, 'Activitate de promovare a donatiilor', '2024-04-05', '2024-04-05', 'Promovarea donatiilor in scolile din oras.', 2);

SELECT * FROM Activitati_voluntariat
SELECT * FROM Log_Activitati


--3
-- Creeaza o procedura stocata numita Inserare_Organizatie care sa insereze o noua organizatie.
-- Procedura trebuie sa primeasca sase parametri de intrare si sa gestioneze eventualele erori de inserare, inclusiv 
-- duplicarea cheii primare. Procedura trebuie sa insereze datele într-o tranzactie si sa afiseze mesaje 
-- corespunzatoare pentru succesul sau esecul operatiunii.

GO
CREATE PROCEDURE Inserare_Organizatie
    @id_organizatie INT,
    @nume_organizatie NVARCHAR(100),
    @adresa NVARCHAR(100),
    @email NVARCHAR(100),
    @telefon NVARCHAR(20),
    @tip_organizatie NVARCHAR(50)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO Organizatii (id_organizatie, nume_organizatie, adresa, email, telefon, tip_organizatie)
        VALUES (@id_organizatie, @nume_organizatie, @adresa, @email, @telefon, @tip_organizatie);

        COMMIT TRANSACTION;

        PRINT 'Inserare realizata cu succes.';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        IF ERROR_NUMBER() = 2627
            PRINT 'Eroare: Cheie primara duplicata. Id-ul organizatiei este deja utilizat.';
        ELSE
            PRINT 'Eroare: ' + ERROR_MESSAGE();
    END CATCH
END;


EXEC Inserare_Organizatie @id_organizatie = 18, @nume_organizatie = 'Org test1', @adresa = 'Str. test1 nr. 10', @email = 'test1@nou.com', @telefon = '0000000000', @tip_organizatie = 'test1';
EXEC Inserare_Organizatie @id_organizatie = 19, @nume_organizatie = 'Org test2', @adresa = 'Str. test2 nr. 5', @email = 'test2@nou.com', @telefon = '1111111111', @tip_organizatie = 'test2';

SELECT * FROM Organizatii

-- 4
-- Creeaza o procedura stocata numita Tranzactie_Complexa care efectueaza intr-o tranzactie urmatoarele operatii: 
-- inserarea unei noi organizatii, inserarea a doua activitati de voluntariat asociate cu noua 
-- organizatie, inserarea unui nou proiect asociat cu noua organizatie, actualizarea descrierii unui proiect bazat pe 
-- numele organizatiei, si stergerea anumitor activităati de voluntariat asociate cu organizatii cu un anumit tip, 
-- asigurand gestionarea erorilor.

GO
CREATE PROCEDURE Tranzactie_Complexa
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
		
        INSERT INTO Organizatii (id_organizatie, nume_organizatie, adresa, email, telefon, tip_organizatie)
        VALUES 
            (21, 'Organizatia test1', 'Str. organizatiei nr. 10', 'contact@org.com', '0745555899', 'Tip 16');

        INSERT INTO Activitati_voluntariat (id_activitate, nume_activitate, data_inceperii, data_finalizarii, descriere, id_organizatie)
        VALUES 
            (20, 'Activitate 1', '2024-07-01', '2024-07-01', 'Pentru tineri.', 21),
            (21, 'Activitate 2', '2024-07-05', '2024-07-05', 'Pentru copii.', 21);

        INSERT INTO Proiecte (id_proiect, nume_proiect, descriere, data_inceperii, data_finalizarii, buget, id_organizatie)
        VALUES 
            (13, 'Proiect familii1', 'Pentru toata familia', '2024-07-01', '2024-12-31', 250000.00, 21);

        UPDATE p
        SET p.descriere = 'Descriere test1'
        FROM Proiecte AS p
        INNER JOIN Organizatii AS o ON p.id_organizatie = o.id_organizatie
        WHERE o.nume_organizatie = 'Organizatia Noua';

        DELETE FROM Activitati_voluntariat
        WHERE id_activitate IN (
            SELECT av.id_activitate
            FROM Activitati_voluntariat AS av
            INNER JOIN Organizatii AS o ON av.id_organizatie = o.id_organizatie
            WHERE o.tip_organizatie = 'Tip 21'
        );

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        PRINT 'A intervenit o eroare: ' + ERROR_MESSAGE();
    END CATCH;
END;

EXEC Tranzactie_Complexa

SELECT * FROM Organizatii
SELECT * FROM Activitati_voluntariat
SELECT * FROM Proiecte