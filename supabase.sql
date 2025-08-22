
-- Enable UUIDs
create extension if not exists "uuid-ossp";

-- Profiles
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  username text,
  created_at timestamp with time zone default now()
);

alter table public.profiles enable row level security;

create policy "profiles are viewable by users" on public.profiles
  for select using (true);

create policy "users can update own profile" on public.profiles
  for update using (auth.uid() = id);

-- Series curated
create table if not exists public.series (
  id uuid primary key default uuid_generate_v4(),
  tmdb_id integer not null unique,
  created_at timestamp with time zone default now()
);
alter table public.series enable row level security;
create policy "series readable by all" on public.series for select using (true);

-- Favorites
create table if not exists public.favorites (
  user_id uuid references auth.users(id) on delete cascade,
  tmdb_id integer not null,
  created_at timestamp with time zone default now(),
  primary key (user_id, tmdb_id)
);
alter table public.favorites enable row level security;
create policy "favorites readable by owner" on public.favorites
  for select using (auth.uid() = user_id);
create policy "favorites insert by owner" on public.favorites
  for insert with check (auth.uid() = user_id);
create policy "favorites delete by owner" on public.favorites
  for delete using (auth.uid() = user_id);

-- Likes
create table if not exists public.likes (
  user_id uuid references auth.users(id) on delete cascade,
  tmdb_id integer not null,
  created_at timestamp with time zone default now(),
  primary key (user_id, tmdb_id)
);
alter table public.likes enable row level security;
create policy "likes readable by owner" on public.likes
  for select using (auth.uid() = user_id);
create policy "likes insert by owner" on public.likes
  for insert with check (auth.uid() = user_id);
create policy "likes delete by owner" on public.likes
  for delete using (auth.uid() = user_id);

-- Ratings
create table if not exists public.ratings (
  user_id uuid references auth.users(id) on delete cascade,
  tmdb_id integer not null,
  value integer not null check (value between 1 and 10),
  created_at timestamp with time zone default now(),
  primary key (user_id, tmdb_id)
);
alter table public.ratings enable row level security;
create policy "ratings readable by owner" on public.ratings
  for select using (auth.uid() = user_id);
create policy "ratings upsert by owner" on public.ratings
  for insert with check (auth.uid() = user_id);
create policy "ratings update by owner" on public.ratings
  for update using (auth.uid() = user_id);

-- Comments
create table if not exists public.comments (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid references auth.users(id) on delete cascade,
  tmdb_id integer not null,
  content text not null,
  created_at timestamp with time zone default now()
);
alter table public.comments enable row level security;
create policy "comments readable by all" on public.comments
  for select using (true);
create policy "comments insert by owner" on public.comments
  for insert with check (auth.uid() = user_id);

-- Allow admins to insert to series table: we'll handle in frontend by email allowlist (ENV ADMIN_EMAILS)
-- Optionally, you can add a Postgres function to validate admin role if you want stricter control.
