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