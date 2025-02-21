--
-- Oracle Consulting Services 2012-2020. Premigration Analysis Report. Roman Muzykin
--
set pagesize 9999


column dbname new_value vdbname
SELECT name dbname FROM v$database;

column shorthostname new_value vshorthostname
select decode(instr(host_name,'.'),0,host_name,substr(host_name,1,instr(host_name,'.')-1)) shorthostname from v$instance;

column host_name new_value vhost_name
select host_name from v$instance;

column instance_name new_value vinstance_name
select INSTANCE_NAME from v$instance;

set head off echo off trimspool on feedback off pagesize 0 verify off linesize 400
spool &&vdbname._&&vshorthostname._&&vinstance_name._database_summary_HTML.html

set pagesize 999
PROMPT <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "https://urldefense.com/v3/__http://www.w3.org/TR/html4/frameset.dtd__;!!ITJX-7UZxWAC!4r7OQ-uGocioJc39gfhat09tGIxu3Pv05YuNg7ZEscBBZa8wOFzQtaD6tRs8aJuPxTQd_DMXsexi-Dum09oq9CKm$ "> 

PROMPT <HTML>

PROMPT <HEAD>

PROMPT <TITLE>
SELECT 'Oracle Testing Database Profile Report for: ' FROM DUAL ;
SELECT INSTANCE_NAME "INSTANCE NAME" FROM   gV$INSTANCE ;
SELECT ' run on '  ||  TO_CHAR(SYSDATE, 'MON-DD-YYYY HH24:MM:SS PM') FROM DUAL ;
PROMPT </TITLE>

PROMPT <STYLE type="text/css">

PROMPT  H1    {align: left; color: Black; font-family: Times; font-size: 18pt;} 
PROMPT  H2    {align: left; color: Blue;   font-family: Arial;   font-size: 11pt; font-weight: bold; text-decoration: underline;} 
PROMPT  H3    {align: left; color: Black;    font-family: Arial;  font-size: 11pt; font-weight: bold} 
PROMPT  BODY  {font-family: Arial; font-size: 10pt} 

PROMPT </STYLE>

PROMPT </HEAD>

PROMPT <BODY>

PROMPT <H2 id="Section0"></H2>

PROMPT <H1 id="TopOfPage">
PROMPT DBsummary HTML Report</H1>
PROMPT <H3>
select '"&&vdbname","'||host_name||'","&&vinstance_name"' from v$instance;
PROMPT </H3>
SELECT 'Report version v20200710 Generated at: '  ||  TO_CHAR(SYSDATE, 'MON-DD-YYYY HH24:MM:SS PM') FROM DUAL ;
PROMPT </H3>

PROMPT <OL>
PROMPT <LI> <A href="#Section1">  Source Database Instance Summary  </A>
PROMPT <LI> <A href="#Section2">  Source Pluggable Databases </A>
PROMPT <LI> <A href="#Section2a">  Full DB Version </A>
PROMPT <LI> <A href="#Section3">  Database Directories Configuration  </A>
PROMPT <LI> <A href="#Section4">  Database Link Connection Configuration  </A>
PROMPT <LI> <A href="#Section4a">  Database Link Distinct Host Parameter  </A>
PROMPT <LI> <A href="#Section5">  Database Name, Archivelog, Force Logging, etc...  </A>
PROMPT <LI> <A href="#Section6">  All Database Instances  </A>
PROMPT <LI> <A href="#Section7">  Supplemental Logging  </A>
PROMPT <LI> <A href="#Section8">  Tablespaces  </A>
PROMPT <LI> <A href="#Section9">  Current UNDO Tablespace Size  </A>
PROMPT <LI> <A href="#Section10">  TEMP Tablespace Size and Usage (GB)  </A>
PROMPT <LI> <A href="#Section11">  Read Only Tablespaces  </A>
PROMPT <LI> <A href="#Section12">  Schema Owners and Object Counts  </A>
PROMPT <LI> <A href="#Section13">  Schema Owners and Segment Sizes  </A>
PROMPT <LI> <A href="#Section14">  Non-Oracle Schemas with Objects in SYSTEM/SYSAUX Tablespaces  </A>
PROMPT <LI> <A href="#Section15">  Oracle Provided Schema Objects  </A>
PROMPT <LI> <A href="#Section15a"> Triggers on Database or Schema level  </A>
PROMPT <LI> <A href="#Section16">  Schemas with Password Version 10  </A>
PROMPT <LI> <A href="#Section17">  Users with Non-Existent TEMP Tablespaces </A>
PROMPT <LI> <A href="#Section18">  Users with TS Quotas on Non-Existent Tablespaces  </A>
PROMPT <LI> <A href="#Section18a">  Users with Non-Existent Default Tablespace  </A>
PROMPT <LI> <A href="#Section18b">  Tables with Column Type DATE and Default Value  </A>
PROMPT <LI> <A href="#Section18c">  Partitioned Tables with Default Tablespace which doesn't exist  </A>
PROMPT <LI> <A href="#Section19">  Objects Created with "Edition"  </A>
PROMPT <LI> <A href="#Section20">  Database Properties  </A>
PROMPT <LI> <A href="#Section21">  Database Components Installed  </A>
PROMPT <LI> <A href="#Section22">  Memory Initial Parameters  </A>
PROMPT <LI> <A href="#Section23">  Manually Set Initial Parameters </A>
PROMPT <LI> <A href="#Section24">  Underscore Parameters  </A>
PROMPT <LI> <A href="#Section25">  Trace and Other Events Set  </A>
PROMPT <LI> <A href="#Section28">  Database Services  </A>
PROMPT <LI> <A href="#Section29">  Creating Database Directories  </A>
PROMPT <LI> <A href="#Section30">  External Tables  </A>
PROMPT <LI> <A href="#Section31">  History of Database Connections  </A>
PROMPT <LI> <A href="#Section32">  SQL PROFILES  </A>
PROMPT <LI> <A href="#Section33">  DBMS JOBS  </A>
PROMPT <LI> <A href="#Section34">  SCHEDULER JOBS  </A>
PROMPT <LI> <A href="#Section35">  AWR Snapshots  </A>
PROMPT <LI> <A href="#Section36">  ACL Configuration  </A>
PROMPT <LI> <A href="#Section37">  Source Database ACL Configuration 11g  </A>
PROMPT <LI> <A href="#Section38">  Invalid Objects  </A>
PROMPT <LI> <A href="#Section39">  Database Vault Installed?  </A>
PROMPT <LI> <A href="#Section40">  Oracle Label Security Installed?  </A>
PROMPT <LI> <A href="#Section41">  Spatial Installed?  </A>
PROMPT <LI> <A href="#Section42">  Oracle Text Installed?  </A>
PROMPT <LI> <A href="#Section43">  Oracle Text Indexes  </A>
PROMPT <LI> <A href="#Section44">  Encryption Wallet/Keystore  </A>
PROMPT <LI> <A href="#Section45">  Encryption Keys 12c </A>
PROMPT <LI> <A href="#Section46">  Encrypted Columns  </A>
PROMPT <LI> <A href="#Section47">  TDE  configured?  </A>
PROMPT <LI> <A href="#Section48">  IOT Recreation After XTTS to HP-UX Itanium  </A>
PROMPT <LI> <A href="#Section49">  TimeStamp with Time Zone Columns  </A>
PROMPT <LI> <A href="#Section50">  Datafiles Need Recovery  </A>
PROMPT <LI> <A href="#Section51">  Analytical Workspace XTTS Endian  </A>
PROMPT <LI> <A href="#Section52">  Dictionary Managed Tablespaces  </A>
PROMPT <LI> <A href="#Section53">  Opaque Types  </A>
PROMPT <LI> <A href="#Section54">  Streams Configuration  </A>
PROMPT <LI> <A href="#Section55">  Advanced Queues  </A>
PROMPT <LI> <A href="#Section56">  AQ Records in Message Queue Tables  </A>
PROMPT <LI> <A href="#Section57">  Global Temporary Tables  </A>
PROMPT <LI> <A href="#Section58">  Schemas in SYSTEM or SYSAUX  </A>
PROMPT <LI> <A href="#Section61">  DBMS_TTS.TRANSPORT_SET_CHECK  </A>
PROMPT <LI> <A href="#Section62">  TTS Self-Contained Test Violations  </A>
PROMPT <LI> <A href="#Section63">  Maintenance Procedures, Database Statistics, etc...  </A>
PROMPT <LI> <A href="#Section64">  SCHEDULER JOBS Owned by SYS and ORACLE_OCM  </A>
PROMPT <LI> <A href="#Section65>  Window Groups  </A>
PROMPT <LI> <A href="#Section66">  Window Members  </A>
PROMPT <LI> <A href="#Section67">  Scheduler Windows  </A>
PROMPT <LI> <A href="#Section68">  Resource Manager Configuration  </A>
PROMPT </OL>

