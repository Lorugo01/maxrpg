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

create table public.characters (
  id uuid not null default gen_random_uuid (),
  user_id uuid null,
  name character varying(100) not null,
  race character varying(50) not null,
  class_name character varying(50) not null,
  background character varying(50) null,
  level integer null default 1,
  experience_points integer null default 0,
  strength integer null default 10,
  dexterity integer null default 10,
  constitution integer null default 10,
  intelligence integer null default 10,
  wisdom integer null default 10,
  charisma integer null default 10,
  max_hit_points integer null default 8,
  current_hit_points integer null default 8,
  temporary_hit_points integer null default 0,
  armor_class integer null default 10,
  speed integer null default 30,
  alignment character varying(20) null,
  personality_traits text null,
  ideals text null,
  bonds text null,
  flaws text null,
  created_at timestamp with time zone null default now(),
  updated_at timestamp with time zone null default now(),
  ability_scores jsonb null,
  languages jsonb null default '[]'::jsonb,
  proficiencies jsonb null default '[]'::jsonb,
  selected_cantrips jsonb null default '[]'::jsonb,
  selected_spells jsonb null default '[]'::jsonb,
  known_spells jsonb null default '[]'::jsonb,
  constraint characters_pkey primary key (id),
  constraint characters_user_id_fkey foreign KEY (user_id) references auth.users (id) on delete CASCADE
) TABLESPACE pg_default;

create index IF not exists idx_characters_name on public.characters using btree (name) TABLESPACE pg_default;

create trigger update_characters_updated_at BEFORE
update on characters for EACH row
execute FUNCTION update_updated_at_column ();

create table public.classes (
  id uuid not null default gen_random_uuid (),
  name character varying(50) not null,
  hit_die integer not null,
  primary_ability character varying(20) not null,
  saving_throws character varying(500) not null,
  skill_proficiencies character varying(1000) not null,
  equipment character varying(500) null,
  features jsonb null,
  spellcasting jsonb null,
  created_at timestamp with time zone null default now(),
  updated_at timestamp with time zone null default now(),
  source character varying(100) null,
  armor_proficiencies character varying(500) null,
  weapon_proficiencies character varying(500) null,
  tool_proficiencies character varying(500) null,
  subclasses character varying(500) null,
  description text null,
  equipment_lado_a text null,
  equipment_lado_b text null,
  level_features jsonb null default '[]'::jsonb,
  has_spells boolean null default false,
  spell_levels jsonb null,
  spell_slots_levels jsonb null,
  subclasses_details jsonb null,
  skill_count integer null default 2,
  has_usage_limit boolean null default false,
  usage_type character varying(50) null,
  usage_value integer null,
  usage_recovery text null,
  usage_attribute character varying(20) null,
  manual_level_increases jsonb null,
  has_dice_increase boolean null default false,
  initial_dice character varying(20) null,
  dice_increases jsonb null,
  has_proficiency_doubling boolean null default false,
  proficiency_skill_count integer null default 0,
  constraint classes_pkey primary key (id),
  constraint classes_name_key unique (name)
) TABLESPACE pg_default;

create trigger update_classes_updated_at BEFORE
update on classes for EACH row
execute FUNCTION update_updated_at_column ();
create table public.equipment (
  id uuid not null default gen_random_uuid (),
  name character varying(100) not null,
  type character varying(50) not null,
  category character varying(50) null,
  cost numeric(10, 2) null default 0,
  weight numeric(5, 2) null default 0,
  description text null,
  properties character varying(200) null,
  damage character varying(50) null,
  armor_class integer null,
  stealth_disadvantage boolean null default false,
  created_at timestamp with time zone null default now(),
  updated_at timestamp with time zone null default now(),
  damage_type character varying(50) null,
  weapon_properties text null,
  is_ranged boolean null default false,
  strength integer null,
  stealth character varying(50) null,
  source character varying null,
  cost_text character varying null,
  weight_text character varying null,
  cost_currency character varying null,
  weapon_mastery character varying null,
  thrown_range character varying null,
  armor_class_modifier character varying(50) null,
  attribute_requirements jsonb null,
  required_attributes text null,
  constraint equipment_pkey primary key (id)
) TABLESPACE pg_default;

