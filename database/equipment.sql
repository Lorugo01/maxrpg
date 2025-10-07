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