SET MARKUP HTML ON ENTMAP OFF;


-- SET VERIFY   ON
SET HEADING  ON
--SET FEEDBACK ON
SET FEEDBACK OFF
CLEAR BREAKS;
CLEAR COLUMNS;
col ord noprint

PROMPT
PROMPT <H2 id="Section1"> Source Database Instance Summary </H2>
BREAK on parameter

select 1 ord,'SOURCE DATABASE NAME' parameter, name value from v$database
union
select 2 ord,'SOURCE DATABASE GLOBAL NAME',global_name  from global_name
union
select 2.1 ord,'SOURCE DATABASE UNUQUE NAME',value from v$parameter where name='db_unique_name'
union
select 2.2 ord,'SOURCE DATABASE DOMAIN NAME',value from v$parameter where name='db_domain'
union
select 4 ord,'SOURCE DATABASE CPU_COUNT' ,value from v$parameter where name='cpu_count'
union
select 5 ord,'SOURCE DATABASE BLOCK SIZE',  value from v$parameter where name='db_block_size' 
union
select 6 ord,'SOURCE DATABASE VERSION', version from dba_registry where comp_id='CATALOG'
union
select 6.1 ord,'LDAP_DIRECTORY_ACCESS (CMDA)', decode(value,'NONE',value,value||' -!!! Additional LDAP configuration is required on Target !!!') from v$parameter where name='ldap_directory_access'
union
select 7 ord,'SOURCE: ORACLE CLUSTER DATABASE',  value from v$parameter where name='cluster_database'
union
select 8 ord,'SOURCE  DATABASE CHARACTER SET', value from NLS_DATABASE_PARAMETERS where parameter in ('NLS_CHARACTERSET')
union
select 9 ord,'SOURCE  DATABASE NCHAR CHARACTER SET', value from NLS_DATABASE_PARAMETERS where parameter in ('NLS_NCHAR_CHARACTERSET')
union
select 10 ord,'SOURCE HOSTNAME', host_name from v$instance
union
select 11 ord,'SOURCE SERVER OPERATING SYSTEM', platform_name from v$database
union
select 12 ord,'DATABASE SIZE GB',to_char(round(sum(bytes)/1024/1024/1024),'999,999,9999,999,990.9') GB from dba_data_files where TABLESPACE_NAME in (select TABLESPACE_NAME from dba_tablespaces where contents='PERMANENT')
union
select 12.1 ord,'ARCHIVELOG MODE',LOG_MODE from v$database
union
select 12.2 ord,'DAYLY ARCHIVED LOGS GB (last 30 days)', to_char(avg(a.num_logs*b.gb_avg),'999,999,9999,999,990.9') ARC_PER_DAY_GB
        from (SELECT  trunc(First_Time) DAY,   Count(1) num_logs
                 FROM    v$log_history
                  where trunc(First_Time) between trunc(sysdate)-31 and trunc(sysdate)-1
                 GROUP BY    trunc(First_Time)
        ) A, (SELECT Avg(BYTES)/1024/1024/1024 GB_AVG FROM v$log ) B
union
select  13 ord,'NUMBER OF USERS TO BE MIGRATED',to_char(count(1),'999,999,9999,999,999') from dba_users where username not in ('CTXSYS', 'ORDSYS', 'MDSYS', 'ORDPLUGINS', 'LBACSYS', 'XDB', 'SI_INFORMTN_SCHEMA', 'DIP', 'DMSYS', 'DBSNMP',  
                'SYS','SYSTEM','WMSYS','EXFSYS','WKSYS','WKPROXY','MDDATA','SYSMAN','MGMT_VIEW','OLAPSYS','OWBSYS','WK_TEST','ORDDATA','OUTLN','TSMSYS' )
union
select  13.1 ord,'NUMBER OF OBJECTS TO BE MIGRATED',to_char(count(1),'999,999,9999,999,999') from dba_objects where owner not in ('CTXSYS', 'ORDSYS', 'MDSYS', 'ORDPLUGINS', 'LBACSYS', 'XDB', 'SI_INFORMTN_SCHEMA', 'DIP', 'DMSYS', 'DBSNMP',  
                'SYS','SYSTEM','WMSYS','EXFSYS','WKSYS','WKPROXY','MDDATA','SYSMAN','MGMT_VIEW','OLAPSYS','OWBSYS','WK_TEST','ORDDATA','OUTLN','TSMSYS' )