create index IF not exists idx_equipment_type on public.equipment using btree (type) TABLESPACE pg_default;

create index IF not exists idx_equipment_category on public.equipment using btree (category) TABLESPACE pg_default;

create trigger update_equipment_updated_at BEFORE
update on equipment for EACH row
execute FUNCTION update_updated_at_column ();
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
  constraint feats_pkey primary key (id),
  constraint feats_name_key unique (name)
) TABLESPACE pg_default;

create trigger update_feats_updated_at BEFORE
update on feats for EACH row
execute FUNCTION update_updated_at_column ();
create table public.items (
  id uuid not null default gen_random_uuid (),
  character_id uuid null,
  name character varying(100) not null,
  description text null,
  quantity integer null default 1,
  weight numeric(5, 2) null default 0,
  value numeric(10, 2) null default 0,
  type character varying(50) not null,
  equipped boolean null default false,
  created_at timestamp with time zone null default now(),
  updated_at timestamp with time zone null default now(),
  constraint items_pkey primary key (id),
  constraint items_character_id_fkey foreign KEY (character_id) references characters (id) on delete CASCADE
) TABLESPACE pg_default;

create index IF not exists idx_items_character_id on public.items using btree (character_id) TABLESPACE pg_default;

create trigger update_items_updated_at BEFORE
update on items for EACH row
execute FUNCTION update_updated_at_column ();
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
  subraces character varying null,
  description text null,
  traits_text text null,
  racial_spells text null,
  constraint races_pkey primary key (id),
  constraint races_name_key unique (name)
) TABLESPACE pg_default;

create trigger update_races_updated_at BEFORE
update on races for EACH row
execute FUNCTION update_updated_at_column ();
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
create table public.spells (
  id uuid not null default gen_random_uuid (),
  character_id uuid null,
  name character varying(100) not null,
  level integer not null,
  school character varying(100) not null,
  casting_time character varying(400) not null,
  range character varying(100) not null,
  components character varying(100) not null,
  duration character varying(100) not null,
  description text not null,
  prepared boolean null default false,
  created_at timestamp with time zone null default now(),
  updated_at timestamp with time zone null default now(),
  source character varying(100) null,
  classes character varying(200) null,
  ritual boolean null default false,
  concentration boolean null default false,
  constraint spells_pkey primary key (id),
  constraint spells_character_id_fkey foreign KEY (character_id) references characters (id) on delete CASCADE
) TABLESPACE pg_default;

create index IF not exists idx_spells_character_id on public.spells using btree (character_id) TABLESPACE pg_default;

create index IF not exists idx_spells_level on public.spells using btree (level) TABLESPACE pg_default;

create trigger update_spells_updated_at BEFORE
update on spells for EACH row
execute FUNCTION update_updated_at_column ();
create table public.user_profiles (
  id uuid not null default gen_random_uuid (),
  user_id uuid not null,
  display_name character varying(100) null,
  user_type character varying(20) null default 'simple'::character varying,
  avatar_url text null,
  created_at timestamp with time zone null default now(),
  updated_at timestamp with time zone null default now(),
  constraint user_profiles_pkey primary key (id),
  constraint user_profiles_user_id_key unique (user_id),
  constraint user_profiles_user_id_fkey foreign KEY (user_id) references auth.users (id) on delete CASCADE,
  constraint user_profiles_user_type_check check (
    (
      (user_type)::text = any (
        (
          array[
            'simple'::character varying,
            'admin'::character varying
          ]
        )::text[]
      )
    )
  )
) TABLESPACE pg_default;

create index IF not exists idx_user_profiles_user_id on public.user_profiles using btree (user_id) TABLESPACE pg_default;

create index IF not exists idx_user_profiles_user_type on public.user_profiles using btree (user_type) TABLESPACE pg_default;

create trigger update_user_profiles_updated_at BEFORE
update on user_profiles for EACH row
execute FUNCTION update_updated_at_column ();