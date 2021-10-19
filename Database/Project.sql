CREATE TABLE IF NOT EXISTS user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT UNIQUE NOT NULL,
  user_password TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS post (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  author_id INTEGER NOT NULL,
  created_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  FOREIGN KEY (author_id) REFERENCES user (id)
);

CREATE TABLE IF NOT EXISTS Publisher (
   Publisher_Name VARCHAR(45) NULL,
   Organization VARCHAR(45) NOT NULL,
   Github VARCHAR(45) NULL,
   License VARCHAR(45) NULL,
   Website VARCHAR(45) NOT NULL,
   PublicationDate VARCHAR(45) NOT NULL,
  PRIMARY KEY (Website));

CREATE TABLE IF NOT EXISTS Programming_Language (
  Current_Version VARCHAR(45) NOT NULL,
  Language_Name VARCHAR(45) NOT NULL,
  PRIMARY KEY (Current_Version, Language_Name));


CREATE TABLE IF NOT EXISTS Requirements (
   Other_Libraries VARCHAR(45) NULL,
   Servers VARCHAR(45) NULL,
   Language_Current_Version VARCHAR(45) NOT NULL,
   Language_Name VARCHAR(45) NOT NULL,
  --INDEX fk_Requirements_Language1_idx (Language_Current_Version ASC, Language_Name ASC),
  PRIMARY KEY (Language_Current_Version, Language_Name),
  CONSTRAINT fk_Requirements_Language1
    FOREIGN KEY (Language_Current_Version , Language_Name)
    REFERENCES Programming_Language (Current_Version , Language_Name)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS Category (
  Category VARCHAR(45) NOT NULL,
  PRIMARY KEY (Category));


CREATE TABLE IF NOT EXISTS SoftwarePackage (
  idSoftwarePackage INTEGER PRIMARY KEY AUTOINCREMENT,
  Package_Name VARCHAR(45) NOT NULL,
  Package_Description VARCHAR(45) NULL,
  Package_Version VARCHAR(45) NOT NULL,
  OpenSource VARCHAR(10) NOT NULL,
  Publisher_Website VARCHAR(45) NOT NULL,
  Requirements_Language_Current_Version VARCHAR(45) NOT NULL,
  Requirements_Language_Name VARCHAR(45) NOT NULL,
  Category_Category VARCHAR(45) NOT NULL,
  CONSTRAINT fk_SoftwarePackage_Publisher1
    FOREIGN KEY (Publisher_Website)
    REFERENCES Publisher (Website)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_SoftwarePackage_Requirements1
    FOREIGN KEY (Requirements_Language_Current_Version , Requirements_Language_Name)
    REFERENCES Requirements (Language_Current_Version , Language_Name)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_SoftwarePackage_Category1
    FOREIGN KEY (Category_Category)
    REFERENCES Category (Category)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS Framework (
  SoftwarePackage_idSoftwarePackage INT NOT NULL,
  PRIMARY KEY (SoftwarePackage_idSoftwarePackage),
  CONSTRAINT fk_Framework_SoftwarePackage1
    FOREIGN KEY (SoftwarePackage_idSoftwarePackage)
    REFERENCES SoftwarePackage (idSoftwarePackage)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    );


CREATE TABLE IF NOT EXISTS Module (
  Fuctionality VARCHAR(45) NOT NULL,
  SoftwarePackage_idSoftwarePackage INT NOT NULL,
  PRIMARY KEY (SoftwarePackage_idSoftwarePackage),
  CONSTRAINT fk_Module_SoftwarePackage1
    FOREIGN KEY (SoftwarePackage_idSoftwarePackage)
    REFERENCES SoftwarePackage (idSoftwarePackage)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS Library (
  SoftwarePackage_idSoftwarePackage INT NOT NULL,
  Classes VARCHAR(45) NULL,
  Functions VARCHAR(45) NULL,
  PRIMARY KEY (SoftwarePackage_idSoftwarePackage),
  CONSTRAINT fk_Library_SoftwarePackage1
    FOREIGN KEY (SoftwarePackage_idSoftwarePackage)
    REFERENCES SoftwarePackage (idSoftwarePackage)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