union
select 13.2 ord,'SOURCE  DBTIMEZONE', dbtimezone from dual
union
select 14 ord,'SOURCE DATABASE TIMEZONE FILE VERSION',to_char(VERSION) from v$timezone_file
union
select 15 ord,'SOURCE DATABASE SGA_TARGET (GB)', to_char(round(sum(bytes)/1024/1024/1024),'999,999,9999,999,990.9') GB from v$sgastat
union
select 16 ord,'SOURCE DATABASE PGA_TARGET (GB)', to_char(round(to_number(value)/1024/1024/1024),'999,999,9999,999,990.9') GB from v$parameter where name='pga_aggregate_target'
union
select 17 ord,'SOURCE DATABASE COMPONENTS INSTALLED', comp_name||' '||version||' '||STATUS||' '||SCHEMA from dba_registry
order by 1,2
;

PROMPT
PROMPT
PROMPT <H2 id="Section2"> Source Pluggable Databases </H2>
Prompt You will see an error below if the database version does not support pluggable databases.
SELECT NAME, CON_ID, OPEN_MODE, RESTRICTED from V$PDBS;

PROMPT
PROMPT
PROMPT <H2 id="Section2a"> Full DB version </H2>
Prompt You will see an error below if the database version does not support this SQL
select INSTANCE_NUMBER,INSTANCE_NAME,HOST_NAME,VERSION_FULL,DATABASE_STATUS,INSTANCE_ROLE,INSTANCE_MODE,DATABASE_TYPE from gv$instance order by 1;


PROMPT
PROMPT
PROMPT <H2 id="Section3"> Database Directories Configuration </H2>
select 1 ord,DIRECTORY_NAME "Oracle Directory Name" ,DIRECTORY_PATH "Source Directory Path",'' "Target Directory Path" from dba_directories 
order by 1,2,3;

PROMPT
PROMPT
PROMPT <H2 id="Section4"> Database Link Connection Configuration </H2>
col owner format a30
col db_link format a30
col username format a30
col host format a80
SELECT  OWNER, DB_LINK, USERNAME, HOST from dba_db_links order by  owner,db_link;    

PROMPT
PROMPT
PROMPT <H2 id="Section4a"> Database Link Distinct Host Parameter  </H2>
Prompt The tnsnames.ora should be able to resolve these entries. Test with tnsping after setting them up.
SELECT  distinct HOST from dba_db_links order by  1;    

PROMPT
PROMPT
PROMPT <H2 id="Section5"> Database Name, Archivelog, Force Logging, etc... </H2>
col DATAGUARD_BROKER format a16
col FORCE_LOGGING format a13
select  DBID, NAME, LOG_MODE, PROTECTION_MODE, PROTECTION_LEVEL, DATABASE_ROLE, FORCE_LOGGING, PLATFORM_NAME,PLATFORM_ID, FLASHBACK_ON, DB_UNIQUE_NAME,DATAGUARD_BROKER from v$database;

PROMPT
PROMPT
PROMPT <H2 id="Section6"> All Database Instances </H2>
select inst_id,INSTANCE_NUMBER,INSTANCE_NAME,HOST_NAME,INSTANCE_ROLE from gv$instance;

PROMPT
PROMPT
PROMPT <H2 id="Section7"> Supplemental Logging  </H2>
Prompt SUPPLEMENTAL_LOG_DATA_XXX
select  SUPPLEMENTAL_LOG_DATA_MIN MIN,
 SUPPLEMENTAL_LOG_DATA_PK PK, 
 SUPPLEMENTAL_LOG_DATA_UI UI, 
 SUPPLEMENTAL_LOG_DATA_FK FK, 
 SUPPLEMENTAL_LOG_DATA_ALL "ALL" from v$database;

PROMPT
PROMPT
PROMPT <H2 id="Section8"> Tablespaces  </H2>
col EXTENT_MANAGEMENT format a17
col ALLOCATION_TYPE format a15
col SEGMENT_SPACE_MANAGEMENT format a24
select t.TABLESPACE_NAME,t.CONTENTS, t.BLOCK_SIZE,t.BIGFILE,t.EXTENT_MANAGEMENT,t.ALLOCATION_TYPE,t.SEGMENT_SPACE_MANAGEMENT,round(sum(f.bytes)/1024/1024/1024) GB
from dba_tablespaces t, dba_data_files f 
where t.tablespace_name=f.tablespace_name
group by t.TABLESPACE_NAME,t.CONTENTS,t.BLOCK_SIZE,t.BIGFILE,t.EXTENT_MANAGEMENT,t.ALLOCATION_TYPE,t.SEGMENT_SPACE_MANAGEMENT
order by 1 ;

PROMPT
PROMPT
PROMPT <H2 id="Section9"> Current UNDO Tablespace Size  </H2>
select tablespace_name "Tablespace", round(sum(bytes)/(1024*1024*1024)) "Current size GB",
round(sum((CASE WHEN autoextensible='YES' THEN maxbytes ELSE bytes END))/(1024*1024*1024)) "Max size GB"
from dba_data_files
where tablespace_name  in (select tablespace_name from dba_tablespaces where contents='UNDO')
 group by tablespace_name
order by tablespace_name
;

PROMPT
PROMPT
PROMPT <H2 id="Section10"> TEMP Tablespace Size and Usage (GB)  </H2>
select tablespace_name "Tablespace", round(sum(bytes)/(1024*1024*1024)) "Current size GB",
round(sum((CASE WHEN autoextensible='YES' THEN maxbytes ELSE bytes END))/(1024*1024*1024)) "Max size GB"
from dba_temp_files
group by tablespace_name
;

PROMPT
PROMPT
PROMPT <H2 id="Section11"> Read Only Tablespaces  </H2>
Prompt Read only tablespaces should be converted to READ WRITE in case of XTTS with incrementals or RMAN backup recovery upgrade migration scenarios.
select tablespace_name from dba_tablespaces where status='READ ONLY';

PROMPT
PROMPT
PROMPT <H2 id="Section12"> Schema Owners and Object Counts  </H2>
select owner,object_type,count(*) from dba_objects  where owner not in ('CTXSYS', 'ORDSYS', 'MDSYS', 'ORDPLUGINS', 'LBACSYS', 'XDB', 'SI_INFORMTN_SCHEMA', 'DIP', 'DMSYS', 'DBSNMP',  
                'SYS','SYSTEM','WMSYS','EXFSYS','WKSYS','WKPROXY','MDDATA','SYSMAN','MGMT_VIEW','OLAPSYS','OWBSYS','WK_TEST','ORDDATA','OUTLN','TSMSYS' )
 group by owner,object_type order by 1,2;

