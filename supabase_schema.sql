-- Highland Shooting Club Supabase schema draft
-- 先用於正式化架構參考，實際上線前可依權限政策微調 RLS。

create table if not exists profiles (
  id uuid primary key default gen_random_uuid(),
  email text unique,
  name text not null,
  role text not null default 'member' check (role in ('admin', 'member')),
  squad int default 1,
  level text default 'Novice',
  points int default 0,
  attendance int default 0,
  created_at timestamptz default now()
);

create table if not exists events (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  event_date date not null,
  event_time time not null,
  stages int default 0,
  quota int default 24,
  status text default '報名中',
  created_at timestamptz default now()
);

create table if not exists registrations (
  id uuid primary key default gen_random_uuid(),
  event_id uuid references events(id) on delete cascade,
  member_id uuid references profiles(id) on delete cascade,
  platform text not null check (platform in ('pistol', 'pcc')),
  optic boolean default false,
  compensator boolean default false,
  major_mod boolean default false,
  division text not null check (division in ('SSP-A', 'CO-A', 'PCC-A', 'OPEN-A')),
  created_at timestamptz default now(),
  unique(event_id, member_id)
);

create table if not exists scores (
  id uuid primary key default gen_random_uuid(),
  event_id uuid references events(id) on delete cascade,
  member_id uuid references profiles(id) on delete cascade,
  division text not null check (division in ('SSP-A', 'CO-A', 'PCC-A', 'OPEN-A')),
  raw_time numeric(10,2) not null,
  points_down int default 0,
  procedural_error int default 0,
  hnt int default 0,
  miss int default 0,
  penalty_seconds numeric(10,2) generated always as ((points_down * 1) + (procedural_error * 3) + (hnt * 5) + (miss * 5)) stored,
  total_time numeric(10,2) generated always as (raw_time + ((points_down * 1) + (procedural_error * 3) + (hnt * 5) + (miss * 5))) stored,
  created_at timestamptz default now()
);

create index if not exists scores_event_total_idx on scores(event_id, total_time);
create index if not exists registrations_event_idx on registrations(event_id);
