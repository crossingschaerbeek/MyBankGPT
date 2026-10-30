-- Exécuter dans l'éditeur SQL de Supabase. Authentification publique désactivée dans le dashboard.
create table if not exists public.accounts (id uuid primary key default gen_random_uuid(),user_id uuid not null references auth.users(id) on delete cascade,name text not null check(length(name) between 1 and 80),opening_balance numeric(15,2) not null default 0,created_at timestamptz not null default now());
create table if not exists public.transactions (id uuid primary key default gen_random_uuid(),user_id uuid not null references auth.users(id) on delete cascade,account_id uuid not null references public.accounts(id) on delete restrict,kind text not null check(kind in ('income','expense')),amount numeric(15,2) not null check(amount>0),category text not null,description text not null default '',occurred_on date not null,created_at timestamptz not null default now());
create table if not exists public.debts (id uuid primary key default gen_random_uuid(),user_id uuid not null references auth.users(id) on delete cascade,creditor text not null,balance numeric(15,2) not null check(balance>0),minimum_payment numeric(15,2) not null default 0 check(minimum_payment>=0),interest_rate numeric(5,2) not null default 0 check(interest_rate between 0 and 100),due_on date,priority text not null check(priority in ('urgent','normal')),notes text not null default '',created_at timestamptz not null default now());
create index if not exists transactions_user_date on public.transactions(user_id,occurred_on desc);
create index if not exists debts_user_due on public.debts(user_id,due_on);
alter table public.accounts enable row level security;
alter table public.transactions enable row level security;
alter table public.debts enable row level security;
create policy "accounts owner" on public.accounts for all to authenticated using (user_id=(select auth.uid())) with check(user_id=(select auth.uid()));
create policy "transactions owner" on public.transactions for all to authenticated using (user_id=(select auth.uid())) with check(user_id=(select auth.uid()));
create policy "debts owner" on public.debts for all to authenticated using (user_id=(select auth.uid())) with check(user_id=(select auth.uid()));
