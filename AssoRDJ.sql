-- This script was generated by the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE IF NOT EXISTS public.utilisateurs
(
    id_utilisateur serial NOT NULL,
    nom character varying(30) NOT NULL,
    prenom character varying(30) NOT NULL,
    numero_adherant integer NOT NULL,
    pseudo character varying(30),
    mot_passe character varying(30) NOT NULL,
    mail character varying(50) NOT NULL,
    telephone character varying(15) NOT NULL,
    coordonnees integer,
    PRIMARY KEY (id_utilisateur)
);

CREATE TABLE IF NOT EXISTS public.permissions
(
    id_permission serial NOT NULL,
    statut character varying(30) NOT NULL,
    utilisateur integer,
    PRIMARY KEY (id_permission)
);

CREATE TABLE IF NOT EXISTS public.articles
(
    id_article serial NOT NULL,
    titre character varying(30) NOT NULL,
    corps character varying(65535) NOT NULL,
    date_ecriture date NOT NULL,
    date_modif date,
    like_dislike character varying(10),
    utilisateur integer,
    PRIMARY KEY (id_article)
);

CREATE TABLE IF NOT EXISTS public.commentaires
(
    id_commentaire serial NOT NULL,
    commentaire character varying(300) NOT NULL,
    like_dislike character varying(10),
    utilisateur integer,
    article integer,
    PRIMARY KEY (id_commentaire)
);

CREATE TABLE IF NOT EXISTS public.categories
(
    id_categorie serial NOT NULL,
    nom character varying(30) NOT NULL,
    description character varying(300),
    PRIMARY KEY (id_categorie)
);

CREATE TABLE IF NOT EXISTS public.demande_contact
(
    id_demandecontact serial NOT NULL,
    utilisateur integer,
    mail character varying(30) NOT NULL,
    message character varying(200),
    type_demande integer,
    PRIMARY KEY (id_demandecontact)
);

CREATE TABLE IF NOT EXISTS public.evenements
(
    id_evenement serial NOT NULL,
    nom character varying(50) NOT NULL,
    date_creation date NOT NULL,
    "date_début" date NOT NULL,
    date_fin date NOT NULL,
    description character varying(200),
    organisateur integer,
    PRIMARY KEY (id_evenement)
);

CREATE TABLE IF NOT EXISTS public.reservations
(
    id_reservation serial NOT NULL,
    demandeur character varying(30) NOT NULL,
    participant character varying(30) NOT NULL,
    validation boolean,
    date_reservation date NOT NULL,
    date_evenement date NOT NULL,
    heure_debut timestamp(6) without time zone NOT NULL,
    duree integer,
    description character varying(200),
    PRIMARY KEY (id_reservation)
);

CREATE TABLE IF NOT EXISTS public.salles
(
    id_salle serial NOT NULL,
    nom character varying NOT NULL,
    capacite integer NOT NULL,
    lieu character varying(30) NOT NULL,
    acces_pmr boolean NOT NULL,
    PRIMARY KEY (id_salle)
);

CREATE TABLE IF NOT EXISTS public.rdjsign
(
    id_rdjsign serial NOT NULL,
    reservation integer NOT NULL,
    PRIMARY KEY (id_rdjsign)
);

CREATE TABLE IF NOT EXISTS public.utilisateurs_evenements
(
    utilisateurs_id_utilisateur serial NOT NULL,
    evenements_id_evenement serial NOT NULL
);

CREATE TABLE IF NOT EXISTS public.utilisateurs_reservations
(
    utilisateurs_id_utilisateur serial NOT NULL,
    reservations_id_reservation serial NOT NULL
);

CREATE TABLE IF NOT EXISTS public.coordonnees
(
    id_coordonnees serial NOT NULL,
    numero_rue character varying(10),
    rue character varying(50) NOT NULL,
    complement_adresse character varying(50),
    cp integer NOT NULL,
    ville character varying(50) NOT NULL,
    PRIMARY KEY (id_coordonnees)
);

