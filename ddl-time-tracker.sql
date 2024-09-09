-- creating database
CREATE DATABASE time_tracker;
-- create table users
create table users(
  id serial primary key,
  name varchar(25) not null,
  email varchar(25) not null,
  role varchar(25) not null,
  rate integer not null check(rate >= 0)
);
--create table projects
create table projects(
  id serial primary key,
  name varchar(25) not null,
  category varchar(25) not null,
  start_date date not null,
  end_date date not null,
  closed boolean not null default false
);
--create table projects_users
create table projects_users(
  id serial primary key,
  user_id integer,
  project_id integer,
  total_budget integer not null check(total_budget >= 0),
  constraint fk_user foreign key (user_id) references users(id),
  constraint fk_project foreign key (project_id) references projects(id)
);
--create table daily_logs
create table daily_logs(
  id serial primary key,
  project_users_id integer,
  date DATE not null,
  hours INTEGER not null check(hours >= 0),
  constraint fk_project_users foreign key (project_users_id) references projects_users(id)
);
--
--
--
--Modifications
--
--unique email in the users table
alter table users
add constraint unique_email UNIQUE(email);
--up to 50 characters for name and role columns in the users table
alter table users
alter column name type varchar(50);
-- and role
alter table users
alter column role type varchar(50);
--Ensure that end_date is greater than start_date in the projects table.
alter table projects
add constraint check_end_date check (end_date > start_date);
--Ensure that the combination of fk_user and fk_project is unique
alter table projects_users
add constraint unique_fks UNIQUE(user_id, project_id);
--Ensure that the combination of fk_project_users and date are unique in the daily_logs table
alter table daily_logs
add constraint unique_fk_project_user_date UNIQUE(project_users_id, date);