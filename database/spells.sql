create table public.spells (
  id uuid not null default gen_random_uuid (),
  character_id uuid null,
  name text not null,
  level integer not null,
  school text not null,
  casting_time text not null,
  range text not null,
  components text not null,
  duration text not null,
  description text not null,
  -- Campos para efeito mecânico (dano/cura) e escalonamento por upcast
  effect_type text null, -- 'damage' | 'healing'
  base_dice text null,   -- ex: '2d8', '2d4'
  include_spell_mod boolean null default false, -- soma mod de conjuração
  damage_type text null, -- ex: 'Fogo', 'Veneno'
  upcast_dice_per_level text null, -- ex: '1d8' ou '2d4'
  -- Truques: aumentos de dado por nível de personagem (lista de {level:int, dice:text})
  cantrip_dice_increases jsonb null,
  prepared boolean null default false,
  created_at timestamp with time zone null default now(),
  updated_at timestamp with time zone null default now(),
  source text null,
  classes text null,
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