PROMPT
PROMPT
PROMPT <H2 id="Section13"> Schema Owners and Segment Sizes  </H2>
select OWNER, SEGMENT_TYPE, count(*) SEGMENT_COUNT, round(sum(bytes)/1024/1024/1024) SIZE_GB from dba_segments 
 where owner not in ('CTXSYS', 'ORDSYS', 'MDSYS', 'ORDPLUGINS', 'LBACSYS', 'XDB', 'SI_INFORMTN_SCHEMA', 'DIP', 'DMSYS', 'DBSNMP',  
                'SYS','SYSTEM','WMSYS','EXFSYS','WKSYS','WKPROXY','MDDATA','SYSMAN','MGMT_VIEW','OLAPSYS','OWBSYS','WK_TEST','ORDDATA','OUTLN','TSMSYS' )
 group by OWNER,SEGMENT_TYPE 
 order by 1,2;

PROMPT
PROMPT
PROMPT <H2 id="Section14"> Non-Oracle Schemas with Objects in SYSTEM/SYSAUX Tablespaces </H2>
Prompt These should be moved to user tablespaces. XTTS migration will not migrate these objects.
select OWNER, tablespace_name, SEGMENT_TYPE, count(*) SEGMENT_COUNT, round(sum(bytes)/1024/1024/1024) SIZE_GB from dba_segments 
 where owner not in ('CTXSYS', 'ORDSYS', 'MDSYS', 'ORDPLUGINS', 'LBACSYS', 'XDB', 'SI_INFORMTN_SCHEMA', 'DIP', 'DMSYS', 'DBSNMP',  
                'SYS','SYSTEM','WMSYS','EXFSYS','WKSYS','WKPROXY','MDDATA','SYSMAN','MGMT_VIEW','OLAPSYS','OWBSYS','WK_TEST','ORDDATA','OUTLN','TSMSYS' )
 and tablespace_name in ('SYSTEM','SYSAUX')
 group by OWNER, tablespace_name, SEGMENT_TYPE 
 order by 1,2;

PROMPT
PROMPT
PROMPT <H2 id="Section15"> Oracle Provided Schema Objects </H2>
Prompt Oracle provided schemas should not have objects in tablespaces to be transported by XTTS.
select owner,tablespace_name,count(*) from dba_segments
  where tablespace_name NOT in ('SYSTEM','SYSAUX') 
  and tablespace_name in (select tablespace_name from dba_tablespaces where contents='PERMANENT')
  and owner in ('CTXSYS', 'ORDSYS', 'MDSYS', 'ORDPLUGINS', 'LBACSYS', 'XDB', 'SI_INFORMTN_SCHEMA', 'DIP', 'DMSYS', 'DBSNMP',  
                'SYS','SYSTEM','WMSYS','EXFSYS','WKSYS','WKPROXY','MDDATA','SYSMAN','MGMT_VIEW','OLAPSYS','OWBSYS','WK_TEST','ORDDATA','OUTLN' )
group by owner,tablespace_name order by 1,2;

PROMPT
PROMPT <H2 id="Section15a"> Triggers on Database or Schema level </H2>
Prompt 
col triggering_event for a30
col owner for a30
select owner,trigger_type,BASE_OBJECT_TYPE,triggering_event,status,count(*)  from dba_triggers  where TABLE_NAME is null group by owner,trigger_type,BASE_OBJECT_TYPE,triggering_event,status order by 1,2;

PROMPT
PROMPT
PROMPT <H2 id="Section16"> Schemas with Password Version 10 </H2>
Prompt Schemas with password version 10 have to be reset to an 11-12 version before migration.
Prompt If password version is 10 ONLY, you will not be able to to use it after migration/upgrade
Prompt Find out what usernames/passwords need to be reset and do this in the SOURCE database
Prompt ref: PASSWORD_VERSIONS and Parameter sqlnet ALLOWED_LOGON_VERSION_SERVER For User with 10G in PASSWORD_VERSION (Doc ID 2410225.1)
Prompt ref: Passwords Are Not Working After Upgrading To 12c From 10g (Doc ID 2286646.1)
Prompt ref: 12c Database Alert.log File Shows The Message: Using Deprecated SQLNET.ALLOWED_LOGON_VERSION Parameter (Doc ID 2111876.1)
SELECT PASSWORD_VERSIONS,count(*) FROM DBA_USERS where PASSWORD_VERSIONS like '%10%' group by PASSWORD_VERSIONS;
Prompt 
prompt List of Users with Version 10 Only:
select username, account_status,password_versions from dba_users where trim(password_versions)='10G';

PROMPT
PROMPT
PROMPT <H2 id="Section17"> Users with Non-Existent TEMP Tablespaces </H2>
Prompt Users with temporary tablespace which do not exist anymore. Fix before export.
select username,temporary_tablespace from dba_users where temporary_tablespace  not in (select tablespace_name from dba_tablespaces where contents='TEMPORARY');

PROMPT
PROMPT
PROMPT <H2 id="Section18"> Users with TS Quotas on Non-Existent Tablespaces </H2>
Prompt Users with TS quotas on tablespaces which do not exist anymore. Fix before export.
select username,TABLESPACE_NAME from dba_ts_quotas where TABLESPACE_NAME  not in (select tablespace_name from dba_tablespaces);

PROMPT
PROMPT
PROMPT <H2 id="Section18a"> Users with Non-Existent Default Tablespace  </H2>
Prompt Any users with DEFAULT TABLESPACE which doesn't exist in the database (was dropped after user created). Will generate an error during DPUMP or XTTS migration. Needs to be fixed in source database!!!
select username,default_tablespace from dba_users where default_tablespace not in (select tablespace_name from dba_tablespaces) order by 1;

PROMPT
PROMPT
PROMPT <H2 id="Section18b"> Tables with Column Type DATE and Default Value  </H2>
Prompt Check if any tables were created with column type DATE and default value. Check if any default value will depend on the NLS_DATE_FORMAT of the client session.
prompt DPUMP and XTTS will fail.
prompt Client session of impdp should be configured with ENV variable:
prompt export NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS'
prompt to match the UNSPECIFIED format of the default value for date columns when tables were created.
prompt IMPDP - ORA-39083 and ORA-01847 (Day Of Month Must Be...) On Import Of Table (Doc ID 1632220.1)
prompt Information on these default values will be stored in SYSTEM.TMP_TAB_COLS_DEFAULTS for more research
Prompt
drop table SYSTEM.TMP_TAB_COLS_DEFAULTS_;
drop table SYSTEM.TMP_TAB_COLS_DEFAULTS;
create table SYSTEM.TMP_TAB_COLS_DEFAULTS_ as select owner,table_name,column_name,to_lob(DATA_DEFAULT) DATA_DEFAULT  from dba_tab_cols where DATA_DEFAULT is not null and DATA_TYPE='DATE'   
 and  owner not in ('CTXSYS', 'ORDSYS', 'MDSYS', 'ORDPLUGINS', 'LBACSYS', 'XDB', 'SI_INFORMTN_SCHEMA', 'DIP', 'DMSYS', 'DBSNMP',  
                'SYS','SYSTEM','WMSYS','EXFSYS','WKSYS','WKPROXY','MDDATA','SYSMAN','MGMT_VIEW','OLAPSYS','OWBSYS','WK_TEST','ORDDATA','OUTLN','TSMSYS','APPQOSSYS','GSMADMIN_INTERNAL' );
