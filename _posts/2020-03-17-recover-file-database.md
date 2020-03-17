---
title: "Recovering a Malformed/Corrupt SQLite Database"
categories:
  - ArcGIS
  - Data
tags:
  - sql
  - recover
  - geodata
---

[SQLite](https://www.sqlite.org/index.html) databases are a great resource to have under your belt. There is no need for configuration or admin setup, no dependencies, essentially no size limits, cross platform support, and the entire database is stored in a single file on disk. This makes it extremely easy to start developing with a SQLite database. As projects grow, as long as you are using an Object Relational Mapper (ORM), it is relatively easy to transition into a more complex database such as [MySQL](https://www.mysql.com/) or [PostgreSQL](https://www.postgresql.org/).

Since the whole database is stored in a single file on disk, it is important to consistently backup the data. This post is for those who didn't.

## Steps to fix the issue
 Make sure you have the [SQLite CLI](https://sqlite.org/cli.html) installed.The steps will assume that your database is called 'corrupt.sl3', however the file name and extension can be anything you choose. The following steps will work with [file geodatabases](https://www.esri.com/news/arcuser/0309/files/9reasons.pdf) used with Esri software as well.

1. navigate to the directory containing the database using the Command Prompt or Terminal
2. open the database

   `sqlite3 corrupt.sl3`
3. type the following line and press enter
   
   `PRAGMA integrity_check;`
4. If you see the following error it means these steps will fix your issue. If not, lower your expectations and keep trucking
   
   `Error: database disk image is malformed`
5. copy the contents of the malformed database to a sql file using the following commands
    ```
   .mode insert
   .output dump.sql
   .dump
   .exit
   ```
6. Open the dump.sql file in a text editor
7. scroll down to the bottom and change the last line from
 
   `ROLLBACK; -- due to errors`

   to

   `COMMIT;`
8. Go back to Command Prompt or Terminal and create a new sqlite database
   
   `sqlite3 fixed.sl3`
9.  Read the sql insert file into the new sqlite database
    
   `.read dump.sql`
10. Once this is done, check if you can access the data
    
   `.tables`

---
That's it, your database should be recovered.