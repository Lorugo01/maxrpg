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