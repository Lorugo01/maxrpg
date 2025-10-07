create table public.backgrounds (
  id uuid not null default gen_random_uuid (),
  name character varying(50) not null,
  skill_proficiencies_2014 character varying(100) null,
  tool_proficiencies character varying(100) null,
  languages character varying(100) null,
  equipment_2014 character varying(500) null,
  features_2014 jsonb null,
  created_at timestamp with time zone null default now(),
  updated_at timestamp with time zone null default now(),
  source character varying null,
  personality_traits text null,
  ideals text null,
  bonds text null,
  flaws text null,
  feature text null,
  ability_scores text null,
  feat text null,
  skill_proficiencies_2024 text null,
  tool_proficiency text null,
  equipment_choice_a text null,
  equipment_choice_b text null,
  description text null,
  feat_id uuid null,
  constraint backgrounds_pkey primary key (id),
  constraint backgrounds_name_key unique (name),
  constraint fk_backgrounds_feat_id foreign KEY (feat_id) references feats (id) on delete set null
) TABLESPACE pg_default;

create trigger update_backgrounds_updated_at BEFORE
update on backgrounds for EACH row
execute FUNCTION update_updated_at_column ();