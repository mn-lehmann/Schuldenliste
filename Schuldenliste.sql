-- Cafe Mitglieder Tabelle


CREATE TABLE User(
    ID INTEGER NOT NULL,
    Nachname TEXT NOT NULL,
    Vorname TEXT NOT NULL,
    Alias TEXT DEFAULT(NULL),
    -- 0 darf Striche machen, 1 in Übergang falls unter Summe weiß, 2 rot hinterlegt
    Rot INTEGER NOT NULL DEFAULT (0),
    PRIMARY KEY (ID)
);


UPDATE User SET Vorname = neuVorname, Nachname = neuNachname WHERE ID = MItgliedkEy


-- Schuldenliste, positiver Betrag = Striche, negativ = Einzahlung
CREATE TABLE Schuldenliste(
    ID INTEGER NOT NULL,
    Mitglied INTEGER NOT NULL,
    Betrag REAL NOT NULL,
    Datum TEXT DEFAULT CURRENT_DATE,
    Zeitpunkt TEXT DEFAULT CURRENT_TIME,
    Verantwortlich INTEGER NOT NULL,
    PRIMARY KEY (ID)
    FOREIGN KEY (Mitglied) REFERENCES User(ID)
    FOREIGN KEY (Verantwortlich) REFERENCES User(ID)
);


-- Eingereichte Rechnngen - Umbenennen - auch für Geld in Schlitz
CREATE TABLE Bons(
    ID INTEGER NOT NULL,
    Mitglied INTEGER NOT NULL,
    Betrag REAL NOT NULL,
    -- optionaler Grund
    Zweck TEXT,
    Datum TEXT DEFAULT CURRENT_DATE,
    Zeitpunkt TEXT DEFAULT CURRENT_TIME,
    Verantwortlich INTEGER NOT NULL,
    PRIMARY KEY (ID)
    FOREIGN KEY (Mitglied) REFERENCES User(ID)
    FOREIGN KEY (Verantwortlich) REFERENCES User(ID)
);



-- Kassenstand bei Öffnung, Übergabe und Schließung
CREATE TABLE Kassenstand(
    ID INTEGER NOT NULL,
    Art TEXT CHECK(Art IN ('Öffnung', 'Schließung', 'Zwischen')) NOT NULL,
    Datum TEXT DEFAULT CURRENT_DATE,
    Zeitpunkt TEXT DEFAULT CURRENT_TIME,
    -- Wer hat gezählt / übergeben
    Verantwortlich INTEGER NOT NULL,
    Barbestand REAL NOT NULL,
    KEWeiß INTEGER NOT NULL,
    KEBlau INTEGER NOT NULL,
    PRIMARY KEY (ID)
    FOREIGN KEY (Verantwortlich) REFERENCES User(ID)
);


-- Verantwortung wird übergeben
CREATE TABLE Uebergabe(
    ID INTEGER NOT NULL,
    BisherVerantwortlich INTEGER NOT NULL,
    Verantwortlich INTEGER NOT NULL,
    Datum TEXT DEFAULT CURRENT_DATE,
    Zeitpunkt TEXT DEFAULT CURRENT_TIME,
    PRIMARY KEY (ID)
    FOREIGN KEY (BisherVerantwortlich) REFERENCES User(ID)
    FOREIGN KEY (Verantwortlich) REFERENCES User(ID)
);


INSERT INTO Schuldenliste (Mitglied, Betrag, Verantwortlich) VALUES (2, 4.0, 1);


SELECT Mitglied, Sum(Betrag) Schulden FROM Schuldenliste GROUP BY Mitglied;




UPDATE User SET Rot = 2 WHERE ID IN (SELECT Mitglied FROM (SELECT Mitglied, Sum(Betrag) Schulden FROM Schuldenliste GROUP BY Mitglied) WHERE Schulden >= 5 INTERSECT SELECT ID FROM User WHERE Rot = 1);





SELECT ID FROM User WHERE Rot = 1;

UPDATE User SET Rot = 0 WHERE ID = 2; 

SELECT * FROM User;