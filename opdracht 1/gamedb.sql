-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.8.1
-- PostgreSQL version: 9.4
-- Project Site: pgmodeler.com.br
-- Model Author: ---


-- Database creation must be done outside an multicommand file.
-- These commands were put in this file only for convenience.
-- -- object: gamedb | type: DATABASE --
-- -- DROP DATABASE IF EXISTS gamedb;
-- CREATE DATABASE gamedb
-- ;
-- -- ddl-end --
-- 

-- object: public.game_object | type: TABLE --
-- DROP TABLE IF EXISTS public.game_object CASCADE;
CREATE TABLE public.game_object(
	id serial NOT NULL,
	name text,
	location_x integer,
	location_y integer,
	texture text,
	CONSTRAINT game_object_id PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.game_object OWNER TO postgres;
-- ddl-end --

-- object: public.player | type: TABLE --
-- DROP TABLE IF EXISTS public.player CASCADE;
CREATE TABLE public.player(
	health integer,
	score integer,
	deaths integer,
	id_world integer,
	CONSTRAINT player_pk PRIMARY KEY (id)

) INHERITS(public.game_object)
;
-- ddl-end --
ALTER TABLE public.player OWNER TO postgres;
-- ddl-end --

-- object: public.coin | type: TABLE --
-- DROP TABLE IF EXISTS public.coin CASCADE;
CREATE TABLE public.coin(
	value integer,
	id_world integer,
	CONSTRAINT coin_pk PRIMARY KEY (id)

) INHERITS(public.game_object)
;
-- ddl-end --
ALTER TABLE public.coin OWNER TO postgres;
-- ddl-end --

-- object: public.enemy | type: TABLE --
-- DROP TABLE IF EXISTS public.enemy CASCADE;
CREATE TABLE public.enemy(
	speed integer,
	damage integer,
	size integer,
	id_world integer,
	CONSTRAINT enemy_pk PRIMARY KEY (id)

) INHERITS(public.game_object)
;
-- ddl-end --
ALTER TABLE public.enemy OWNER TO postgres;
-- ddl-end --

-- object: public.world | type: TABLE --
-- DROP TABLE IF EXISTS public.world CASCADE;
CREATE TABLE public.world(
	id serial NOT NULL,
	name text,
	on_create timestamp,
	CONSTRAINT world_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.world OWNER TO postgres;
-- ddl-end --

-- object: world_fk | type: CONSTRAINT --
-- ALTER TABLE public.player DROP CONSTRAINT IF EXISTS world_fk CASCADE;
ALTER TABLE public.player ADD CONSTRAINT world_fk FOREIGN KEY (id_world)
REFERENCES public.world (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: world_fk | type: CONSTRAINT --
-- ALTER TABLE public.enemy DROP CONSTRAINT IF EXISTS world_fk CASCADE;
ALTER TABLE public.enemy ADD CONSTRAINT world_fk FOREIGN KEY (id_world)
REFERENCES public.world (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: world_fk | type: CONSTRAINT --
-- ALTER TABLE public.coin DROP CONSTRAINT IF EXISTS world_fk CASCADE;
ALTER TABLE public.coin ADD CONSTRAINT world_fk FOREIGN KEY (id_world)
REFERENCES public.world (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.damage | type: TABLE --
-- DROP TABLE IF EXISTS public.damage CASCADE;
CREATE TABLE public.damage(
	id serial,
	speed_reduction integer,
	is_solid boolean,
	damage integer,
	id_block integer
);
-- ddl-end --
ALTER TABLE public.damage OWNER TO postgres;
-- ddl-end --

-- object: public.block | type: TABLE --
-- DROP TABLE IF EXISTS public.block CASCADE;
CREATE TABLE public.block(
	id_world integer,
	CONSTRAINT block_pk PRIMARY KEY (id)

) INHERITS(public.game_object)
;
-- ddl-end --
ALTER TABLE public.block OWNER TO postgres;
-- ddl-end --

-- object: world_fk | type: CONSTRAINT --
-- ALTER TABLE public.block DROP CONSTRAINT IF EXISTS world_fk CASCADE;
ALTER TABLE public.block ADD CONSTRAINT world_fk FOREIGN KEY (id_world)
REFERENCES public.world (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: block_fk | type: CONSTRAINT --
-- ALTER TABLE public.damage DROP CONSTRAINT IF EXISTS block_fk CASCADE;
ALTER TABLE public.damage ADD CONSTRAINT block_fk FOREIGN KEY (id_block)
REFERENCES public.block (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: damage_uq | type: CONSTRAINT --
-- ALTER TABLE public.damage DROP CONSTRAINT IF EXISTS damage_uq CASCADE;
ALTER TABLE public.damage ADD CONSTRAINT damage_uq UNIQUE (id_block);
-- ddl-end --


