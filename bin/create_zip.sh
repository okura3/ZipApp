#!/bin/sh
mkdir -p data
sqlite3 data/zip.sqlite <<__EOM__
create table zip (
  id        integer primary key autoincrement,
  code      char(5),
  zipold    char(5),
  zipcode   char(7),
  ken_kana  varchar(128),
  siku_kana varchar(128),
  cho_kana  varchar(128),
  ken_char  varchar(128),
  siku_char varchar(128),
  cho_char  varchar(128),
  flg1      char(1),
  flg2      char(1),
  flg3      char(1),
  flg4      char(1),
  flg5      char(1),
  flg6      char(1)
);
__EOM__