create table SYSTEM.TMP_TAB_COLS_DEFAULTS as select owner,table_name,column_name,dbms_lob.substr( DATA_DEFAULT, 4000, 1 ) DATA_DEFAULT  from SYSTEM.TMP_TAB_COLS_DEFAULTS_;
select DATA_DEFAULT,count(*) from SYSTEM.TMP_TAB_COLS_DEFAULTS group by DATA_DEFAULT;
drop table SYSTEM.TMP_TAB_COLS_DEFAULTS_;



PROMPT <H2 id="Section18c"> Partitioned tables with Default tablespace which does not exist anymore  </H2>
Prompt 
prompt Partitioned Tables created with Default tablespace which does not exist anymore. Definition of the table MUST be changed before DataPump migration
Prompt

select owner,table_name,DEF_TABLESPACE_NAME from dba_part_tables where DEF_TABLESPACE_NAME not in (select tablespace_name from dba_tablespaces);



PROMPT
PROMPT
PROMPT <H2 id="Section19"> Objects Created with "Edition" </H2>
Prompt Edition Based Redefinition info (11g only) Objects which were created with "Edition"
select object_type,edition_name,count(*) from dba_objects where owner  in (select distinct owner from dba_objects where edition_name is not null) group by object_type,edition_name order by 1,2;

PROMPT
PROMPT
PROMPT <H2 id="Section20"> Database Properties </H2>
select PROPERTY_NAME,PROPERTY_VALUE from database_properties order by 1;

PROMPT
PROMPT
PROMPT <H2 id="Section21"> Database Components Installed  </H2>
col COMP_NAME format a40
col COMP_ID format a20
set pages 999 lines 300
select COMP_ID,COMP_NAME,VERSION,STATUS from dba_registry;

PROMPT
PROMPT
PROMPT <H2 id="Section22"> Memory Initial Parameters  </H2>
col name format a30
col value format a60
 select inst_id,name,value from gv$system_parameter
where name in (
'memory_max_target',
'memory_target',
'sga_max_size',
'sga_target',
'shared_pool_size',
'db_cache_size',
'large_pool_size',
'java_pool_size',
'pga_aggregate_target',
'workarea_size_policy',
'streams_pool_size'
);

PROMPT
PROMPT
PROMPT <H2 id="Section23"> Manually Set Initial Parameters </H2>
select 1 ord, inst_id,name,value from gv$system_parameter where ISDEFAULT='FALSE'
order by 1,2,3;

PROMPT
PROMPT
PROMPT <H2 id="Section24"> Underscore Parameters </H2>
Prompt For upgrade it is recommended to consider removing underscore parameters.
SELECT inst_id,name,value,description from SYS.gV$PARAMETER WHERE name LIKE '\_%' ESCAPE '\';

PROMPT
PROMPT
PROMPT <H2 id="Section25"> Trace and Other Events Set </H2>
Prompt Should be removed before migration.
SELECT (translate(value,chr(13)||chr(10),' ')) FROM sys.gv$parameter2
      WHERE  UPPER(name) ='EVENT' AND  isdefault='FALSE'
UNION
SELECT (translate(value,chr(13)||chr(10),' ')) from sys.gv$parameter2
      WHERE UPPER(name) = '_TRACE_EVENTS' AND isdefault='FALSE';


PROMPT
PROMPT
PROMPT <H2 id="Section28"> Database Services  </H2>
select INST_ID,NAME,NETWORK_NAME from gv$services;

PROMPT
PROMPT
PROMPT <H2 id="Section29"> Creating Database Directories </H2>
Prompt Should be created after migration.
col DIRECTORY_NAME format a30
col DIRECTORY_PATH format a80
select OWNER,DIRECTORY_NAME,DIRECTORY_PATH from dba_directories order by 1,2;

PROMPT
PROMPT
PROMPT <H2 id="Section30"> External Tables </H2>
select owner, table_name, TYPE_NAME, DEFAULT_DIRECTORY_NAME from dba_external_tables order by 1,2,3;
select owner, DEFAULT_DIRECTORY_NAME, count(*) from dba_external_tables group by owner, DEFAULT_DIRECTORY_NAME order by 1,2,3;

PROMPT
PROMPT
PROMPT <H2 id="Section31"> History of Database Connections </H2>
Prompt Database connections from active session history table for last 60 days.
col machine format a40
col username format a30
select * from (
select h.machine, u.username, h.program, count(*) count
 from dba_hist_active_sess_history h, dba_users u
 where h.user_id!=0
 and u.user_id=h.user_id
 and h.sample_time > sysdate - 60
 group by h.machine, u.username, h.program
 order by count desc
 ) where rownum <500;

PROMPT
PROMPT
PROMPT <H2 id="Section32"> SQL PROFILES </H2>
col SIGNATURE for 99999999999999999999999
col sql_text for a82
col name format a35
col created for a40
col last_modified for a30
select name,SIGNATURE,status,force_matching,last_modified, 
substr(sql_text,1,20) sql_text 
--substr(sql_text,1,80) sql_text 
from dba_sql_profiles 
--where last_modified > sysdate-1
order by created;

PROMPT
PROMPT
PROMPT <H2 id="Section33"> DBMS JOBS </H2>
select  LOG_USER,PRIV_USER,SCHEMA_USER,to_char(NEXT_DATE,'dd-mon-yyyy hh24:mi:ss'),BROKEN,INTERVAL,WHAT  from dba_jobs order by 1,2,3,4;

PROMPT
PROMPT
PROMPT <H2 id="Section34"> SCHEDULER JOBS </H2>
col owner format a15
col job_name format a25
col job_type format a17
col job_action format a40
col REPEAT_INTERVAL format a20
col STATE format a10
col comments format a40
col LAST_START_DATE format a25
select OWNER, JOB_NAME, JOB_ACTION,REPEAT_INTERVAL,STATE, LAST_START_DATE,comments from dba_SCHEDULER_JOBS order by 1,2,3;

