-- ============================================================
-- VendorScout Business Dashboard v2 — Supabase Setup Script
-- Run this in the Supabase SQL Editor (project: modqzgdfrpypicyubpra)
-- ============================================================

-- 1) WEEKLY TASKS (non-negotiables checklist)
create table if not exists weekly_tasks (
  id uuid primary key default gen_random_uuid(),
  task_name text not null,
  task_day text,
  completed boolean not null default false,
  week_start date not null
);

-- 2) PIPELINE (CRM)
create table if not exists pipeline (
  id uuid primary key default gen_random_uuid(),
  company text not null,
  contact_name text,
  contact_role text,
  source text,
  stage text not null default 'Signal',
  estimated_value numeric default 0,
  last_action text,
  next_action text,
  next_action_date date,
  notes text,
  created_at timestamp with time zone default now()
);

-- 3) CONTENT CALENDAR
create table if not exists content_calendar (
  id uuid primary key default gen_random_uuid(),
  post_date date not null,
  platform text,
  topic text not null,
  target_audience text,
  status text not null default 'planned',
  impressions integer default 0,
  likes integer default 0,
  comments integer default 0,
  generated_inbound boolean default false
);

-- 4) WARM SIGNALS
create table if not exists warm_signals (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  company text,
  signal_type text,
  signal_date date not null default current_date,
  content_engaged text,
  contacted boolean default false,
  responded boolean default false,
  notes text
);

-- 5) REVENUE
create table if not exists revenue (
  id uuid primary key default gen_random_uuid(),
  client_name text not null,
  service_type text,
  monthly_value numeric default 0,
  start_date date,
  status text not null default 'active'
);

-- 6) WEEKLY REFLECTIONS
create table if not exists weekly_reflections (
  id uuid primary key default gen_random_uuid(),
  week_start date not null,
  wins text,
  challenges text,
  adjustments text,
  score integer check (score between 1 and 10)
);

-- 7) SETTINGS (small key/value table for manual inputs like
--    newsletter subscriber count, SaaS MVP %, speaking toggle —
--    needed for Home + Goals tabs; not in your original list but
--    required so those manual inputs persist across sessions)
create table if not exists dashboard_settings (
  key text primary key,
  value text
);

-- ------------------------------------------------------------
-- Row Level Security: enable + allow the anon key full access.
-- This dashboard is a single-user internal tool authenticated
-- only by knowledge of the URL, using the public anon key.
-- ------------------------------------------------------------
alter table weekly_tasks enable row level security;
alter table pipeline enable row level security;
alter table content_calendar enable row level security;
alter table warm_signals enable row level security;
alter table revenue enable row level security;
alter table weekly_reflections enable row level security;
alter table dashboard_settings enable row level security;

create policy "anon full access" on weekly_tasks for all using (true) with check (true);
create policy "anon full access" on pipeline for all using (true) with check (true);
create policy "anon full access" on content_calendar for all using (true) with check (true);
create policy "anon full access" on warm_signals for all using (true) with check (true);
create policy "anon full access" on revenue for all using (true) with check (true);
create policy "anon full access" on weekly_reflections for all using (true) with check (true);
create policy "anon full access" on dashboard_settings for all using (true) with check (true);

-- ------------------------------------------------------------
-- Seed data — pre-populates Pipeline and Content Calendar per spec
-- ------------------------------------------------------------
insert into pipeline (company, contact_name, contact_role, source, stage, estimated_value, last_action, next_action, next_action_date)
values
  ('Go-To Skincare', 'Leonie + Brad', null, 'Inbound post', 'Proposal', 35000, null, 'Follow up', '2026-07-28'),
  ('Avène/Klorane', null, 'Digital Marketing Manager', 'Warm signal', 'Contacted', 15000, null, 'Book call', '2026-07-29'),
  ('Olivalore', 'Jacques', null, 'Inbound post', 'Nurturing', 8000, null, 'Check in', '2026-08-15'),
  ('Accord Australasia', null, 'VP', 'Event', 'Contacted', 0, null, 'Send research', '2026-07-30');

insert into content_calendar (post_date, platform, topic, target_audience, status, impressions, likes, comments, generated_inbound)
values
  ('2026-07-07', 'LinkedIn', 'Prime Day AU dates confirmed', 'Amazon vendors', 'published', 4605, 14, 2, false),
  ('2026-07-14', 'LinkedIn', 'AU marketplace consolidation', 'Retail + eCommerce', 'published', 26377, 107, 14, true),
  ('2026-07-20', 'LinkedIn', 'Online Retailer attendance', 'All', 'published', 600, 16, 2, false),
  ('2026-07-22', 'LinkedIn', 'Channel margin strategy', 'Brand managers', 'published', 800, 14, 3, false),
  ('2026-08-04', 'LinkedIn', 'Digital shelf vs physical shelf', 'Beauty brands', 'planned', 0, 0, 0, false),
  ('2026-08-06', 'LinkedIn', 'Channel margin map', 'Founders/CFOs', 'planned', 0, 0, 0, false);

insert into dashboard_settings (key, value) values
  ('newsletter_subscribers', '250'),
  ('saas_mvp_percent', '0'),
  ('speaking_invitation', 'false')
on conflict (key) do nothing;
