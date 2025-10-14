create table public.races (
  id uuid not null default gen_random_uuid (),
  name character varying(50) not null,
  ability_score_increases jsonb null,
  size text not null,
  speed integer not null,
  traits jsonb null,
  languages character varying(100) null,
  created_at timestamp with time zone null default now(),
  updated_at timestamp with time zone null default now(),
  source character varying null,
  ability_score_increase character varying null,
  subraces jsonb null,
  description text null,
  traits_text text null,
  racial_spells text null,
  constraint races_pkey primary key (id),
  constraint races_name_key unique (name)
) TABLESPACE pg_default;

create trigger update_races_updated_at BEFORE
update on races for EACH row
execute FUNCTION update_updated_at_column ();