PROMPT
PROMPT
PROMPT <H2 id="Section35"> AWR Snapshots </H2>
Prompt Use "execute dbms_workload_repository.modify_snapshot_settings(interval => 60,retention => 11520);" to adjust.
select
      extract( day from snap_interval) *24*60+
      extract( hour from snap_interval) *60+
      extract( minute from snap_interval ) "Snapshot Interval",
      extract( day from retention) *24*60+
      extract( hour from retention) *60+
      extract( minute from retention ) "Retention Interval"
from dba_hist_wr_control;

PROMPT
PROMPT
PROMPT <H2 id="Section36"> ACL Configuration </H2>
Prompt ACL configuration needs to be completed in target 11g database if the following query returns records.
col owner format a15
SELECT DISTINCT owner , name, type, referenced_name
     FROM DBA_DEPENDENCIES 
     WHERE referenced_name 
     IN ('UTL_TCP','UTL_SMTP','UTL_MAIL','UTL_HTTP','UTL_INADDR','DBMS_LDAP')
     AND owner NOT IN ('SYS','PUBLIC','ORDPLUGINS');

PROMPT
PROMPT
PROMPT <H2 id="Section37"> Source Database ACL Configuration 11g </H2>
Prompt 11g ONLY
column acl format a30
column host format a20
column principal format a20
column privilege format a10
column is_grant format a8
select acl , host , lower_port , upper_port from DBA_NETWORK_ACLS;
select acl , principal , privilege , is_grant from DBA_NETWORK_ACL_PRIVILEGES;

PROMPT
PROMPT
PROMPT <H2 id="Section38"> Invalid Objects  </H2>
Prompt Invalid objects should be recompiled, including SYS objects. Invalid SYS objects could affect expdp.
col owner format a30
select owner, object_type, count(*) from dba_objects  where status = 'INVALID' group by owner, object_type order by owner, object_type;

PROMPT
PROMPT
PROMPT <H2 id="Section39"> Database Vault Installed?  </H2>
Prompt Database Vault installed? If yes it should be installed in Target Database Home.
SELECT * FROM V$OPTION WHERE PARAMETER = 'Oracle Database Vault';

PROMPT
PROMPT
PROMPT <H2 id="Section40"> Oracle Label Security Installed?  </H2>
Prompt If yes it should be installed in Target Database Home
Prompt If the source database is 11g, OLS policies cannot be migrated through XTTS. 
SELECT case count(schema)
WHEN 0 THEN 'Oracle Label Security is NOT installed at database level'
ELSE 'Oracle Label Security is installed '
END  "Oracle Label Security Check"
FROM dba_registry
WHERE schema='LBACSYS';

PROMPT
PROMPT
PROMPT <H2 id="Section41"> Spatial Installed? </H2>
Prompt If yes, then XTTS will fail depending on source version. Check XTTS limitations
select owner,object_type,count(*) from dba_objects where owner in ('MDSYS','MDDATA') group by owner,object_type;

PROMPT
PROMPT
PROMPT <H2 id="Section42"> Oracle Text Installed?  </H2>
Prompt Some additional steps should be taken. If using XTTS, Indexes needs to be synchronized.
select owner,object_type,count(*) from dba_objects where owner in ('CTXSYS') group by owner,object_type;

PROMPT
PROMPT
PROMPT <H2 id="Section43"> Oracle Text Indexes </H2>
Prompt Oracle Text Indexes to be synchronized before XTTS migration.
select pnd_index_owner,pnd_index_name,count(*)
from ctxsys.ctx_pending
group by
pnd_index_owner,pnd_index_name
order by pnd_index_owner,
pnd_index_name;
select distinct
'exec
ctx_ddl.sync_index('''||pnd_index_owner||'.'||pnd_index_name||''');'
from ctxsys.ctx_pending;

PROMPT
PROMPT
PROMPT <H2 id="Section44"> Encryption Wallet/Keystore  </H2>
SET LINESIZE 200
COLUMN wrl_parameter FORMAT A50
SELECT * FROM v$encryption_wallet;

PROMPT
PROMPT
PROMPT <H2 id="Section45"> Encryption Keys 12c  </H2>
Prompt For 12c ONLY
SELECT con_id, key_id FROM v$encryption_keys;

Prompt Keys from enc$, will show if there are leftovers from removed wallet
SELECT * from enc$;

PROMPT
PROMPT
PROMPT <H2 id="Section46"> Encrypted Columns  </H2>
Prompt There are certain restrictions. Needs to be unencrypted before XTTS migration.
select OWNER,TABLE_NAME,COLUMN_NAME,ENCRYPTION_ALG from DBA_ENCRYPTED_COLUMNS;

PROMPT
PROMPT
PROMPT <H2 id="Section47"> TDE Configured?  </H2>
Prompt See MOS ID 828223.1
Prompt TTS for TDE encrypted tablespaces or tablepaces containing tables with encrypted columns are no longer supported from 12c (MOS 1454872.1)
select * from DBA_ENCRYPTED_COLUMNS;
Prompt GV$ENCRYPTED_TABLESPACES used only for 11 source
select * from GV$ENCRYPTED_TABLESPACES;

PROMPT
PROMPT
PROMPT <H2 id="Section48"> IOT Recreation After XTTS to HP-UX Itanium  </H2>
Prompt IOT needs to be recreated after XTTS to HP-UX Itanium. Bug 9816640 closed as not feasible to fix.
select owner,index_type,count(*) from dba_indexes where index_type like 'IOT%' and 
  owner not in ('CTXSYS', 'ORDSYS', 'MDSYS', 'ORDPLUGINS', 'LBACSYS', 'XDB', 'SI_INFORMTN_SCHEMA', 'DIP', 'DMSYS', 'DBSNMP',  
                'SYS','SYSTEM','WMSYS','EXFSYS','WKSYS','WKPROXY','MDDATA','SYSMAN','MGMT_VIEW','OLAPSYS','OWBSYS','WK_TEST','ORDDATA','OUTLN','TSMSYS' )
group by owner,index_type order by 1,2;

PROMPT
PROMPT
PROMPT <H2 id="Section49"> TimeStamp with Time Zone Columns  </H2>
Prompt This select gives all TimeStamp with Time Zone (TSTZ) columns in your database.
Prompt If the source is Oracle Database (11.2.0.2) or later and there are tables in the transportable set that use TIMESTAMP WITH TIMEZONE (TSTZ) columns,
Prompt then the time zone file version on the target database must exactly match the time zone file version on the source database.
Prompt If the source is Oracle Database < (11.2.0.2), then Time Zone File Version MUST match on source and target database
select c.owner , c.table_name , c.column_name , c.data_type 
  from dba_tab_cols c, dba_objects o
 where c.data_type like '%WITH TIME ZONE'
    and c.owner=o.owner
    and o.owner not in ('CTXSYS', 'ORDSYS', 'MDSYS', 'ORDPLUGINS', 'LBACSYS', 'XDB', 'SI_INFORMTN_SCHEMA', 'DIP', 'DMSYS', 'DBSNMP',  
                'SYS','SYSTEM','WMSYS','EXFSYS','WKSYS','WKPROXY','MDDATA','SYSMAN','MGMT_VIEW','OLAPSYS','OWBSYS','WK_TEST','ORDDATA','OUTLN','TSMSYS' )
   and c.table_name = o.object_name
   and o.object_type = 'TABLE'
