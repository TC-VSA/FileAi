create table if not exists public.scan_summaries(id uuid primary key, user_id uuid references auth.users(id), status text not null, created_at timestamptz default now());
alter table public.scan_summaries enable row level security;
create policy "owner read" on public.scan_summaries for select using (auth.uid() = user_id);
create policy "owner insert" on public.scan_summaries for insert with check (auth.uid() = user_id);
