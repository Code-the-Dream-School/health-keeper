# HealthKeeper

## Installation

1. Install Ruby `3.2.1`.
2. Create `.env` file in root folder of the project.
3. Install [PostgreSQL](https://www.postgresql.org/download/) `>=14.13`.
   '''
   sudo apt update
   sudo apt install postgresql-14
   '''
4. Create PostgreSQL user and set password:
   '''
   sudo -u postgres psql
   '''
   '''
   CREATE USER healthkeeper WITH PASSWORD 'magic';
   '''
   '''
   ALTER USER healthkeeper CREATEDB;
   '''
6. Quit postgres
   '''
   \q
   '''
   
7. Add corresponded env variables to `.env` file with DB credentials. E.g.:
```
HEALTHKEEPER_DEVELOPMENT_DATABASE = "healthkeeper_development"
HEALTHKEEPER_DEVELOPMENT_DATABASE_USERNAME = "healthkeeper"
HEALTHKEEPER_DEVELOPMENT_DATABASE_PASSWORD = "magic"

HEALTHKEEPER_TEST_DATABASE = "healthkeeper_test"
HEALTHKEEPER_TEST_DATABASE_USERNAME = "healthkeeper"
HEALTHKEEPER_TEST_DATABASE_PASSWORD = "magic"
```
4. Run `./bin/bundle install`
6. Run `rails db:setup`.
7. In order to recreate DB run `rails db:reset`.
8. In order to (re)populate DB with a testing data run `rails db:seed`.
9. Run 'rake db:migrate'
10. To run Rails server use `./bin/dev` instead of `rails s`/`rails server` (see [next chapter](#bootstrap-and-tailwindCSS) if curious why).

# Troubleshooting
1. ActiveRecord::DatabaseConnectionError: There is an issue connecting to your database with your username/password, username: healthkeeper. (ActiveRecord::DatabaseConnectionError)
   Edit the PostgreSQL authentication configuration:
   '''
   sudo nano /etc/postgresql/14/main/pg_hba.conf
   '''
   Make sure all content is all the same:
   '''
   # PostgreSQL Client Authentication Configuration File
   # ===================================================
   
   # TYPE  DATABASE        USER            ADDRESS                 METHOD
   
   # Database administrative login by Unix domain socket
   local   all             postgres                                peer
   
   # "local" is for Unix domain socket connections only
   local   all             all                                     md5
   
   # IPv4 local connections:
   host    all             all             127.0.0.1/32            md5
   
   # IPv6 local connections:
   host    all             all             ::1/128                 md5
   '''
### Bootstrap and TailwindCSS
As we have both Bootstrap and TailwindCSS installed inside the project we need to split them somehow.
> Thus, to utilize TailwindCSS make sure that you use the classes with the prefix.
If you want to add a `p-1` class then it should be `tw-p-1` now.
But it does not apply to the states, for example, if you want to add a `p-2` on hover, then your class should be `hover:tw-p-2`.

> Also, in order to support hot reload of TailwindCSS class changes, you need to run Rails server with `./bin/dev` instead of `rails s`/`rails server`.

## How to run the test suite

TODO

## App scope to be done

### **High Priority**

1. [ ] **Health Data Management**
   - [ ] User Story 1: Manual input of blood test results.
   - [ ] User Story 2: Import health data from PDF files.
   - [x] User Story 4: Display health data with color-coded references.
2. [ ] **User Interface and Experience**
   - [ ] User Story 16: See trends in health data over a defined period.
3. [x] **Biomarker and Disease Database**
   - [x] User Story 22: Allow users to add their own reference databases.
4. [x] **Security**
   - [x] Authentication.
   - [x] Authorization.
   - [x] Role management.
      - [x] Tune role policies.
5. [ ] Wrap an app in Docker.