order by 1,2,3
/

PROMPT
PROMPT
PROMPT <H2 id="Section50"> Datafiles Need Recovery  </H2>
Prompt Complete before migration.
SELECT * FROM v$recover_file;

PROMPT
PROMPT
PROMPT <H2 id="Section51"> Analytical Workspace XTTS Endian  </H2>
Prompt Analytical Workspace XTTS is not supported across different endian for XTTS.
prompt  Analytic Workspace installed?
SELECT comp_name, version, status FROM DBA_REGISTRY 
     WHERE comp_name LIKE '%OLAP%';

PROMPT
PROMPT
PROMPT <H2 id="Section52"> Dictionary Managed Tablespaces  </H2>
Prompt Dictionary managed tablespaces, must be converted to locally managed before XTTS.
SELECT tablespace_name
FROM dba_tablespaces
where extent_management='DICTIONARY' and TABLESPACE_NAME != 'SYSTEM';

PROMPT
PROMPT
PROMPT <H2 id="Section53"> Opaque Types  </H2>
Prompt Opaque Types(such as RAW, BFILE, and the AnyTypes) can be transported, but they are not converted as part of the cross-platform transport operation.
prompt Their actual structure are known only to the application, so the application must address any endianness issues after these types are moved to the new platform.
select owner,data_type,count(*) from dba_tab_columns 
  where data_type in ('RAW','BFILE','ANYDATA') 
  and owner not in ('CTXSYS', 'ORDSYS', 'MDSYS', 'ORDPLUGINS', 'LBACSYS', 'XDB', 'SI_INFORMTN_SCHEMA', 'DIP', 'DMSYS', 'DBSNMP',  
                'SYS','SYSTEM','WMSYS','EXFSYS','WKSYS','WKPROXY','MDDATA','SYSMAN','MGMT_VIEW','OLAPSYS','OWBSYS','WK_TEST','ORDDATA','OUTLN' )
group by owner,data_type order by 1,2;

PROMPT
PROMPT
PROMPT <H2 id="Section54"> Streams Configuration  </H2>
Prompt Streams configuration should be recreated and verified on target after XTTS or EXPDP migration (if the following SQL returns any records).
select CAPTURE_NAME,QUEUE_NAME,QUEUE_OWNER,STATUS from dba_capture;
select APPLY_NAME,QUEUE_NAME,QUEUE_OWNER,STATUS from dba_apply;

PROMPT
PROMPT
PROMPT <H2 id="Section55"> Advanced Queues  </H2>
Prompt Advanced queues, needs to be recreated after XTTS migration.
select OWNER,NAME,QUEUE_TABLE from DBA_QUEUES;
select OWNER,QUEUE_TABLE,TYPE from dba_queue_tables;

PROMPT
PROMPT
PROMPT <H2 id="Section56"> AQ Records in Message Queue Tables  </H2>
Prompt Number of AQ Records in Message Queue Tables NOT owned by ('SYS', 'SYSTEM', 'SYSMAN', 'DBSNMP','WMSYS')
SET SERVEROUTPUT ON SIZE 100000
declare
   V_COUNT NUMBER;
     cursor c1 is
         select owner,queue_table from dba_queue_tables where owner NOT in ('SYS', 'SYSTEM', 'SYSMAN', 'DBSNMP','WMSYS');
 begin
    for c in c1
     loop
        execute immediate 'select count(1) from ' || c.owner || '.'  || c.queue_table into v_count;
        dbms_output.put_line(c.owner || ' - ' || c.queue_table  || ' - ' || v_count);
     end loop;
 END;
/

PROMPT
PROMPT
PROMPT <H2 id="Section57"> Global Temporary Tables  </H2>
Prompt Global temporary tables are not transported by TTS, however migration scripts will take care of them. Separate Export/Import job
select OWNER,TABLE_NAME from dba_tables where temporary='Y'
  and owner not in ('CTXSYS', 'ORDSYS', 'MDSYS', 'ORDPLUGINS', 'LBACSYS', 'XDB', 'SI_INFORMTN_SCHEMA', 'DIP', 'DMSYS', 'DBSNMP',  
                'SYS','SYSTEM','WMSYS','EXFSYS','WKSYS','WKPROXY','MDDATA','SYSMAN','MGMT_VIEW','OLAPSYS','OWBSYS','WK_TEST','ORDDATA','OUTLN','TSMSYS' )
;

PROMPT
PROMPT
PROMPT <H2 id="Section58"> Schemas in SYSTEM or SYSAUX  </H2>
Prompt Any schemas installed in SYSTEM or SYSAUX tablespaces need to be exported separately and will not be migrated by XTTS.
select owner,SEGMENT_TYPE,tablespace_name,count(*) from dba_segments 
 where tablespace_name in ('SYSTEM','SYSAUX')
  and  owner not in ('CTXSYS', 'ORDSYS', 'MDSYS', 'ORDPLUGINS', 'LBACSYS', 'XDB', 'SI_INFORMTN_SCHEMA', 'DIP', 'DMSYS', 'DBSNMP',  
                'SYS','SYSTEM','WMSYS','EXFSYS','WKSYS','WKPROXY','MDDATA','SYSMAN','MGMT_VIEW','OLAPSYS','OWBSYS','WK_TEST','ORDDATA','OUTLN','TSMSYS','APPQOSSYS','GSMADMIN_INTERNAL' )
 group by owner,SEGMENT_TYPE,tablespace_name
 order by 1,2;



