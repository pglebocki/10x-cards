-- Migration: Initial Schema
-- Description: Creates the initial database schema for 10xCards application
-- Tables: users, flashcards, generations, generation_error_logs
-- Author: AI Assistant
-- Date: 2024-03-20

-- Enable UUID extension for user IDs
create extension if not exists "uuid-ossp";

-- Create flashcards table
create table flashcards (
    id bigserial primary key,
    front varchar(200) not null,
    back varchar(500) not null,
    source varchar not null check (source in ('ai-full', 'ai-edited', 'manual')),
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now(),
    generation_id bigint,
    user_id uuid not null references auth.users(id)
);

-- Create generations table
create table generations (
    id bigserial primary key,
    user_id uuid not null references auth.users(id),
    model varchar not null,
    generated_count integer not null,
    accepted_unedited_count integer,
    accepted_edited_count integer,
    source_text_hash varchar not null,
    source_text_length integer not null check (source_text_length between 1000 and 10000),
    generation_duration integer not null,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

-- Create generation_error_logs table
create table generation_error_logs (
    id bigserial primary key,
    user_id uuid not null references auth.users(id),
    model varchar not null,
    source_text_hash varchar not null,
    source_text_length integer not null check (source_text_length between 1000 and 10000),
    error_code varchar(100) not null,
    error_message text not null,
    created_at timestamptz not null default now()
);

-- Add foreign key constraint for flashcards.generation_id
alter table flashcards
    add constraint fk_flashcards_generation
    foreign key (generation_id)
    references generations(id)
    on delete set null;

-- Create indexes for better query performance
create index idx_flashcards_user_id on flashcards(user_id);
create index idx_flashcards_generation_id on flashcards(generation_id);
create index idx_generations_user_id on generations(user_id);
create index idx_generation_error_logs_user_id on generation_error_logs(user_id);

-- Create updated_at trigger function
create or replace function update_updated_at_column()
returns trigger as $$
begin
    new.updated_at = now();
    return new;
end;
$$ language plpgsql;

-- Create triggers for updated_at
create trigger update_flashcards_updated_at
    before update on flashcards
    for each row
    execute function update_updated_at_column();

create trigger update_generations_updated_at
    before update on generations
    for each row
    execute function update_updated_at_column();

-- Enable Row Level Security
alter table flashcards enable row level security;
alter table generations enable row level security;
alter table generation_error_logs enable row level security;

-- RLS Policies for flashcards table
-- Select policy for authenticated users
create policy "Users can view their own flashcards"
    on flashcards for select
    to authenticated
    using (auth.uid() = user_id);

-- Insert policy for authenticated users
create policy "Users can create their own flashcards"
    on flashcards for insert
    to authenticated
    with check (auth.uid() = user_id);

-- Update policy for authenticated users
create policy "Users can update their own flashcards"
    on flashcards for update
    to authenticated
    using (auth.uid() = user_id)
    with check (auth.uid() = user_id);

-- Delete policy for authenticated users
create policy "Users can delete their own flashcards"
    on flashcards for delete
    to authenticated
    using (auth.uid() = user_id);

-- RLS Policies for generations table
-- Select policy for authenticated users
create policy "Users can view their own generations"
    on generations for select
    to authenticated
    using (auth.uid() = user_id);

-- Insert policy for authenticated users
create policy "Users can create their own generations"
    on generations for insert
    to authenticated
    with check (auth.uid() = user_id);

-- Update policy for authenticated users
create policy "Users can update their own generations"
    on generations for update
    to authenticated
    using (auth.uid() = user_id)
    with check (auth.uid() = user_id);

-- Delete policy for authenticated users
create policy "Users can delete their own generations"
    on generations for delete
    to authenticated
    using (auth.uid() = user_id);

-- RLS Policies for generation_error_logs table
-- Select policy for authenticated users
create policy "Users can view their own error logs"
    on generation_error_logs for select
    to authenticated
    using (auth.uid() = user_id);

-- Insert policy for authenticated users
create policy "Users can create their own error logs"
    on generation_error_logs for insert
    to authenticated
    with check (auth.uid() = user_id);

-- Note: No update or delete policies for error logs as they should be immutable 