-- Per-user daily chat message counter (calendar day, UTC; not a rolling window).
-- chat_count_date stores the UTC day the counter belongs to; when it differs
-- from the current UTC day, the count is treated as 0 (lazy reset on next use).
alter table public.profiles
  add column if not exists chat_count integer not null default 0;

alter table public.profiles
  add column if not exists chat_count_date date not null
    default (now() at time zone 'utc')::date;
