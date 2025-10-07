create table public.skills (
  id uuid not null default gen_random_uuid (),
  character_id uuid null,
  name character varying(50) not null,
  base_ability character varying(20) not null,
  proficiency boolean null default false,
  expertise boolean null default false,
  modifier integer null default 0,
  created_at timestamp with time zone null default now(),
  updated_at timestamp with time zone null default now(),
  constraint skills_pkey primary key (id),
  constraint skills_character_id_fkey foreign KEY (character_id) references characters (id) on delete CASCADE
) TABLESPACE pg_default;

create index IF not exists idx_skills_character_id on public.skills using btree (character_id) TABLESPACE pg_default;

create trigger update_skills_updated_at BEFORE
update on skills for EACH row
execute FUNCTION update_updated_at_column ();