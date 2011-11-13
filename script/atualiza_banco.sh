
perl script/rnsp_cms_create.pl model DB DBIC::Schema RNSP::CMS::Schema  create=static  components=TimeStamp 'dbi:SQLite:rnsp.db' on_connect_do="PRAGMA foreign_keys = ON" 