CREATE TABLE IF NOT EXISTS public.typdemande
(
    id_typedemande serial NOT NULL,
    nom_type character varying NOT NULL,
    PRIMARY KEY (id_typedemande)
);

CREATE TABLE IF NOT EXISTS public.articles_categories
(
    articles_id_article serial NOT NULL,
    categories_id_categorie serial NOT NULL
);

CREATE TABLE IF NOT EXISTS public.reservations_salles
(
    reservations_id_reservation serial NOT NULL,
    salles_id_salle serial NOT NULL
);

CREATE TABLE IF NOT EXISTS public.reservations_categories
(
    reservations_id_reservation serial NOT NULL,
    categories_id_categorie serial NOT NULL
);

CREATE TABLE IF NOT EXISTS public.categories_evenements
(
    categories_id_categorie serial NOT NULL,
    evenements_id_evenement serial NOT NULL
);

ALTER TABLE IF EXISTS public.utilisateurs
    ADD CONSTRAINT fk_coordonnees FOREIGN KEY (coordonnees)
    REFERENCES public.coordonnees (id_coordonnees) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.permissions
    ADD CONSTRAINT fk_utilisateur FOREIGN KEY (utilisateur)
    REFERENCES public.utilisateurs (id_utilisateur) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.articles
    ADD CONSTRAINT fk_utilisateur FOREIGN KEY (utilisateur)
    REFERENCES public.utilisateurs (id_utilisateur) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.commentaires
    ADD CONSTRAINT fk_utilisateur FOREIGN KEY (utilisateur)
    REFERENCES public.utilisateurs (id_utilisateur) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.commentaires
    ADD CONSTRAINT fk_article FOREIGN KEY (article)
    REFERENCES public.articles (id_article) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.demande_contact
    ADD CONSTRAINT fk_utilisateur FOREIGN KEY (utilisateur)
    REFERENCES public.utilisateurs (id_utilisateur) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.demande_contact
    ADD CONSTRAINT fk_typedemande FOREIGN KEY (type_demande)
    REFERENCES public.typdemande (id_typedemande) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.evenements
    ADD CONSTRAINT fk_organisateur FOREIGN KEY (organisateur)
    REFERENCES public.utilisateurs (id_utilisateur) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.rdjsign
    ADD CONSTRAINT fk_reservation FOREIGN KEY (reservation)
    REFERENCES public.reservations (id_reservation) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.utilisateurs_evenements
    ADD FOREIGN KEY (utilisateurs_id_utilisateur)
    REFERENCES public.utilisateurs (id_utilisateur) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.utilisateurs_evenements
    ADD FOREIGN KEY (evenements_id_evenement)
    REFERENCES public.evenements (id_evenement) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.utilisateurs_reservations
    ADD FOREIGN KEY (utilisateurs_id_utilisateur)
    REFERENCES public.utilisateurs (id_utilisateur) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.utilisateurs_reservations
    ADD FOREIGN KEY (reservations_id_reservation)
    REFERENCES public.reservations (id_reservation) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.articles_categories
    ADD FOREIGN KEY (articles_id_article)
    REFERENCES public.articles (id_article) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.articles_categories
    ADD FOREIGN KEY (categories_id_categorie)
    REFERENCES public.categories (id_categorie) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.reservations_salles
    ADD FOREIGN KEY (reservations_id_reservation)
    REFERENCES public.reservations (id_reservation) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.reservations_salles
    ADD FOREIGN KEY (salles_id_salle)
    REFERENCES public.salles (id_salle) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.reservations_categories
    ADD FOREIGN KEY (reservations_id_reservation)
    REFERENCES public.reservations (id_reservation) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.reservations_categories
    ADD FOREIGN KEY (categories_id_categorie)
    REFERENCES public.categories (id_categorie) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.categories_evenements
    ADD FOREIGN KEY (categories_id_categorie)
    REFERENCES public.categories (id_categorie) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.categories_evenements
    ADD FOREIGN KEY (evenements_id_evenement)
    REFERENCES public.evenements (id_evenement) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;