--PROMPT
--PROMPT
--PROMPT <H2 id="Section61"> DBMS_TTS.TRANSPORT_SET_CHECK  </H2>
--Prompt Self-contained test for XTTS migrations.
--DECLARE
--  v_first_line boolean;
--  v_tname varchar2(32767);
--  v_cmd_str varchar2(32767);
--
--BEGIN
--  dbms_output.enable(10000);
--  v_first_line := TRUE;
--  FOR c1 IN (select   tablespace_name from dba_tablespaces
--                      where tablespace_name in (select tablespace_name from dba_tablespaces where contents='PERMANENT')
--		      and tablespace_name not in ('SYSTEM','SYSAUX')
--              order by 1) LOOP
--       v_tname := c1.tablespace_name;
--       if (NOT v_first_line) then
--              v_tname := ','|| v_tname;
--       end if;
--       v_first_line := FALSE;
--       v_cmd_str := v_cmd_str || v_tname;
--  END LOOP;
--  v_cmd_str :='BEGIN sys.dbms_tts.transport_set_check(''' || v_cmd_str || ''',TRUE,TRUE); END;';
--  execute immediate v_cmd_str ;
--  --dbms_output.put_line(v_cmd_str);
--
--
--END;
--/
--





PROMPT
PROMPT
PROMPT <H2 id="Section62"> TTS Self-Contained Test Violations  </H2>
SELECT violations FROM TRANSPORT_SET_VIOLATIONS;

PROMPT
PROMPT
PROMPT <H2 id="Section63"> Maintenance Procedures, Database Statistics, etc...  </H2>
Prompt These jobs are not migrated by Datapump, We have to identify if they are default on the source or if they are user created and need to be recreated in the target database.
SET PAGES 999 LINES 300
COL OWNER FORMAT A15
COL JOB_NAME FORMAT A25
COL JOB_TYPE FORMAT A17
COL JOB_ACTION FORMAT A40
COL REPEAT_INTERVAL FORMAT A70
COL STATE FORMAT A10
COL COMMENTS FORMAT A40
COL NEXT_START_DATE FORMAT A25
COL LAST_START_DATE FORMAT A25
COL SCHEDULE_NAME FORMAT A30
COL SCHEDULE_OWNER FORMAT A12
COL DURATION FORMAT A15
COL MANUAL_DURATION FORMAT A20
COL MANUAL_OPEN_TIME FORMAT A10
COL START_DATE FORMAT A20
COL END_DATE FORMAT A20

PROMPT
PROMPT
PROMPT <H2 id="Section64"> SCHEDULER JOBS Owned by SYS and ORACLE_OCM  </H2>
Prompt Will not be exported imported.
select OWNER, JOB_NAME, STATE, REPEAT_INTERVAL, SCHEDULE_NAME, COMMENTS, LAST_START_DATE from dba_SCHEDULER_JOBS  where owner in ('SYS','ORACLE_OCM') order by 1,2;

--Prompt Maintenance jobs history (for 11g only) - can take very long time to execute

--select * from 
--(select client_name, job_status, job_start_time, job_duration from dba_autotask_job_history order by job_start_time desc)
--where rownum < 10;

--Prompt Autotask maintenance jobs (for 11g only)  - can take very long time to execute

--      select client_name, status, window_group from dba_autotask_client;

PROMPT
PROMPT
PROMPT <H2 id="Section65"> Window Groups  </H2>
select * from DBA_SCHEDULER_WINDOW_GROUPS;

PROMPT
PROMPT
PROMPT <H2 id="Section66"> Window Members  </H2>
select * from DBA_SCHEDULER_WINGROUP_MEMBERS order by 1,2;

PROMPT
PROMPT
PROMPT <H2 id="Section67"> Scheduler Windows  </H2>
select window_name, repeat_interval, duration,enabled from dba_scheduler_windows order by window_name;

PROMPT
PROMPT
PROMPT <H2 id="Section68"> Resource Manager Configuration  </H2>
Prompt Current Resource Plan Used by the database:
show parameter resource_manager_plan

Prompt --- RESOURCE PLANS ---

col COMMENTS format a60
select PLAN, COMMENTS from DBA_RSRC_PLANS order by 1;

Prompt --- CONSUMER GROUPS ---

select CONSUMER_GROUP,CPU_METHOD from DBA_RSRC_CONSUMER_GROUPS order by 1;

Prompt --- PLAN DIRECTIVES ---

select PLAN,GROUP_OR_SUBPLAN,CPU_P1,CPU_P2,CPU_P3,CPU_P4,CPU_P5 from DBA_RSRC_PLAN_DIRECTIVES order by 1,2;

Prompt --- Group Grantees ---

select GRANTED_GROUP, GRANTEE from DBA_RSRC_CONSUMER_GROUP_PRIVS where GRANTED_GROUP in ('DEFAULT_CONSUMER_GROUP','SYS_GROUP','LOW_GROUP') order by 1,2;
select GRANTED_GROUP, GRANTEE from DBA_RSRC_CONSUMER_GROUP_PRIVS where GRANTED_GROUP NOT in ('DEFAULT_CONSUMER_GROUP','SYS_GROUP','LOW_GROUP') order by 1,2;


set serveroutput on size 100000 long 10000 longchunksize 10000
Prompt --- Some historical metrics from awr tables ---

DECLARE
 delim    CONSTANT CHAR(1) := ',';
 dbname   v$database.name%TYPE;
 instnum  v$instance.instance_number%TYPE;
 servname v$instance.host_name%TYPE;
 dbsize   INTEGER;
 raccnt   INTEGER;
 sgasize  INTEGER;
 acc      NUMBER;
 mcc      NUMBER;
 x        NUMBER;
BEGIN
  SELECT name
  INTO dbname
  FROM v$database;

  SELECT MAX(maxval)
  INTO x
  FROM dba_hist_sysmetric_summary
  WHERE metric_name = 'CPU Usage Per Sec';

  SELECT UNIQUE instance_number
  INTO instnum
  FROM dba_hist_sysmetric_summary
  WHERE metric_name = 'CPU Usage Per Sec'
  AND maxval = x;

  SELECT COUNT(*)
  INTO raccnt
  FROM gv$instance;

  SELECT host_name
  INTO servname
  FROM gv$instance
  WHERE instance_number = instnum;

  SELECT MAX(DECODE(metric_name, 'CPU Usage Per Sec', ROUND(average/100,2), NULL)) avg_cpu_count,
         MAX(DECODE(metric_name, 'CPU Usage Per Sec', ROUND(maxval/100,2), NULL)) max_cpu_count
  INTO acc, mcc
  FROM (
        SELECT snap_id, instance_number INST, metric_name, average, maxval
        FROM dba_hist_sysmetric_summary
        WHERE instance_number = instnum
        AND metric_name = 'CPU Usage Per Sec');

-- dbsize
   WITH d AS (SELECT SUM(bytes/1024/1024/1024) SB FROM dba_data_files),
        t AS (SELECT SUM(bytes/1024/1024/1024) SB FROM dba_temp_files)
    SELECT CEIL(SUM(d.sb + t.sb))
    INTO dbsize
    FROM d, t;

-- sga
  SELECT CEIL(SUM(value))
  INTO sgasize
  FROM gv$sga
  WHERE inst_id = instnum;


  dbms_output.put_line(dbname || delim || servname || delim || dbsize 
|| delim || acc || delim || mcc || delim || raccnt || delim || sgasize);
END;
/


SET MARKUP HTML OFF ;
spool off


