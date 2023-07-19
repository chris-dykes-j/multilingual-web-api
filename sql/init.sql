DROP TABLE IF EXISTS languages, items, item_translations, name_translations, description_translations;

CREATE TABLE languages (
  language_code CHAR(2) PRIMARY KEY, 
  language_name VARCHAR(255) NOT NULL
);

INSERT INTO languages (language_code, language_name) VALUES
  ('en', 'English'),
  ('fr', 'French'),
  ('tr', 'Turkish');

GRANT SELECT ON languages TO guest;

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  cost DECIMAL(12,2) NOT NULL
);

INSERT INTO items (id, cost) VALUES
    (1, 29.99);

GRANT SELECT ON items TO guest;

CREATE TABLE name_translations (
    id SERIAL PRIMARY KEY,
    item_id INT NOT NULL,
    language_code CHAR(2) NOT NULL,
    translation TEXT NOT NULL,
    FOREIGN KEY (item_id) REFERENCES items(id),
    FOREIGN KEY (language_code) REFERENCES languages(language_code)
);

INSERT INTO name_translations (item_id, language_code, translation) VALUES
    (1, 'en', 'Logitech M510 Wireless Computer Mouse'),
    (1, 'fr', 'Logitech M510 Souris d''ordinateur'),
    (1, 'tr', 'Logitech M510 Kablosuz Bilgisayar Faresi');

CREATE TABLE description_translations (
    id SERIAL PRIMARY KEY,
    item_id INT NOT NULL,
    language_code CHAR(2) NOT NULL,
    translation TEXT NOT NULL,
    FOREIGN KEY (item_id) REFERENCES items(id),
    FOREIGN KEY (language_code) REFERENCES languages(language_code)
);

INSERT INTO description_translations (item_id, language_code, translation) VALUES
    (1, 'en', 'Your hand can relax in comfort hour after hour with this ergonomically designed mouse. Its contoured shape with soft rubber grips, gently curved sides and broad palm area give you the support you need for effortless control all day long.'),
    (1, 'fr', 'Votre main peut se détendre confortablement heure après heure avec cette souris ergonomique. Sa forme profilée avec des poignées en caoutchouc souple, des côtés légèrement incurvés et une large zone de paume vous offrent le soutien dont vous avez besoin pour un contrôle sans effort tout au long de la journée.'),
    (1, 'tr', 'Bu ergonomik tasarımlı fare ile eliniz saatler sonra bile rahat kalır. Yumuşak kauçuk kulplu konturlu şekli, hafif kıvrımlı kenarları ve geniş avuç içi alanı, gün boyu zahmetsiz kontrol için ihtiyacınız olan desteği sağlar.');

GRANT SELECT ON name_translations, description_translations TO guest;

-- Attempt to simplify query

CREATE TABLE item_translations (
    id SERIAL PRIMARY KEY,
    item_id INT NOT NULL,
    language_code CHAR(2) NOT NULL,
    field VARCHAR(255) NOT NULL,
    translation TEXT NOT NULL,
    FOREIGN KEY (item_id) REFERENCES items(id),
    FOREIGN KEY (language_code) REFERENCES languages(language_code)
);

INSERT INTO item_translations (item_id, language_code, field, translation) VALUES
    (1, 'en', 'name', 'Logitech M510 Wireless Computer Mouse'),
    (1, 'en', 'description', 'Your hand can relax in comfort hour after hour with this ergonomically designed mouse. Its contoured shape with soft rubber grips, gently curved sides and broad palm area give you the support you need for effortless control all day long.'),
    (1, 'fr', 'name', 'Logitech M510 Souris d''ordinateur'),
    (1, 'fr', 'description', 'Votre main peut se détendre confortablement heure après heure avec cette souris ergonomique. Sa forme profilée avec des poignées en caoutchouc souple, des côtés légèrement incurvés et une large zone de paume vous offrent le soutien dont vous avez besoin pour un contrôle sans effort tout au long de la journée.'),
    (1, 'tr', 'name', 'Logitech M510 Kablosuz Bilgisayar Faresi'),
    (1, 'tr', 'description', 'Bu ergonomik tasarımlı fare ile eliniz saatler sonra bile rahat kalır. Yumuşak kauçuk kulplu konturlu şekli, hafif kıvrımlı kenarları ve geniş avuç içi alanı, gün boyu zahmetsiz kontrol için ihtiyacınız olan desteği sağlar.');

GRANT SELECT ON item_translations TO guest;
