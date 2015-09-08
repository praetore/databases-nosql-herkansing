CREATE TABLE public.game_object(
	id serial NOT NULL,
	name text,
	location_x integer,
	location_y integer,
	texture text,
	CONSTRAINT game_object_id PRIMARY KEY (id)

);
ALTER TABLE public.game_object OWNER TO postgres;

CREATE TABLE public.player(
	health integer,
	score integer,
	id_world integer,
	deaths integer,
	CONSTRAINT player_pk PRIMARY KEY (id)

) INHERITS(public.game_object)
;
ALTER TABLE public.player OWNER TO postgres;

CREATE TABLE public.coin(
	value integer,
	id_world integer,
	CONSTRAINT coin_pk PRIMARY KEY (id)

) INHERITS(public.game_object)
;
ALTER TABLE public.coin OWNER TO postgres;

CREATE TABLE public.enemy(
	speed integer,
	damage integer,
	id_world integer,
	size integer,
	CONSTRAINT enemy_pk PRIMARY KEY (id)

) INHERITS(public.game_object)
;
ALTER TABLE public.enemy OWNER TO postgres;

CREATE TABLE public.world(
	id serial NOT NULL,
	name text,
	on_create timestamp,
	CONSTRAINT world_pk PRIMARY KEY (id)

);
ALTER TABLE public.world OWNER TO postgres;

ALTER TABLE public.player ADD CONSTRAINT world_fk FOREIGN KEY (id_world)
REFERENCES public.world (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE public.enemy ADD CONSTRAINT world_fk FOREIGN KEY (id_world)
REFERENCES public.world (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE public.coin ADD CONSTRAINT world_fk FOREIGN KEY (id_world)
REFERENCES public.world (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

CREATE TABLE public.block_type(
	id serial NOT NULL,
	speed_reduction integer,
	is_solid boolean,
	damage integer,
	id_block integer,
	CONSTRAINT block_type_id PRIMARY KEY (id)

);
ALTER TABLE public.block_type OWNER TO postgres;

CREATE TABLE public.block(
	id_world integer,
	CONSTRAINT block_pk PRIMARY KEY (id)

) INHERITS(public.game_object)
;
ALTER TABLE public.block OWNER TO postgres;

ALTER TABLE public.block ADD CONSTRAINT world_fk FOREIGN KEY (id_world)
REFERENCES public.world (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE public.block_type ADD CONSTRAINT block_fk FOREIGN KEY (id_block)
REFERENCES public.block (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE public.block_type ADD CONSTRAINT block_type_uq UNIQUE (id_block);
