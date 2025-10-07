create table public.feats (
  id uuid not null default gen_random_uuid (),
  name character varying(100) not null,
  prerequisite character varying(200) null,
  description text not null,
  benefits jsonb null,
  created_at timestamp with time zone null default now(),
  updated_at timestamp with time zone null default now(),
  benefit text null,
  source character varying(50) null,
  category character varying(50) null,
  is_repeatable boolean null default false,
  abilities jsonb null default '[]'::jsonb,
  constraint feats_pkey primary key (id),
  constraint feats_name_key unique (name)
) TABLESPACE pg_default;

create trigger update_feats_updated_at BEFORE
update on feats for EACH row
execute FUNCTION update_updated_at_column ();