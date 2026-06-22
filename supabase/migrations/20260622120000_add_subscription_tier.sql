-- Add subscription tier to profiles.
-- Values: 'free' | 'monthly' | 'yearly'. Existing rows default to 'free'.
alter table public.profiles
  add column if not exists subscription_tier text not null default 'free';

-- Guard against invalid values (safe: new column, all existing rows = 'free').
alter table public.profiles
  add constraint profiles_subscription_tier_check
  check (subscription_tier in ('free', 'monthly', 'yearly'));
