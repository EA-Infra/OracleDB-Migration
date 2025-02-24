CREATE TABLE extract_oem_data(
   CNDB_NAME  VARCHAR2(150)  ,
   HOSTNAME VARCHAR2(150) ,
   HOST_DOMAIN VARCHAR2(150) ,
   INSTANCE_NAME VARCHAR2(150) ,
   DB_UNIQUE_NAME VARCHAR2(150) ,
   DBID VARCHAR2(150) ,
   CPU_COUNT NUMBER ,
   MAX_USED_CPU_COUNT NUMBER ,
   SGA_GB NUMBER ,
   SGA_MAX_SIZE NUMBER ,
   PGA_MAX_SIZE NUMBER ,
   DB_SIZE_GB NUMBER ,
   RAC_NODES_NUM NUMBER(10) ,
   RAM_SIZE_GB NUMBER ,
   NLS_CHARACTERSET VARCHAR2(150) ,
   NCHAR_CHARACTERSET VARCHAR2(150) ,
   DB_BLOCK_SIZE NUMBER(10) ,
   VERSION VARCHAR2(150) ,
   UNDO_RETENTION VARCHAR2(150) ,
   LOG_ARCHIVE_CONFIG VARCHAR2(150) ,
   LOG_MODE VARCHAR2(150) ,
   FLASHBACK_ON VARCHAR2(150) ,
   FORCE_LOGGING VARCHAR2(150) ,
   PROTECTION_MODE VARCHAR2(150) ,
   DATABASE_ROLE VARCHAR2(150) ,
   OPEN_MODE VARCHAR2(150) ,
   CPU_DETAIL_NAME VARCHAR2(150) ,
   OS VARCHAR2(150) ,
   DB_SERVICE_TIER VARCHAR2(150) ,
   ARCH_DAILY_GB NUMBER ,
   PLATFORM_NAME VARCHAR2(150) ,
   TARGET_TYPE VARCHAR2(150) ,
   DB_NAME_I VARCHAR2(150) ,
   MEMORY_TARGET_I NUMBER ,
   PGA_AGGREGATE_LIMIT_I NUMBER ,
   PGA_AGGREGATE_TARGET_I NUMBER ,
   PROCESSES_I NUMBER ,
   SESSIONS_I NUMBER ,
   SGA_MAX_SIZE_I NUMBER ,
   USE_LARGE_PAGES_I VARCHAR2(150) ,
   HOST_NAME_O_H VARCHAR2(150) ,
   SYSTEM_CONFIG_H VARCHAR2(150) ,
   DISK_H NUMBER ,
   CPU_COUNT_H NUMBER ,
   PHYSICAL_CPU_COUNT_H NUMBER ,
   LOGICAL_CPU_COUNT_H NUMBER ,
   FREQ_IN_MHZ_H VARCHAR2(150) ,
   ECACHE_IN_MB_H NUMBER ,
   NUM_CORES_H NUMBER ,
   MAX_USED_CPU_COUNT_PER NUMBER ,
   SRC_PROVIDER VARCHAR2(50) ,
   TRG_PROVIDER VARCHAR2(50) ,
   APP_OWNER_CONTACT_NAME VARCHAR2(50) ,
   DBA_MANAGER_NAME VARCHAR2(50) ,
   DBA_CONTACT_NAME VARCHAR2(50) ,
   LINE_OF_BUSINESS VARCHAR2(50) ,
   LOB_CONTACT_NAME VARCHAR2(50) ,
   BUSINESS_GROUP VARCHAR2(50) ,
   BU_CONTACT_NAME VARCHAR2(50) ,
   NETWORK_MANAGER_CONTACT_NAME VARCHAR2(50) ,
   STORAGE_ADMIN_CONTACT_NAME VARCHAR2(50) ,
   DATA_CENTER VARCHAR2(50) ,
   DB_PRODUCT VARCHAR2(50) ,
   APP_NAME VARCHAR2(50) ,
   APP_ID VARCHAR2(50) ,
   ENVIRONMENT VARCHAR2(50) ,
   SECURITY_ZONE VARCHAR2(50) ,
   MAPPING VARCHAR2(10) ,
   SCHEDULING VARCHAR2(10) ,
   TRANSACTION_TYPE VARCHAR2(50) ,
   REQ_CUTOVER_TIME VARCHAR2(100) ,
   MIGRATION_GROUP VARCHAR2(100) ,
   LOADED_CPU_COUNT VARCHAR2(100) ,
   RPO VARCHAR2(100) ,
   RTO VARCHAR2(100) ,
   HOST_CPU_COUNT VARCHAR2(100) ,
   TARGET_NAME VARCHAR2(100) ,
   PHASE_NUMBER VARCHAR2(100),
   iops number,
   CDB_CPU number,
   CDB_SGA number,
   CDB_PGA number
);

declare ----CSV
		p_query varchar2(3000);
		TOT_CNT number;
		
		p_key_value    varchar2(150) :='artos0011' ;     --Key to used to Encrypt the DBNAME and HOSTNAME
		p_dataCenterName varchar2(1000) :='DataCenterName';
		p_dataCenterPer varchar2(1000)  :='DataCenterPer';
		p_totTagProvPer varchar2(1000)  :='TargetProviderPer';
		p_target_provider_name varchar2(1000):='TargetProviderName';
		p_EnvironmentName varchar2(1000) :='EnvironmentName';
		p_Environmentpct varchar2(1000):='EnvironmentPer';
		p_securityzone_name  varchar2(1000) :='SecurityZoneName';
		p_securityzone_pct  varchar2(1000):='SecurityZonePer';
		p_application_name varchar2(1000):='APP1';
		p_application_name_pct varchar2(1000):='100';
		p_requestcutover_time varchar2(1000):='RequestCutOverName';
		p_requestcutover_time_pct varchar2(1000):='RequestCutOverPer';
		p_option number :=1;
		p_username varchar2(100):= 'SYSMAN.';      --FOR ex. = 'SYSMAN.'
		p_cndb_name_enc varchar2(150);
		p_host_name_enc varchar2(150);
		p_inst_name_enc varchar2(150);

 PROCEDURE sp_oem_extract AS

			p_query                 VARCHAR2(3000) := '';
			p_subquery              VARCHAR2(3000) := '';
			v_member_target_guid    VARCHAR2(150) := '';
			v_name                  VARCHAR2(150) := '';
			v_value                 VARCHAR2(150) := '';
			v_target_name           VARCHAR2(150);
			v_target_guid           VARCHAR2(150);
			v_host_name             VARCHAR2(150);
			v_rac_target_name       VARCHAR2(150);
			v_rac_target_guid       VARCHAR2(150);
			v_arch_daily_gb         NUMBER;
			v_rac_nodes_num         NUMBER;
			v_sga_max_size          NUMBER;
			v_pga_max_size          NUMBER;
			v_db_or_racinst         VARCHAR2(150);
			v_dbsize_gb             NUMBER;
			v_num                   NUMBER;
			v_max_used_cpu_count    NUMBER:=0;
			v_max_used_cpu_count_per NUMBER:=0;
			v_nls_charset           VARCHAR2(150);
			v_dbid                  VARCHAR2(150);
			v_nchar_charset         VARCHAR2(150);
			v_log_mode              VARCHAR2(150);
			v_version               VARCHAR2(150);
			v_open_mode             VARCHAR2(150);
			v_protection_mode       VARCHAR2(150);
			v_database_role         VARCHAR2(150);
			v_force_logging         VARCHAR2(150);
			v_flashback_on          VARCHAR2(150);
			v_dbname                VARCHAR2(150);
			v_tgtdbname             VARCHAR2(150);
			TYPE ref_cur IS REF CURSOR;
			c                       ref_cur;
			c1                      ref_cur;
			v_TARGET_TYPE           VARCHAR2(150);

			v_cpu_count_i NUMBER;
			v_pga_aggregate_limit_i NUMBER;
			v_pga_aggregate_target_i NUMBER;
			v_processes_i NUMBER;
			v_sessions_i NUMBER;
			v_sga_max_size_i NUMBER;
			v_sga_target_i NUMBER;
			v_use_large_pages_i varchar2(150);
			v_db_block_size_i NUMBER;
			v_log_archive_config_i VARCHAR2(150);
			v_memory_target_i NUMBER;
			v_instance_name_i VARCHAR2(150);
			v_undo_retention_i VARCHAR2(150);
			v_db_unique_name_i VARCHAR2(150);
			v_db_name_i VARCHAR2(150);
			v_host_name_o_h VARCHAR2(150);
			v_host_name_h VARCHAR2(150);
			v_system_config_h VARCHAR2(150);
			v_ram_size_gb_h NUMBER;
			v_disk_h NUMBER;
			v_iops number;
			v_fd_v_iops number;
			v_cpu_count_h NUMBER;
			v_os_summary_h VARCHAR2(150);
			v_physical_cpu_count_h NUMBER;
			v_logical_cpu_count_h NUMBER;
			v_domain_h VARCHAR2(150);
			v_vendor_name_h VARCHAR2(150);
			v_freq_in_mhz_h VARCHAR2(150);
			v_ecache_in_mb_h NUMBER;
			v_impl_h VARCHAR2(150);
			v_num_cores_h NUMBER;
			v_fd_max_used_cpu_count_per number;
			v_fd_sga_max_size number;
			v_fd_pga_max_size number;
			p_username varchar2(50):= 'SYSMAN.';

    BEGIN
	
	p_query := 'select TARGET_NAME, TARGET_GUID, HOSTNAME, TARGET_TYPE, DBNAME from (
					select distinct t.TARGET_NAME,t.target_guid, t.HOST_NAME hostname,t.TARGET_TYPE,
					(select value from ' || p_username || 'mgmt$db_init_params_all  m  where m.target_guid = t.target_guid and m.name = ''db_name'') dbname,
					(select value from ' || p_username || 'mgmt$db_init_params_all  m  where m.target_guid = t.target_guid and m.name = ''db_unique_name'') dbuniq
					from    ' || p_username || 'mgmt$target  t 
					where t.TARGET_TYPE = ''oracle_database'') where dbname is not null and dbuniq is not null';

/* in a multi-row query*/
            OPEN c FOR p_query;  LOOP
                FETCH c INTO v_target_name, v_target_guid, v_host_name, v_TARGET_TYPE, v_dbname;
            EXIT WHEN c%notfound;

begin

--1. Check DB is RAC or not
                p_subquery := 'select t.type_qualifier3  from  ' || p_username || 'mgmt$target   t where t.target_guid=:target_guid and type_qualifier3 = ''RACINST''';

                begin
                    EXECUTE IMMEDIATE p_subquery
                    INTO v_db_or_racinst
                        USING v_target_guid;
                exception when others then
                    v_db_or_racinst := 'SI';
                end;

                v_max_used_cpu_count:=0;
                v_sga_max_size := 0;
				v_pga_max_size := 0;
                v_dbsize_gb:=0;
				v_iops:=0;
				v_fd_v_iops:=0;

--1.1. If DB is RAC instance
                IF ( v_db_or_racinst = 'RACINST' ) THEN
--1.1.1 Search for
                    p_subquery := 'select tm.aggregate_target_name, tm.aggregate_target_guid
                                        from   ' || p_username || 'mgmt$target_members   tm
                                        where tm.member_target_name = :target_name
                                        and tm.member_target_type=''oracle_database''
                                        and tm.aggregate_target_type = ''rac_database''';

                    begin
                        EXECUTE IMMEDIATE p_subquery INTO v_rac_target_name, v_rac_target_guid USING v_target_name;
                    exception when others then
                        v_rac_target_name:=null; v_rac_target_guid:=null;
                    end;

                    v_arch_daily_gb := 0;
                    v_rac_nodes_num := 0;
                    v_max_used_cpu_count_per:=0;
                    v_fd_max_used_cpu_count_per:=0;
                    v_fd_sga_max_size:=0;
					v_fd_pga_max_size:=0;

-----DB SIZE
					if nvl(v_dbsize_gb,0) = 0 then
						p_subquery := 'select ceil(sum(tablespace_size)/1024/1024/1024)
									   from   ' || p_username || 'mgmt$db_tablespaces 
									   where target_guid = :target_guid';

						EXECUTE IMMEDIATE p_subquery INTO v_dbsize_gb USING v_rac_target_guid;
					end if;

                    p_subquery := 'select distinct tm.member_target_guid
                                        from ' || p_username || 'mgmt$target_members  tm
                                    where tm.aggregate_target_guid = ''' || v_rac_target_guid || '''
                                        and tm.member_target_type=''oracle_database''
                                        and tm.aggregate_target_type = ''rac_database''';

-- Find redosize_ps for Archive and Total Node REDO SIZE = 3104DB0E5DCF1E5C8C4747CEB319A4E2
                    OPEN c1 FOR p_subquery; LOOP
                        FETCH c1 INTO v_member_target_guid;
                    EXIT WHEN c1%notfound;

                        p_subquery := ' select nvl(ceil(AVG(average * 3600 * 24 /1024/1024/1024)),0)
                                          from   ' || p_username || 'mgmt$metric_daily 
                                          where target_guid = :member_target_guid
                                          and metric_guid = HEXTORAW(''3104DB0E5DCF1E5C8C4747CEB319A4E2'')';

                        EXECUTE IMMEDIATE p_subquery
                        INTO v_num
                            USING v_member_target_guid;
                        v_arch_daily_gb := v_arch_daily_gb + v_num;
                        v_rac_nodes_num := v_rac_nodes_num + 1;

        /*-CPU COUNT---RAC*/
                        p_subquery := 'select ceil(min(maximum)) from (  select maximum from  ' || p_username || 'mgmt$metric_daily 
											where target_guid= :p_rac_target_guid
											and metric_guid = HEXTORAW(''AB9CAF80590230CCA321554A36A83E56'') 
											order by maximum desc )
											where   rownum <=5 ';

                        EXECUTE IMMEDIATE p_subquery INTO v_fd_max_used_cpu_count_per USING v_member_target_guid;
                        if v_fd_max_used_cpu_count_per > v_max_used_cpu_count_per then
                            v_max_used_cpu_count_per:=v_fd_max_used_cpu_count_per;
                        end if;
        /*SGA MAX---RAC*/
                          p_subquery := ' select ceil(min(maximum/1024)) from (select m.maximum 
                                     from  ' || p_username || 'mgmt$metric_daily    m
                                     where m.target_guid = :p_member_target_guid
                                     and m.target_type = ''oracle_database''
                                     and m.metric_guid = HEXTORAW(''0DD82DEF4D7B007FB0D5492E417A7C26'') order by maximum desc )
                                     where   rownum <=5 ';

                        EXECUTE IMMEDIATE p_subquery INTO v_fd_sga_max_size USING v_member_target_guid;

                        if  v_fd_sga_max_size > v_sga_max_size then
                             v_sga_max_size:=v_fd_sga_max_size;
                        end if;
						

		/*PGA MAX---RAC*/
                          p_subquery := ' select ceil(max(m.maximum)/1024)
                                     from   ' || p_username || 'mgmt$metric_daily    m
                                     where m.target_guid = :p_member_target_guid
                                     and m.target_type = ''oracle_database''
                                     and m.metric_guid = HEXTORAW(''4BBDD79DF1EB13CC8D9B991E8D2885F8'')';

                        EXECUTE IMMEDIATE p_subquery INTO v_fd_pga_max_size USING v_member_target_guid;

                        if  v_fd_pga_max_size > v_pga_max_size then
                             v_pga_max_size:=v_fd_pga_max_size;
                        end if;

						
---iops----HEXTORAW('247ED26590C1FBA8D5839A42591F0817')  Throughput, Physical Writes (per second)----- 
                        p_subquery := 'SELECT ceil(max(NVL(a.maximum,0))) AS maximumIO
                                             FROM    ' || p_username || 'mgmt$metric_daily   a
                                             WHERE   a.target_guid = :target_guid 
                                                 and a.target_type = ''oracle_database''
                                                 AND a.metric_guid  = HEXTORAW(''247ED26590C1FBA8D5839A42591F0817'')';

                        EXECUTE IMMEDIATE p_subquery INTO v_fd_v_iops USING v_member_target_guid;

                        if  v_fd_v_iops > v_iops then 
                             v_iops:=v_fd_v_iops;
                        end if;
---iops---------------------------------------------------------------------------------------------------

                    END LOOP;
                    CLOSE c1;

/* Not RAC*/
            ELSE
                    v_rac_nodes_num := 1;
-------REDO SIZE = 3104DB0E5DCF1E5C8C4747CEB319A4E2---------------------------
                    p_subquery := 'select nvl(ceil(AVG(average * 3600 * 24 /1024/1024/1024)),0)
                                   from   ' || p_username || 'mgmt$metric_daily 
                                   where target_guid = :target_guid
                                    and metric_guid = HEXTORAW(''3104DB0E5DCF1E5C8C4747CEB319A4E2'')';

                    EXECUTE IMMEDIATE p_subquery INTO v_arch_daily_gb USING v_target_guid;

------CPU COUNT HEXTORAW('AB9CAF80590230CCA321554A36A83E56') -- CPU Usage, Average Total CPU Usage Per Second (CentiSecond Per Second)
                    p_subquery := 'select ceil(min(maximum))  from (select m.maximum from   ' || p_username || 'mgmt$metric_daily    m
                                    where m.target_guid = :target_guid
                                        and m.target_type =''oracle_database''
										and m.metric_guid = HEXTORAW(''AB9CAF80590230CCA321554A36A83E56'')
                                        order by maximum desc )
												where rownum<=5';

                    EXECUTE IMMEDIATE p_subquery INTO v_max_used_cpu_count_per USING v_target_guid;

-----SGA MAX  -- HEXTORAW('0DD82DEF4D7B007FB0D5492E417A7C26') -- SGA and PGA usage, SGA Size(MB) 
                      p_subquery := '  select ceil(min(maximum/1024)) max_db_sga_size
                                      from (select m.maximum 
									from   ' || p_username || 'mgmt$metric_daily   m
                                     where m.target_guid = :target_guid
                                        and m.target_type =''oracle_database''
										and m.metric_guid = HEXTORAW(''0DD82DEF4D7B007FB0D5492E417A7C26'') order by maximum desc )
                                        where rownum<=5';


                    EXECUTE IMMEDIATE p_subquery INTO v_sga_max_size USING v_target_guid;
					
-----PGA MAX  -- HEXTORAW('4BBDD79DF1EB13CC8D9B991E8D2885F8') -- SGA and PGA usage, PGA Size(MB) 
                      p_subquery := ' select ceil(max(m.maximum)/1024)
									from   ' || p_username || 'mgmt$metric_daily   m
                                     where m.target_guid = :target_guid
                                        and m.target_type =''oracle_database''
										and m.metric_guid = HEXTORAW(''4BBDD79DF1EB13CC8D9B991E8D2885F8'')';

                    EXECUTE IMMEDIATE p_subquery INTO v_pga_max_size USING v_target_guid;		
					
---iops----HEXTORAW('247ED26590C1FBA8D5839A42591F0817')  Throughput, Physical Writes (per second)------------------ 
                        p_subquery := 'SELECT ceil(max(NVL(a.maximum,0))) AS maximumIO
                                             FROM    ' || p_username || 'mgmt$metric_daily   a
                                             WHERE   a.target_guid = :target_guid 
                                                 and a.target_type = ''oracle_database''
												 AND a.metric_guid  = HEXTORAW(''247ED26590C1FBA8D5839A42591F0817'') ';

                        EXECUTE IMMEDIATE p_subquery INTO v_iops USING v_target_guid;

---iops---------------------------------------------------------
					
                END IF;  /* END RAC */

                if nvl(v_dbsize_gb,0) = 0 then
                    p_subquery := 'select ceil(sum(tablespace_size)/1024/1024/1024)
                                   from   ' || p_username || 'mgmt$db_tablespaces 
								   where target_guid = :target_guid';

                    EXECUTE IMMEDIATE p_subquery INTO v_dbsize_gb USING v_target_guid;
                end if;

                p_subquery := 'select i.characterset nls_characterset, 
									  i.national_characterset nls_nchar_characterset, 
									  i.dbversion version, i.open_mode, dg.protection_mode
                                from   ' || p_username || 'mgmt$db_dbninstanceinfo i, ' || p_username || 'mgmt$ha_dg_target_summary  dg
                                where i.target_guid = decode(:db_or_racinst, ''RACINST'', :rac_target_guid, :target_guid)
                                    AND dg.target_guid (+) = i.target_guid';

                begin
                    EXECUTE IMMEDIATE p_subquery
                    INTO  v_nls_charset, v_nchar_charset, v_version, v_open_mode, v_protection_mode
                    USING v_db_or_racinst, v_rac_target_guid, v_target_guid;
                exception when others then
                     v_nls_charset:= null; v_nchar_charset:= null; v_version:= null; v_open_mode:= null; v_protection_mode := null;
                end;

                        v_cpu_count_i:=null;
                        v_pga_aggregate_limit_i:=null;
                        v_pga_aggregate_target_i:=null;
                        v_processes_i:=null;
                        v_sessions_i:=null;
                        v_sga_max_size_i:=null;
                        v_sga_target_i:=null;
                        v_use_large_pages_i:=null;
                        v_db_block_size_i:=null;
                        v_log_archive_config_i:=null;
                        v_memory_target_i:=null;
                        v_instance_name_i:=null;
                        v_undo_retention_i:=null;
                        v_db_unique_name_i:=null;
                        v_db_name_i:=null;

                p_subquery := ' select name, value from
                                 ' || p_username || 'mgmt$db_init_params_all where target_guid = ''' || v_target_guid || '''
                                and name in (''cpu_count''
                                                ,''pga_aggregate_limit''
                                                ,''pga_aggregate_target''
                                                ,''processes''
                                                ,''sessions''
                                                ,''sga_max_size''
                                                ,''sga_target''
                                                ,''use_large_pages''
                                                ,''db_block_size''
                                                ,''log_archive_config''
                                                ,''memory_target''
                                                ,''instance_name''
                                                ,''undo_retention''
                                                ,''db_unique_name''
                                                ,''db_name'')';
                OPEN c1 FOR p_subquery;

						LOOP
							FETCH c1 INTO
								v_name,
								v_value;
							EXIT WHEN c1%NOTFOUND;
							if v_name = 'cpu_count' then
								v_cpu_count_i:=to_number(v_VALUE);
							elsif v_name = 'pga_aggregate_limit' then
								v_pga_aggregate_limit_i:=round(to_number(v_VALUE)/1024/1024/1024);
							elsif v_name = 'pga_aggregate_target' then
								v_pga_aggregate_target_i:=round(to_number(v_VALUE)/1024/1024/1024);
							elsif v_name = 'processes' then
								v_processes_i:=to_number(v_VALUE);
							elsif v_name = 'sessions' then
								v_sessions_i:=to_number(v_VALUE);
							elsif v_name = 'sga_max_size' then
								v_sga_max_size_i:=round(to_number(v_VALUE)/1024/1024/1024);
							elsif v_name = 'sga_target' then
								v_sga_target_i:=round(to_number(v_VALUE)/1024/1024/1024);
							elsif v_name = 'use_large_pages' then
								v_use_large_pages_i:=v_VALUE;
							elsif v_name = 'db_block_size' then
								v_db_block_size_i:=round(to_number(v_VALUE)/1024);
							elsif v_name = 'log_archive_config' then
								v_log_archive_config_i:=v_VALUE;
							elsif v_name = 'memory_target' then
								v_memory_target_i:=v_VALUE;
							elsif v_name = 'instance_name' then
								v_instance_name_i:=v_VALUE;
							elsif v_name = 'undo_retention' then
								v_undo_retention_i:=v_VALUE;
							elsif v_name = 'db_unique_name' then
								v_db_unique_name_i:=v_VALUE;
							elsif v_name = 'db_name' then
								v_db_name_i:=v_VALUE;
							end if;
						END LOOP;

                CLOSE c1;

                v_dbid := 0;
                p_subquery := '  select s.dbid, s.log_mode, s.database_role, s.force_logging, s.flashback_on from  ' || p_username || 'mgmt$ha_info  s where target_guid =:target_guid';
                begin
                    EXECUTE IMMEDIATE p_subquery INTO v_dbid, v_log_mode, v_database_role, v_force_logging, v_flashback_on USING v_target_guid;
                exception when others then
                        v_dbid:=null; v_log_mode:=null; v_database_role:=null; v_force_logging:=null;v_flashback_on:=null;
                end;

          /*HOSTS DETAIL*/

                p_subquery := 'SELECT mas.target_name,  replace(lower(mas.target_name),''.''||lower(hw1.DOMAIN)) host_name ,hw1.SYSTEM_CONFIG
                                        ,round(hw1.MEM/1024) ,hw1.DISK ,hw1.CPU_COUNT ,hw1.OS_SUMMARY ,hw1.PHYSICAL_CPU_COUNT ,
                                        hw1.LOGICAL_CPU_COUNT ,hw1.DOMAIN ,mas.vendor_name
                                        ,mas.freq_in_mhz ,mas.ecache_in_mb ,mas.impl ,mas.num_cores
                        FROM (SELECT RAWTOHEX(hw.target_guid) AS target_guid
                                    ,hw.target_name
                                    ,vendor_name
                                    ,freq_in_mhz
                                    ,ecache_in_mb
                                    ,impl
                                    ,revision
                                    ,num_cores
                                    ,is_hyperthread_enabled
                                    ,siblings
                                    ,ROW_NUMBER() OVER(PARTITION BY hw.target_guid ORDER BY hw.last_collection_timestamp DESC, hw.freq_in_mhz DESC) AS rn
                                    FROM   ' || p_username || 'mgmt$target           t
                                    ,' || p_username || 'mgmt$hw_cpu_details    hw
                                WHERE  hw.target_guid IN (
                                          select TARGET_GUID from ' || p_username || 'mgmt$target  where TARGET_TYPE = ''host''
										  and target_name = :p_target_name
                                         )) mas
                                         ,' || p_username || 'mgmt$os_hw_summary   hw1
                                WHERE rn = 1 and mas.target_guid = hw1.target_guid and mas.target_name = :p_target_name ';

                begin

                    EXECUTE IMMEDIATE p_subquery
                    INTO
                            V_HOST_NAME_O_H,
                            V_HOST_NAME_H,
                            V_SYSTEM_CONFIG_H,
                            V_RAM_SIZE_GB_H,
                            V_DISK_H,
                            V_CPU_COUNT_H,
                            V_OS_SUMMARY_H,
                            V_PHYSICAL_CPU_COUNT_H,
                            V_LOGICAL_CPU_COUNT_H,
                            V_DOMAIN_H,
                            V_VENDOR_NAME_H,
                            V_FREQ_IN_MHZ_H,
                            V_ECACHE_IN_MB_H,
                            V_IMPL_H,
                            V_NUM_CORES_H USING v_host_name,v_host_name;

                exception when others then
                    V_HOST_NAME_O_H:=null; V_HOST_NAME_H:=null; V_SYSTEM_CONFIG_H:=null; V_RAM_SIZE_GB_H:=null;
                    V_DISK_H:=null; V_CPU_COUNT_H:=null; V_OS_SUMMARY_H:=null; V_PHYSICAL_CPU_COUNT_H:=null;
                    V_LOGICAL_CPU_COUNT_H:=null; V_DOMAIN_H:=null; V_VENDOR_NAME_H:=null; V_FREQ_IN_MHZ_H:=null;
                    V_ECACHE_IN_MB_H:=null; V_IMPL_H:=null; V_NUM_CORES_H:=null;
                end;

                v_max_used_cpu_count:=nvl(round(v_max_used_cpu_count_per/100,2),0);
				v_sga_max_size:= nvl(v_sga_max_size,0);
                
                if instr(v_host_name,'.')> 0 then
                    select  decode(to_char(LENGTH(TRIM(TRANSLATE(v_host_name, ' .0123456789',' ')))),null, v_host_name, substr(v_host_name, 1, instr(v_host_name, '.') -1)) into v_host_name from dual;
                end if;
				
               delete from extract_oem_data where lower(cndb_name) = lower(v_dbname) and lower(HOSTNAME) = lower(v_host_name);

                INSERT INTO extract_oem_data (
                        	cndb_name,
							HOSTNAME,
                            host_domain,
                            instance_name,
                            db_unique_name,
                            dbid,
                            cpu_count,
							LOADED_CPU_COUNT,
                            max_used_cpu_count,
                            sga_gb,
                            sga_max_size,
							pga_max_size,
                            db_size_gb,
                            rac_nodes_num,
                            ram_size_gb,
                            nls_characterset,
                            nchar_characterset,
                            db_block_size,
                            version,
                            undo_retention,
                            log_archive_config,
                            log_mode,
                            flashback_on,
                            force_logging,
                            protection_mode,
                            database_role,
                            open_mode,
                            cpu_detail_name,
                            os,
                            arch_daily_gb,
                            platform_name,
                            target_name,
                            target_type,
                            db_name_i,
                            memory_target_i,
                            pga_aggregate_limit_i,
                            pga_aggregate_target_i,
                            processes_i,
                            sessions_i,
                            sga_max_size_i,
                            use_large_pages_i,
                            host_name_o_h,
                            system_config_h,
                            disk_h,
                            cpu_count_h,
                            physical_cpu_count_h,
                            logical_cpu_count_h,
                            freq_in_mhz_h,
                            ecache_in_mb_h,
                            num_cores_h,
                            max_used_cpu_count_per,
							iops
                        ) VALUES (
							lower(v_dbname),
							lower(v_host_name),
                            v_domain_h,
                            v_instance_name_i,
                            v_db_unique_name_i,
                            v_dbid,
                            v_cpu_count_i,
							decode (v_max_used_cpu_count,0,v_cpu_count_i,v_max_used_cpu_count),
							v_max_used_cpu_count,
                            decode(v_sga_max_size,0,v_sga_target_i,v_sga_max_size),
                            v_sga_max_size,
							v_pga_max_size,
                            v_dbsize_gb,
                            v_rac_nodes_num,
                            v_ram_size_gb_h,
                            v_nls_charset,
                            v_nchar_charset,
                            v_db_block_size_i,
                            v_version,
                            v_undo_retention_i,
                            v_log_archive_config_i,
                            v_log_mode,
                            v_flashback_on,
                            v_force_logging,
                            v_protection_mode,
                            v_database_role,
                            v_open_mode,
                            v_impl_h,
                            v_os_summary_h,
                            v_arch_daily_gb,
                            v_vendor_name_h,
                            v_target_name,
                            v_target_type,
                            v_db_name_i,
                            v_memory_target_i,
                            v_pga_aggregate_limit_i,
                            v_pga_aggregate_target_i,
                            v_processes_i,
                            v_sessions_i,
                            v_sga_max_size_i,
                            v_use_large_pages_i,
                            v_host_name_o_h,
                            v_system_config_h,
                            v_disk_h,
                            v_cpu_count_h,
                            v_physical_cpu_count_h,
                            v_logical_cpu_count_h,
                            v_freq_in_mhz_h,
                            v_ecache_in_mb_h,
                            v_num_cores_h,
                            v_max_used_cpu_count_per,
							v_iops
                        );

                COMMIT;
				
				
exception when others then
	null;
end;

            END LOOP;

            CLOSE c;
    commit;
 
    END sp_oem_extract;

 PROCEDURE sp_oem_extract_PDB AS

                p_query VARCHAR2(3000) := '';
                p_subquery VARCHAR2(3000) := '';
                v_member_target_guid VARCHAR2(150) := '';
                v_name VARCHAR2(150) := '';
                v_value VARCHAR2(150) := '';
                v_target_name VARCHAR2(150);
                v_target_guid VARCHAR2(150);
                v_host_name VARCHAR2(150);
                v_rac_target_guid VARCHAR2(150);
                v_arch_daily_gb NUMBER;
                v_rac_nodes_num NUMBER;
                v_sga_max_size NUMBER;
				v_pga_max_size NUMBER;
                v_db_or_racinst VARCHAR2(150);
                v_dbsize_gb NUMBER;
                v_num NUMBER;
				v_iops number;
				v_fd_v_iops number;
                v_max_used_cpu_count NUMBER;
                v_max_used_cpu_count_per NUMBER;
                v_nls_charset VARCHAR2(150);
                v_dbid VARCHAR2(150);
                v_nchar_charset VARCHAR2(150);
                v_log_mode VARCHAR2(150);
                v_version VARCHAR2(150);
                v_open_mode VARCHAR2(150);
                v_protection_mode VARCHAR2(150);
                v_database_role VARCHAR2(150);
                v_force_logging VARCHAR2(150);
                v_flashback_on VARCHAR2(150);
				v_pdb_name varchar2(150);
                
          TYPE ref_cur IS REF CURSOR;
                c ref_cur;
                c1 ref_cur;
                c2 ref_cur;
                v_target_type VARCHAR2(150);
                v_cpu_count_i NUMBER;
                v_pga_aggregate_limit_i NUMBER;
                v_pga_aggregate_target_i NUMBER;
                v_processes_i NUMBER;
                v_sessions_i NUMBER;
                v_sga_max_size_i NUMBER;
                v_sga_target_i NUMBER;
                v_use_large_pages_i VARCHAR2(150);
                v_db_block_size_i NUMBER;
                v_log_archive_config_i VARCHAR2(150);
                v_memory_target_i NUMBER;
                v_instance_name_i VARCHAR2(150);
                v_undo_retention_i VARCHAR2(150);
                v_db_unique_name_i VARCHAR2(150);
                v_db_name_i VARCHAR2(150);
                v_host_name_o_h VARCHAR2(150);
                v_host_name_h VARCHAR2(150);
                v_system_config_h VARCHAR2(150);
                v_ram_size_gb_h NUMBER;
                v_disk_h NUMBER;
                v_cpu_count_h NUMBER;
                v_os_summary_h VARCHAR2(150);
                v_physical_cpu_count_h NUMBER;
                v_logical_cpu_count_h NUMBER;
                v_domain_h VARCHAR2(150);
                v_vendor_name_h VARCHAR2(150);
                v_freq_in_mhz_h VARCHAR2(150);
                v_ecache_in_mb_h NUMBER;
                v_impl_h VARCHAR2(150);
                v_num_cores_h NUMBER;
                v_fd_max_used_cpu_count_per number;
                v_fd_sga_max_size number;
				v_fd_pga_max_size number;
                p_username varchar2(50):= 'SYSMAN.';
				p_p_name varchar2(150);

    BEGIN

            p_query := 'select TARGET_NAME, TARGET_GUID, HOSTNAME, TARGET_TYPE from (
					select distinct t.TARGET_NAME,t.target_guid, t.HOST_NAME hostname,t.TARGET_TYPE
                    from    ' || p_username || 'mgmt$target  t 
					where t.TARGET_TYPE = ''oracle_pdb'')';

            OPEN c FOR p_query ;  LOOP
                FETCH c INTO v_target_name, v_target_guid,  v_host_name, v_TARGET_TYPE;
                EXIT WHEN c%notfound;

		begin

			select trim(lower(REGEXP_SUBSTR(V_TARGET_NAME, '[^_]+$'))) INTO p_p_name from dual;
 
				 if p_p_name in ('cdb$root', 'cdbroot') or p_p_name like '%cdbroot%' then
						continue;
				 end if;

                p_subquery := '  select AGGREGATE_TARGET_GUID
                        from ' || p_username || 'mgmt$target_members 
                        where member_TARGET_GUID =:v_target_guid
                        and MEMBER_TARGET_TYPE = ''oracle_pdb''
                        and AGGREGATE_TARGET_TYPE in (''oracle_database'', ''rac_database'')' ;

                begin
                    EXECUTE IMMEDIATE p_subquery
                    INTO v_rac_target_guid
                        USING v_target_guid;
                exception when others then
                    v_rac_target_guid := null;
                end;

                    p_subquery := ' select count(1) from  ' || p_username || 'mgmt$target  where type_qualifier3 = ''RACINST'' and target_guid in (
                                        select MEMBER_TARGET_GUID from  ' || p_username || 'mgmt$target_members 
                                        where  member_target_type =''oracle_database''
                                            and AGGREGATE_TARGET_TYPE = ''rac_database''
                                            and AGGREGATE_TARGET_GUID=
                                        (select AGGREGATE_TARGET_GUID from  ' || p_username || 'mgmt$target_members 
                                         where member_TARGET_GUID = :target_guid
                                            and MEMBER_TARGET_TYPE = ''oracle_pdb''
                                            and AGGREGATE_TARGET_TYPE = ''rac_database'' ))';

                --v3.3 Change Single instance or RAC
                begin
                    EXECUTE IMMEDIATE p_subquery INTO v_db_or_racinst USING v_target_guid;
                exception when others then
                    v_db_or_racinst := 'SI';
                end;

				v_arch_daily_gb :=0;
				v_rac_nodes_num :=0;
				v_max_used_cpu_count:=0;
				v_fd_max_used_cpu_count_per:=0;
				v_fd_sga_max_size:=0;
				v_fd_pga_max_size :=0;
				v_cpu_count_i:=null;
				v_pga_aggregate_limit_i:=null;
				v_pga_aggregate_target_i:=null;
				v_processes_i:=null;
				v_sessions_i:=null;
				v_sga_max_size_i:=null;
				v_sga_target_i:=null;
				v_use_large_pages_i:=null;
				v_db_block_size_i:=null;
				v_log_archive_config_i:=null;
				v_memory_target_i:=null;
				v_instance_name_i:=null;
				v_undo_retention_i:=null;
				v_db_unique_name_i:=null;
				v_db_name_i:=null;
				v_max_used_cpu_count_per:=0;
				v_iops:=0;
				v_fd_v_iops:=0;
				v_dbsize_gb:=0;
				v_sga_max_size := 0;
				v_pga_max_size := 0;
				
                IF ( v_db_or_racinst != '0' ) THEN
                        v_db_or_racinst:= 'RACINST';

					

					if nvl(v_dbsize_gb,0) =0 then
					
						p_subquery := 'select ceil(sum(tablespace_size)/1024/1024/1024) from ' || p_username || 'mgmt$db_tablespaces where target_guid = :target_guid';
						
						EXECUTE IMMEDIATE p_subquery INTO v_dbsize_gb USING v_rac_target_guid;
					
					end if;
				
					p_subquery := ' select target_guid from  ' || p_username || 'mgmt$target  where type_qualifier3 = ''RACINST'' and target_guid in (
                                            select MEMBER_TARGET_GUID from  ' || p_username || 'mgmt$target_members 
                                            where  member_target_type =''oracle_database''
                                                and AGGREGATE_TARGET_TYPE = ''rac_database''
                                                and AGGREGATE_TARGET_GUID=
                                            (select AGGREGATE_TARGET_GUID from  ' || p_username || 'mgmt$target_members 
                                            where member_TARGET_GUID = :target_guid
                                                and MEMBER_TARGET_TYPE = ''oracle_pdb''
                                                and AGGREGATE_TARGET_TYPE = ''rac_database'' ))';

--------SUB CONTAINER MAIN QUERY
                    OPEN c1 FOR p_subquery using v_target_guid;   LOOP
                    FETCH c1 INTO v_member_target_guid;
                    EXIT WHEN c1%notfound;
                        p_subquery := '  select nvl(ceil(AVG(average * 3600 * 24 /1024/1024/1024)),0)
                                          from    ' || p_username || 'mgmt$metric_daily 
                                          where target_guid = :member_target_guid
                                          and metric_guid = HEXTORAW(''3104DB0E5DCF1E5C8C4747CEB319A4E2'')';

                        EXECUTE IMMEDIATE p_subquery INTO v_num USING v_member_target_guid;
                        v_arch_daily_gb := v_arch_daily_gb + v_num;
                        v_rac_nodes_num := v_rac_nodes_num + 1;
 /*-CPU COUNT RAC*/
                    p_subquery := 'select ceil(min(maximum)) max_db_cpu_count
                                     from (select m.maximum 
                                 from   ' || p_username || 'mgmt$metric_daily   m
                                 where m.target_guid = :p_member_target_guid
                                     and m.target_type = ''oracle_database''
                                     and m.metric_guid = HEXTORAW(''AB9CAF80590230CCA321554A36A83E56'')
									 order by maximum desc )
                                        where rownum<=5';

                    EXECUTE IMMEDIATE p_subquery INTO v_fd_max_used_cpu_count_per USING v_member_target_guid;

                    if  v_fd_max_used_cpu_count_per > v_max_used_cpu_count_per then
                        v_max_used_cpu_count_per:=v_fd_max_used_cpu_count_per;

                    end if;

    /*SGA MAX RAC*/
                      p_subquery := '  select ceil(min(maximum/1024)) max_db_sga_size
                                     from (select m.maximum 
                                 from   ' || p_username || 'mgmt$metric_daily    m
                                 where m.target_guid = :p_member_target_guid
                                     and m.target_type = ''oracle_database''
                                     and m.metric_guid = HEXTORAW(''0DD82DEF4D7B007FB0D5492E417A7C26'')  order by maximum desc )
                                          where rownum<=5';

                    EXECUTE IMMEDIATE p_subquery INTO v_fd_sga_max_size USING v_member_target_guid;

                     if  v_fd_sga_max_size> v_sga_max_size then
                         v_sga_max_size:=v_fd_sga_max_size;
                     end if;

    /*PGA MAX RAC*/
                      p_subquery := ' select ceil(max(m.maximum/1024)) 
                                 from   ' || p_username || 'mgmt$metric_daily    m
                                 where m.target_guid = :p_member_target_guid
                                     and m.target_type = ''oracle_database''
                                     and m.metric_guid = HEXTORAW(''4BBDD79DF1EB13CC8D9B991E8D2885F8'')';

                    EXECUTE IMMEDIATE p_subquery INTO v_fd_pga_max_size USING v_member_target_guid;

                     if  v_fd_pga_max_size> v_pga_max_size then
                         v_pga_max_size:=v_fd_pga_max_size;
                     end if;

---iops--------------------------------------------------------- 
                        p_subquery := 'SELECT ceil(max(NVL(a.maximum,0))) AS maximumIO
                                               FROM    ' || p_username || 'mgmt$metric_daily   a
                                             WHERE   a.target_guid = :target_guid 
                                                 and a.target_type = ''oracle_database''
                                                 AND a.metric_guid  = HEXTORAW(''247ED26590C1FBA8D5839A42591F0817'')';

                        EXECUTE IMMEDIATE p_subquery INTO v_fd_v_iops USING v_member_target_guid;

                        if  v_fd_v_iops > v_iops then 
                             v_iops:=v_fd_v_iops;
                        end if;
---iops---------------------------------------------------------
				if v_db_unique_name_i is null then
                        p_subquery := ' select name, value from   ' || p_username || 'mgmt$db_init_params_all  where target_guid = ''' || v_member_target_guid || '''
                                                and name in (''cpu_count'' ,''pga_aggregate_limit''
                                                        ,''pga_aggregate_target'' ,''processes'' ,''sessions''
                                                        ,''sga_max_size'' ,''sga_target'' ,''use_large_pages''
                                                        ,''db_block_size'' ,''log_archive_config'' ,''memory_target''
                                                        ,''instance_name'' ,''undo_retention'' ,''db_unique_name'' ,''db_name'')';

                            OPEN c2 FOR p_subquery; LOOP
                                FETCH c2 INTO v_name, v_value;
                                EXIT WHEN c2%NOTFOUND;
                                    if v_name = 'cpu_count' then
                                        v_cpu_count_i:=to_number(v_VALUE);
                                    elsif v_name = 'pga_aggregate_limit' then
                                        v_pga_aggregate_limit_i:=round(to_number(v_VALUE)/1024/1024/1024);
                                    elsif v_name = 'pga_aggregate_target' then
                                        v_pga_aggregate_target_i:=round(to_number(v_VALUE)/1024/1024/1024);
                                    elsif v_name = 'processes' then
                                        v_processes_i:=to_number(v_VALUE);
                                    elsif v_name = 'sessions' then
                                        v_sessions_i:=to_number(v_VALUE);
                                    elsif v_name = 'sga_max_size' then
                                        v_sga_max_size_i:=round(to_number(v_VALUE)/1024/1024/1024);
                                    elsif v_name = 'sga_target' then
                                        v_sga_target_i:=round(to_number(v_VALUE)/1024/1024/1024);
                                    elsif v_name = 'use_large_pages' then
                                        v_use_large_pages_i:=v_VALUE;
                                    elsif v_name = 'db_block_size' then
                                        v_db_block_size_i:=round(to_number(v_VALUE)/1024);
                                    elsif v_name = 'log_archive_config' then
                                        v_log_archive_config_i:=v_VALUE;
                                    elsif v_name = 'memory_target' then
                                        v_memory_target_i:=v_VALUE;
                                    elsif v_name = 'instance_name' then
                                        v_instance_name_i:=v_VALUE;
                                    elsif v_name = 'undo_retention' then
                                        v_undo_retention_i:=v_VALUE;
                                    elsif v_name = 'db_unique_name' then
                                        v_db_unique_name_i:=v_VALUE;
                                    elsif v_name = 'db_name' then
                                        v_db_name_i:=v_VALUE;
                                    end if;
                            END LOOP;
                            CLOSE c2;
				end if;

                    END LOOP;
                   CLOSE c1;

             ELSE /* Not RAC*/
                    v_rac_nodes_num := 1;
                    p_subquery := 'select nvl(ceil(AVG(average * 3600 * 24 /1024/1024/1024)),0)
                                   from   ' || p_username || 'mgmt$metric_daily 
                                   where target_guid in (select tm.AGGREGATE_TARGET_GUID from   ' || p_username || 'mgmt$target_members   tm
                                        where tm.member_target_type=''oracle_pdb''
                                        and tm.AGGREGATE_TARGET_TYPE = ''oracle_database''
                                        and MEMBER_TARGET_GUID = :p_target_guid)
                                        and metric_guid = HEXTORAW(''3104DB0E5DCF1E5C8C4747CEB319A4E2'')';

                    EXECUTE IMMEDIATE p_subquery INTO v_arch_daily_gb USING v_target_guid;

    /*-CPU COUNT NO RAC*/
                    p_subquery := ' select ceil(min(maximum)) max_db_cpu_count
                                    from (select m.maximum 
                                    from   ' || p_username || 'mgmt$metric_daily    m
                                    where m.target_guid in (select tm.AGGREGATE_TARGET_GUID from   ' || p_username || 'mgmt$target_members   tm
                                        where tm.member_target_type=''oracle_pdb''
                                        and tm.AGGREGATE_TARGET_TYPE = ''oracle_database''
                                        and MEMBER_TARGET_GUID = :p_target_guid)
										and metric_guid = HEXTORAW(''AB9CAF80590230CCA321554A36A83E56'') order by maximum desc )
                                          where rownum<=5';

                    EXECUTE IMMEDIATE p_subquery INTO v_max_used_cpu_count_per USING v_target_guid;
    /*---SGA MAX NON RAC*/
                    p_subquery := '  select ceil(min(maximum/1024)) max_db_sga_size
                                     from (select m.maximum 
									 from   ' || p_username || 'mgmt$metric_daily   m
                                     where m.target_guid in (select tm.AGGREGATE_TARGET_GUID from   ' || p_username || 'mgmt$target_members   tm
                                        where tm.member_target_type=''oracle_pdb''
                                        and tm.AGGREGATE_TARGET_TYPE = ''oracle_database''
                                        and MEMBER_TARGET_GUID = :p_target_guid)
                                        and m.target_type =''oracle_database''
                                        and m.metric_guid = HEXTORAW(''0DD82DEF4D7B007FB0D5492E417A7C26'') order by maximum desc )
                                        where rownum<=5';

                    EXECUTE IMMEDIATE p_subquery INTO v_sga_max_size USING v_target_guid;
					

    /*---PGA MAX NON RAC*/
                    p_subquery := ' select ceil(max(m.maximum)/1024)
									 from   ' || p_username || 'mgmt$metric_daily   m
                                     where m.target_guid in (select tm.AGGREGATE_TARGET_GUID from   ' || p_username || 'mgmt$target_members   tm
                                        where tm.member_target_type=''oracle_pdb''
                                        and tm.AGGREGATE_TARGET_TYPE = ''oracle_database''
                                        and MEMBER_TARGET_GUID = :p_target_guid)
                                        and m.target_type =''oracle_database''
                                        and m.metric_guid = HEXTORAW(''4BBDD79DF1EB13CC8D9B991E8D2885F8'')';

                    EXECUTE IMMEDIATE p_subquery INTO v_pga_max_size USING v_target_guid;
					
---iops--------------------------------------------------------- 
                        p_subquery := 'SELECT ceil(max(NVL(a.maximum,0))) AS maximumIO
                                               FROM    ' || p_username || 'mgmt$metric_daily   a
                                             WHERE   a.target_guid = :target_guid 
                                                 and a.target_type = ''oracle_database''
                                                 AND a.metric_guid  = HEXTORAW(''247ED26590C1FBA8D5839A42591F0817'')';

                        EXECUTE IMMEDIATE p_subquery INTO v_iops USING nvl(v_rac_target_guid,v_target_guid);

---iops---------------------------------------------------------

if v_db_unique_name_i is null then
                    p_subquery := ' select name, value from  ' || p_username || 'mgmt$db_init_params_all where target_guid in (select tm.AGGREGATE_TARGET_GUID from   ' || p_username || 'mgmt$target_members   tm
                                        where tm.member_target_type=''oracle_pdb''
                                        and tm.AGGREGATE_TARGET_TYPE = ''oracle_database''
                                        and MEMBER_TARGET_GUID = :p_target_guid)
                                        and name in (''cpu_count''
                                                    ,''pga_aggregate_limit'' ,''pga_aggregate_target'',''processes''
                                                    ,''sessions'' ,''sga_max_size'' ,''sga_target'' ,''use_large_pages''
                                                    ,''db_block_size'' ,''log_archive_config'' ,''memory_target'' ,''instance_name''
                                                    ,''undo_retention'' ,''db_unique_name'' ,''db_name'')';

                    OPEN c1 FOR p_subquery using v_target_guid; LOOP
                    FETCH c1 INTO v_name, v_value ;
                    EXIT WHEN c1%NOTFOUND;
                        if v_name = 'cpu_count' then
                            v_cpu_count_i:=to_number(v_VALUE);
                        elsif v_name = 'pga_aggregate_limit' then
                            v_pga_aggregate_limit_i:=round(to_number(v_VALUE)/1024/1024/1024);
                        elsif v_name = 'pga_aggregate_target' then
                            v_pga_aggregate_target_i:=round(to_number(v_VALUE)/1024/1024/1024);
                        elsif v_name = 'processes' then
                            v_processes_i:=to_number(v_VALUE);
                        elsif v_name = 'sessions' then
                            v_sessions_i:=to_number(v_VALUE);
                        elsif v_name = 'sga_max_size' then
                            v_sga_max_size_i:=round(to_number(v_VALUE)/1024/1024/1024);
                        elsif v_name = 'sga_target' then
                            v_sga_target_i:=round(to_number(v_VALUE)/1024/1024/1024);
                        elsif v_name = 'use_large_pages' then
                            v_use_large_pages_i:=v_VALUE;
                        elsif v_name = 'db_block_size' then
                            v_db_block_size_i:=round(to_number(v_VALUE)/1024);
                        elsif v_name = 'log_archive_config' then
                            v_log_archive_config_i:=v_VALUE;
                        elsif v_name = 'memory_target' then
                            v_memory_target_i:=v_VALUE;
                        elsif v_name = 'instance_name' then
                            v_instance_name_i:=v_VALUE;
                        elsif v_name = 'undo_retention' then
                            v_undo_retention_i:=v_VALUE;
                        elsif v_name = 'db_unique_name' then
                            v_db_unique_name_i:=v_VALUE;
                        elsif v_name = 'db_name' then
                            v_db_name_i:=v_VALUE;
                        end if;
                    END LOOP;
                CLOSE c1;
end if;
            END IF;  /* RAC or Not RAC*/


----Table space DB size

				if nvl(v_dbsize_gb,0) =0 then
				
					p_subquery := 'select ceil(sum(tablespace_size)/1024/1024/1024) from ' || p_username || 'mgmt$db_tablespaces where target_guid = :target_guid';
					
					EXECUTE IMMEDIATE p_subquery INTO v_dbsize_gb USING v_target_guid;
				end if;

                p_subquery := ' select i.characterset nls_characterset,
                                       i.national_characterset nls_nchar_characterset,
                                       i.dbversion version,
                                       i.open_mode, dg.protection_mode
                                from    ' || p_username || 'mgmt$db_dbninstanceinfo   i,  ' || p_username || 'mgmt$ha_dg_target_summary dg
                                where i.target_guid = decode(:db_or_racinst, ''RACINST'', :rac_target_guid, :target_guid)
                                    AND dg.target_guid (+) = i.target_guid';

                begin
                        EXECUTE IMMEDIATE p_subquery
                        INTO v_nls_charset, v_nchar_charset, v_version, v_open_mode, v_protection_mode
                            USING v_db_or_racinst, v_rac_target_guid, v_target_guid;
                exception when others then
                    v_nls_charset:=null; v_nchar_charset:=null; v_version:=null; v_open_mode:=null; v_protection_mode:=null;
                end;

          /*dbid, log_mode, database_role, force_logging, flashback_on pull from OEM MAIN CNDB LEVEL*/

                v_dbid := 0;
                p_subquery := '  select s.dbid, s.log_mode, s.database_role, s.force_logging, s.flashback_on
                                       from  ' || p_username || 'mgmt$ha_info  s
                                       where target_guid  in (select tm.AGGREGATE_TARGET_GUID from ' || p_username || 'mgmt$target_members   tm
                                        where tm.member_target_type=''oracle_pdb''
                                        and tm.AGGREGATE_TARGET_TYPE in (''rac_database'', ''oracle_database'')
                                        and MEMBER_TARGET_GUID = :p_target_guid)';
                begin
                                EXECUTE IMMEDIATE p_subquery
                                INTO v_dbid, v_log_mode, v_database_role, v_force_logging, v_flashback_on USING v_target_guid;
                exception when others then
                         v_dbid:=null; v_log_mode:=null; v_database_role:=null; v_force_logging:=null; v_flashback_on:=null;
                end;

          /*HOSTS DETAIL*/

   p_subquery := 'SELECT mas.target_name,  replace(lower(mas.target_name),''.''||lower(hw1.DOMAIN)) host_name ,hw1.SYSTEM_CONFIG
                                        ,round(hw1.MEM/1024) ,hw1.DISK ,hw1.CPU_COUNT ,hw1.OS_SUMMARY ,hw1.PHYSICAL_CPU_COUNT ,
                                        hw1.LOGICAL_CPU_COUNT ,hw1.DOMAIN ,mas.vendor_name
                                        ,mas.freq_in_mhz ,mas.ecache_in_mb ,mas.impl ,mas.num_cores
                        FROM (SELECT RAWTOHEX(hw.target_guid) AS target_guid
                                    ,hw.target_name
                                    ,vendor_name
                                    ,freq_in_mhz
                                    ,ecache_in_mb
                                    ,impl
                                    ,revision
                                    ,num_cores
                                    ,is_hyperthread_enabled
                                    ,siblings
                                    ,ROW_NUMBER() OVER(PARTITION BY hw.target_guid ORDER BY hw.last_collection_timestamp DESC, hw.freq_in_mhz DESC) AS rn
                                    FROM   ' || p_username || 'mgmt$target  t
                                    ,' || p_username || 'mgmt$hw_cpu_details   hw
                                WHERE  hw.target_guid IN (
                                          select TARGET_GUID from ' || p_username || 'mgmt$target  where TARGET_TYPE = ''host''
										  and target_name = :p_target_name
                                         )) mas
                                         ,' || p_username || 'mgmt$os_hw_summary   hw1
                                WHERE rn = 1 and mas.target_guid = hw1.target_guid and mas.target_name = :p_target_name ';

                begin

                    EXECUTE IMMEDIATE p_subquery INTO
                        V_HOST_NAME_O_H, V_HOST_NAME_H, V_SYSTEM_CONFIG_H, V_RAM_SIZE_GB_H,
                        V_DISK_H, V_CPU_COUNT_H, V_OS_SUMMARY_H, V_PHYSICAL_CPU_COUNT_H,
                        V_LOGICAL_CPU_COUNT_H, V_DOMAIN_H, V_VENDOR_NAME_H, V_FREQ_IN_MHZ_H,
                        V_ECACHE_IN_MB_H, V_IMPL_H, V_NUM_CORES_H USING v_host_name, v_host_name;

                exception when others then
                    V_HOST_NAME_O_H:=null; V_HOST_NAME_H:=null; V_SYSTEM_CONFIG_H:=null; V_RAM_SIZE_GB_H:=null;
                    V_DISK_H:=null; V_CPU_COUNT_H:=null; V_OS_SUMMARY_H:=null; V_PHYSICAL_CPU_COUNT_H:=null;
                    V_LOGICAL_CPU_COUNT_H:=null; V_DOMAIN_H:=null; V_VENDOR_NAME_H:=null; V_FREQ_IN_MHZ_H:=null;
                    V_ECACHE_IN_MB_H:=null; V_IMPL_H:=null; V_NUM_CORES_H:=null;
                end;

                v_max_used_cpu_count:=round(v_max_used_cpu_count_per/100,2);
				v_sga_max_size:= nvl(v_sga_max_size,0);
				
				 
				select case when length(REGEXP_SUBSTR(V_TARGET_NAME, '[^_]+$')) <= 3 then 
                                                        lower(V_TARGET_NAME)
                                                    else
                                                        lower(trim(REGEXP_SUBSTR(V_TARGET_NAME, '[^_]+$')))
                                                    end case INTO v_pdb_name from dual ;
                
				if instr(v_host_name,'.')> 0 then
                    select  decode(to_char(LENGTH(TRIM(TRANSLATE(v_host_name, ' .0123456789',' ')))),null, v_host_name, substr(v_host_name, 1, instr(v_host_name, '.') -1)) into v_host_name from dual;
                end if;
				delete from extract_oem_data where lower(cndb_name) = lower(v_pdb_name) and lower(HOSTNAME) = lower(v_host_name);

                INSERT INTO extract_oem_data (
					cndb_name,
					HOSTNAME,
                    host_domain,
                    instance_name,
                    db_unique_name,
                    dbid,
                    cpu_count,
					LOADED_CPU_COUNT,
                    max_used_cpu_count,
                    sga_gb,
                    sga_max_size,
					pga_max_size,
                    db_size_gb,
                    rac_nodes_num,
                    ram_size_gb,
                    nls_characterset,
                    nchar_characterset,
                    db_block_size,
                    version,
                    undo_retention,
                    log_archive_config,
                    log_mode,
                    flashback_on,
                    force_logging,
                    protection_mode,
                    database_role,
                    open_mode,
                    cpu_detail_name,
                    os,
                    arch_daily_gb,
                    platform_name,
                    target_name,
                    target_type,
                    db_name_i,
                    memory_target_i,
                    pga_aggregate_limit_i,
                    pga_aggregate_target_i,
                    processes_i,
                    sessions_i,
                    sga_max_size_i,
                    use_large_pages_i,
                    host_name_o_h,
                    system_config_h,
                    disk_h,
                    cpu_count_h,
                    physical_cpu_count_h,
                    logical_cpu_count_h,
                    freq_in_mhz_h,
                    ecache_in_mb_h,
                    num_cores_h,
                    max_used_cpu_count_per,
					iops
                ) VALUES (
                    lower(v_pdb_name),
					lower(v_host_name),
					v_domain_h,
                    v_instance_name_i,
                    v_db_unique_name_i,
                    v_dbid,
                    v_cpu_count_i,
					decode (v_max_used_cpu_count,0,v_cpu_count_i,v_max_used_cpu_count),
					v_max_used_cpu_count,
                    decode(v_sga_max_size,0,v_sga_target_i,v_sga_max_size),
                    v_sga_max_size,
					v_pga_max_size,
                    v_dbsize_gb,
                    v_rac_nodes_num,
                    v_ram_size_gb_h,
                    v_nls_charset,
                    v_nchar_charset,
                    v_db_block_size_i,
                    v_version,
                    v_undo_retention_i,
                    v_log_archive_config_i,
                    v_log_mode,
                    v_flashback_on,
                    v_force_logging,
                    v_protection_mode,
                    v_database_role,
                    v_open_mode,
                    v_impl_h,
                    v_os_summary_h,
                    v_arch_daily_gb,
                    v_vendor_name_h,
                    v_target_name,
                    v_target_type,
                    lower(v_db_name_i),
                    v_memory_target_i,
                    v_pga_aggregate_limit_i,
                    v_pga_aggregate_target_i,
                    v_processes_i,
                    v_sessions_i,
                    v_sga_max_size_i,
                    v_use_large_pages_i,
                    v_host_name_o_h,
                    v_system_config_h,
                    v_disk_h,
                    v_cpu_count_h,
                    v_physical_cpu_count_h,
                    v_logical_cpu_count_h,
                    v_freq_in_mhz_h,
                    v_ecache_in_mb_h,
                    v_num_cores_h,
                    v_max_used_cpu_count_per,
					v_iops
                );
                COMMIT;
				
exception when others then
	null;
end;
				
            END LOOP;---Main Loop ENd
            CLOSE c;

  
    END sp_oem_extract_PDB;


BEGIN

        
    begin
	
	---------Clear Data if failed	
	delete from extract_oem_data;
	commit;
	
		sp_oem_extract;
		sp_oem_extract_pdb;
		delete from extract_oem_data where lower(cndb_name) in ('cdb$root', 'cdbroot');
		commit;

   ---to make same DBID
            for x in (SELECT dbid,
                        --  MAX(nvl(cpu_count, 0))                     cpu_count,
                        --  MAX(nvl(max_used_cpu_count, 0))            max_used_cpu_count,
                        --  MAX(nvl(sga_gb, 0))                        sga_gb,
                        --  MAX(nvl(sga_max_size, 0))                  sga_max_size,
						--	MAX(nvl(pga_max_size, 0))                  pga_max_size,
                            MAX(nvl(rac_nodes_num, 0))                 rac_nodes_num,
                            MAX(nvl(ram_size_gb, 0))                   ram_size_gb,
                            MAX(nvl(nls_characterset, ''))             nls_characterset,
                            MAX(nvl(nchar_characterset, ''))           nchar_characterset,
                            MAX(nvl(db_block_size, 0))                 db_block_size,
                            MAX(nvl(undo_retention, 0))                undo_retention,
                            MAX(nvl(arch_daily_gb, 0))                 arch_daily_gb,
                            MAX(nvl(pga_aggregate_limit_i, 0))         pga_aggregate_limit_i,
                            MAX(nvl(pga_aggregate_target_i, 0))        pga_aggregate_target_i,
                            MAX(nvl(processes_i, 0))                   processes_i,
                            MAX(nvl(sessions_i, 0))                    sessions_i,
                            MAX(nvl(sga_max_size_i, 0))                sga_max_size_i,
							MAX(nvl(iops, 0))  						   iops
                        FROM extract_oem_data where dbid is not null group by dbid) loop
                        
                                UPDATE extract_oem_data
                                SET
                            --      cpu_count = x.cpu_count,
                            --      max_used_cpu_count = x.max_used_cpu_count,
                            --      sga_gb = x.sga_gb,
                            --      sga_max_size = x.sga_max_size,
							--		pga_max_size = x.pga_max_size,
                                    rac_nodes_num = x.rac_nodes_num,
                                    ram_size_gb = x.ram_size_gb,
                                    nls_characterset = x.nls_characterset,
                                    nchar_characterset = x.nchar_characterset,
                                    db_block_size = x.db_block_size,
                                    undo_retention = x.undo_retention,
                                    arch_daily_gb = x.arch_daily_gb,
                                    pga_aggregate_limit_i = x.pga_aggregate_limit_i,
                                    pga_aggregate_target_i = x.pga_aggregate_target_i,
                                    processes_i = x.processes_i,
                                    sessions_i = x.sessions_i,
                                    sga_max_size_i = x.sga_max_size_i,
									iops=x.iops
                                WHERE
                                    dbid = x.dbid;
            
            commit;
			end loop;
            
			
			for x in ( select count(1) total_no_of_pdbs,
							DB_UNIQUE_NAME,
							HOSTNAME,
							TARGET_TYPE, 
							max(nvl(CPU_COUNT,0))/count(1) CPU_COUNT,
							max(nvl(MAX_USED_CPU_COUNT,0))/count(1) MAX_USED_CPU_COUNT,
							max(nvl(LOADED_CPU_COUNT,0))/count(1) LOADED_CPU_COUNT,
							max(nvl(SGA_GB,0))/count(1) SGA_GB,
							max(nvl(SGA_MAX_SIZE,0))/count(1) SGA_MAX_SIZE,
							max(nvl(PGA_MAX_SIZE,0))/count(1) PGA_MAX_SIZE
						from EXTRACT_OEM_DATA
						where TARGET_TYPE = 'oracle_pdb' 
						group by DB_UNIQUE_NAME,HOSTNAME,TARGET_TYPE ) loop

							update EXTRACT_OEM_DATA set 
								CPU_COUNT=round(x.CPU_COUNT,2), 
								MAX_USED_CPU_COUNT=round(x.MAX_USED_CPU_COUNT,2), 
								LOADED_CPU_COUNT=round(x.LOADED_CPU_COUNT,2), 
								SGA_GB=round(x.SGA_GB,2), 
								SGA_MAX_SIZE=round(x.SGA_MAX_SIZE,2),
								PGA_MAX_SIZE=round(x.PGA_MAX_SIZE,2)
							where HOSTNAME=x.HOSTNAME 
									and TARGET_TYPE=x.TARGET_TYPE
									and DB_UNIQUE_NAME = x.DB_UNIQUE_NAME;
			commit;
			end loop;
			

-----%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%			
if p_option = 3 then
		declare
			v_tot_dbs number;
			v_upd_dbs number;
		begin
			select count(1) into v_tot_dbs from extract_oem_data;
			for x in (SELECT trim(regexp_substr(p_dataCenterName, '[^,]+', 1, LEVEL)) p_val,
							   trim(regexp_substr(p_dataCenterPer, '[^,]+', 1, LEVEL)) p_val_per
						   FROM dual CONNECT BY LEVEL <= regexp_count(p_dataCenterName, ',')+1) loop
				   
				   v_upd_dbs:= round(ceil(v_tot_dbs*x.p_val_per/100));
				   update extract_oem_data set DATA_CENTER =x.p_val where rownum <=v_upd_dbs and DATA_CENTER is null;
			end loop;
			
			for x in (SELECT trim(regexp_substr(p_target_provider_name, '[^,]+', 1, LEVEL)) p_val,
							   trim(regexp_substr(p_totTagProvPer, '[^,]+', 1, LEVEL)) p_val_per
						   FROM dual CONNECT BY LEVEL <= regexp_count(p_target_provider_name, ',')+1) loop
				   
				   v_upd_dbs:= round(ceil(v_tot_dbs*x.p_val_per/100));
				   update extract_oem_data set TRG_PROVIDER =x.p_val where rownum <=v_upd_dbs and TRG_PROVIDER is null;
			end loop;
			
			for x in (SELECT trim(regexp_substr(p_EnvironmentName, '[^,]+', 1, LEVEL)) p_val,
							   trim(regexp_substr(p_Environmentpct, '[^,]+', 1, LEVEL)) p_val_per
						   FROM dual CONNECT BY LEVEL <= regexp_count(p_EnvironmentName, ',')+1) loop
				   
				   v_upd_dbs:= round(ceil(v_tot_dbs*x.p_val_per/100));
				   update extract_oem_data set ENVIRONMENT =x.p_val where rownum <=v_upd_dbs and ENVIRONMENT is null;
			end loop;
			
			for x in (SELECT trim(regexp_substr(p_securityzone_name, '[^,]+', 1, LEVEL)) p_val,
							   trim(regexp_substr(p_securityzone_pct, '[^,]+', 1, LEVEL)) p_val_per
						   FROM dual CONNECT BY LEVEL <= regexp_count(p_securityzone_name, ',')+1) loop
				   
				   v_upd_dbs:= round(ceil(v_tot_dbs*x.p_val_per/100));
				   update extract_oem_data set SECURITY_ZONE =x.p_val where rownum <=v_upd_dbs and SECURITY_ZONE is null;
			end loop;
			
			for x in (SELECT trim(regexp_substr(p_application_name, '[^,]+', 1, LEVEL)) p_val,
							   trim(regexp_substr(p_application_name_pct, '[^,]+', 1, LEVEL)) p_val_per
						   FROM dual CONNECT BY LEVEL <= regexp_count(p_application_name, ',')+1) loop
				   
				   v_upd_dbs:= round(ceil(v_tot_dbs*x.p_val_per/100));
				   update extract_oem_data set APP_NAME =x.p_val where rownum <=v_upd_dbs and APP_NAME is null;
			end loop;
			
			for x in (SELECT trim(regexp_substr(p_requestcutover_time, '[^,]+', 1, LEVEL)) p_val,
							   trim(regexp_substr(p_requestcutover_time_pct, '[^,]+', 1, LEVEL)) p_val_per
						   FROM dual CONNECT BY LEVEL <= regexp_count(p_requestcutover_time, ',')+1) loop
				   
				   v_upd_dbs:= round(ceil(v_tot_dbs*x.p_val_per/100));
				   update extract_oem_data set REQ_CUTOVER_TIME =x.p_val where rownum <=v_upd_dbs and REQ_CUTOVER_TIME is null;
			end loop;
		
			commit;
		end;
end if;
-----%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			
    exception when others then
          RAISE_APPLICATION_ERROR(-20001,SQLERRM || '-'||dbms_utility.format_error_backtrace);
		
    end;
end;

/


SET TERM OFF
set head off echo off trimspool on feedback off pagesize 0 verify off linesize 32000

spool 'file_Inventory_cdb.csv'

		select 'SRC_PROVIDER,TRG_PROVIDER,APP_OWNER_CONTACT_NAME,DBA_MANAGER_NAME,DBA_CONTACT_NAME,LINE_OF_BUSINESS,LOB_CONTACT_NAME,BUSINESS_GROUP,BU_CONTACT_NAME,NETWORK_MANAGER_CONTACT_NAME,STORAGE_ADMIN_CONTACT_NAME,DATA_CENTER,DB_PRODUCT,APP_NAME,APP_ID,DB_SERVICE_TIER,HOSTNAME,CONTAINER_NAME,CNDB_NAME,ENVIRONMENT,NLS_CHARACTERSET,SECURITY_ZONE,MAPPING,SCHEDULING,TRANSACTION_TYPE,REQ_CUTOVER_TIME,MIGRATION_PRIORITY,SGA_GB,DB_SIZE_GB,RAC_NODES_NUM,LOADED_CPU_COUNT,RPO,RTO,PHASE_NUMBER,TIME_ZONE,PGA_MAX_SIZE,OS' as  HEADER_NAME from dual;

		select '"'||SRC_PROVIDER||'","'||TRG_PROVIDER||'","'||APP_OWNER_CONTACT_NAME||'","'||DBA_MANAGER_NAME||'","'||DBA_CONTACT_NAME||'","'||LINE_OF_BUSINESS||'","'||LOB_CONTACT_NAME||'","'||BUSINESS_GROUP||'","'||BU_CONTACT_NAME||'","'||NETWORK_MANAGER_CONTACT_NAME||'","'||STORAGE_ADMIN_CONTACT_NAME||'","'||DATA_CENTER||'","'||DB_PRODUCT||'","'||APP_NAME||'","'||APP_ID||'","'||DB_SERVICE_TIER||'","'||HOSTNAME||'","'||CONTAINER_NAME||'","'||CNDB_NAME||'","'||ENVIRONMENT||'","'||NLS_CHARACTERSET||'","'||SECURITY_ZONE||'","'||MAPPING||'","'||SCHEDULING||'","'||TRANSACTION_TYPE||'","'||REQ_CUTOVER_TIME||'","'||MIGRATION_GROUP||'","'||SGA_GB||'","'||DB_SIZE_GB||'","'||RAC_NODES_NUM||'","'||LOADED_CPU_COUNT||'","'||RPO||'","'||RTO||'","'||PHASE_NUMBER||'","'||TIME_ZONE||'","'||PGA_MAX_SIZE||'","'||OS||'"' as data
		FROM (
			 select * from (select ROW_NUMBER() OVER (PARTITION BY DB_NAME_I ORDER BY DB_NAME_I desc) num1,
				SRC_PROVIDER,TRG_PROVIDER,APP_OWNER_CONTACT_NAME,DBA_MANAGER_NAME,DBA_CONTACT_NAME,LINE_OF_BUSINESS,LOB_CONTACT_NAME,BUSINESS_GROUP,BU_CONTACT_NAME,NETWORK_MANAGER_CONTACT_NAME,STORAGE_ADMIN_CONTACT_NAME,DATA_CENTER,DB_PRODUCT,APP_NAME,
				APP_ID,DB_SERVICE_TIER,HOSTNAME,null CONTAINER_NAME,
				CNDB_NAME,ENVIRONMENT,NLS_CHARACTERSET,SECURITY_ZONE,MAPPING,SCHEDULING,TRANSACTION_TYPE,
			REQ_CUTOVER_TIME,MIGRATION_GROUP,SGA_GB,DB_SIZE_GB,RAC_NODES_NUM,LOADED_CPU_COUNT,RPO,RTO,PHASE_NUMBER,'' TIME_ZONE,PGA_MAX_SIZE,OS
			FROM EXTRACT_OEM_DATA where TARGET_TYPE = 'oracle_database' order by DB_NAME_I,HOSTNAME) where num1=1
			);

spool off;

spool 'file_Inventory_pdb.csv'

		select 'SRC_PROVIDER,TRG_PROVIDER,APP_OWNER_CONTACT_NAME,DBA_MANAGER_NAME,DBA_CONTACT_NAME,LINE_OF_BUSINESS,LOB_CONTACT_NAME,BUSINESS_GROUP,BU_CONTACT_NAME,NETWORK_MANAGER_CONTACT_NAME,STORAGE_ADMIN_CONTACT_NAME,DATA_CENTER,DB_PRODUCT,APP_NAME,APP_ID,DB_SERVICE_TIER,HOSTNAME,CONTAINER_NAME,CNDB_NAME,ENVIRONMENT,NLS_CHARACTERSET,SECURITY_ZONE,MAPPING,SCHEDULING,TRANSACTION_TYPE,REQ_CUTOVER_TIME,MIGRATION_PRIORITY,SGA_GB,DB_SIZE_GB,RAC_NODES_NUM,LOADED_CPU_COUNT,RPO,RTO,PHASE_NUMBER,TIME_ZONE,PGA_MAX_SIZE,OS' as  HEADER_NAME from dual;

		select '"'||SRC_PROVIDER||'","'||TRG_PROVIDER||'","'||APP_OWNER_CONTACT_NAME||'","'||DBA_MANAGER_NAME||'","'||DBA_CONTACT_NAME||'","'||LINE_OF_BUSINESS||'","'||LOB_CONTACT_NAME||'","'||BUSINESS_GROUP||'","'||BU_CONTACT_NAME||'","'||NETWORK_MANAGER_CONTACT_NAME||'","'||STORAGE_ADMIN_CONTACT_NAME||'","'||DATA_CENTER||'","'||DB_PRODUCT||'","'||APP_NAME||'","'||APP_ID||'","'||DB_SERVICE_TIER||'","'||HOSTNAME||'","'||CONTAINER_NAME||'","'||CNDB_NAME||'","'||ENVIRONMENT||'","'||NLS_CHARACTERSET||'","'||SECURITY_ZONE||'","'||MAPPING||'","'||SCHEDULING||'","'||TRANSACTION_TYPE||'","'||REQ_CUTOVER_TIME||'","'||MIGRATION_GROUP||'","'||SGA_GB||'","'||DB_SIZE_GB||'","'||RAC_NODES_NUM||'","'||LOADED_CPU_COUNT||'","'||RPO||'","'||RTO||'","'||PHASE_NUMBER||'","'||TIME_ZONE||'","'||PGA_MAX_SIZE||'","'||OS||'"' as data
		FROM (
			 select
				SRC_PROVIDER,TRG_PROVIDER,APP_OWNER_CONTACT_NAME,DBA_MANAGER_NAME,DBA_CONTACT_NAME,LINE_OF_BUSINESS,LOB_CONTACT_NAME,
				BUSINESS_GROUP,BU_CONTACT_NAME,NETWORK_MANAGER_CONTACT_NAME,STORAGE_ADMIN_CONTACT_NAME,DATA_CENTER,DB_PRODUCT,APP_NAME,
				APP_ID,DB_SERVICE_TIER,HOSTNAME,decode(TARGET_TYPE,'oracle_pdb',DB_NAME_I,null) CONTAINER_NAME,
				CNDB_NAME,ENVIRONMENT,NLS_CHARACTERSET,SECURITY_ZONE,MAPPING,SCHEDULING,TRANSACTION_TYPE,
				REQ_CUTOVER_TIME,MIGRATION_GROUP,SGA_GB,DB_SIZE_GB,RAC_NODES_NUM,LOADED_CPU_COUNT,RPO,RTO,PHASE_NUMBER,'' TIME_ZONE,PGA_MAX_SIZE,OS
			FROM EXTRACT_OEM_DATA where TARGET_TYPE = 'oracle_pdb'
			);

spool off;

spool 'file_oem_Extract_42.csv'

		SELECT 'APP_ID,HOSTNAME,CONTAINER_NAME,CNDB_NAME,HOST_DOMAIN,INSTANCE_NAME,DB_UNIQUE_NAME,DBID,CPU_COUNT,MAX_USED_CPU_COUNT,SGA_GB,SGA_MAX_SIZE,DB_SIZE_GB,RAC_NODES_NUM,RAM_SIZE_GB,NLS_CHARACTERSET,NCHAR_CHARACTERSET,DB_BLOCK_SIZE,VERSION,UNDO_RETENTION,LOG_ARCHIVE_CONFIG,LOG_MODE,FLASHBACK_ON,FORCE_LOGGING,PROTECTION_MODE,DATABASE_ROLE,OPEN_MODE,CPU_DETAIL_NAME,OS,DB_SERVICE_TIER,ARCH_DAILY_GB,PLATFORM_NAME,TARGET_NAME,TARGET_TYPE,DB_NAME_I,MEMORY_TARGET_I,PGA_AGGREGATE_LIMIT_I,PGA_AGGREGATE_TARGET_I,PROCESSES_I,SESSIONS_I,SGA_MAX_SIZE_I,USE_LARGE_PAGES_I,HOST_NAME_O_H,SYSTEM_CONFIG_H,DISK_H,CPU_COUNT_H,PHYSICAL_CPU_COUNT_H,LOGICAL_CPU_COUNT_H,FREQ_IN_MHZ_H,ECACHE_IN_MB_H,NUM_CORES_H,MAX_USED_CPU_COUNT_PER,IOPS,PGA_MAX_SIZE' HEADER_NAME from dual;

		SELECT APP_ID||',"'||HOSTNAME||'","'||decode(TARGET_TYPE,'oracle_pdb',DB_NAME_I,null)||'","'||CNDB_NAME||'","'||HOST_DOMAIN||'","'||INSTANCE_NAME||'","'||DB_UNIQUE_NAME||'","'||DBID||'","'||CPU_COUNT||'","'||MAX_USED_CPU_COUNT||'","'||SGA_GB||'","'||
			SGA_MAX_SIZE||'","'||DB_SIZE_GB||'","'||RAC_NODES_NUM||'","'||RAM_SIZE_GB||'","'||NLS_CHARACTERSET||'","'||NCHAR_CHARACTERSET||'","'||DB_BLOCK_SIZE||'","'||VERSION||'","'||UNDO_RETENTION||'","'||LOG_ARCHIVE_CONFIG||'","'||LOG_MODE||'","'||
			FLASHBACK_ON||'","'||FORCE_LOGGING||'","'||PROTECTION_MODE||'","'||DATABASE_ROLE||'","'||OPEN_MODE||'","'||CPU_DETAIL_NAME||'","'||OS||'","'||DB_SERVICE_TIER||'","'||ARCH_DAILY_GB||'","'||PLATFORM_NAME||'","'||TARGET_NAME||'","'||
			TARGET_TYPE||'","'||DB_NAME_I||'","'||MEMORY_TARGET_I||'","'||PGA_AGGREGATE_LIMIT_I||'","'||PGA_AGGREGATE_TARGET_I||'","'||PROCESSES_I||'","'||SESSIONS_I||'","'||SGA_MAX_SIZE_I||'","'||USE_LARGE_PAGES_I||'","'||HOST_NAME_O_H||'","'||
			SYSTEM_CONFIG_H||'","'||DISK_H||'","'||CPU_COUNT_H||'","'||PHYSICAL_CPU_COUNT_H||'","'||LOGICAL_CPU_COUNT_H||'","'||FREQ_IN_MHZ_H||'","'||ECACHE_IN_MB_H||'","'||NUM_CORES_H||'","'||MAX_USED_CPU_COUNT_PER ||'","'||IOPS ||'","'||PGA_MAX_SIZE ||'"' as data
		FROM EXTRACT_OEM_DATA;
		
spool off;

spool 'file_oem_Extract_41.csv'

SELECT 'APP_ID,HOSTNAME,CNDB_NAME,NLS_CHARACTERSET,SGA_GB,DB_SIZE_GB,RAC_NODES_NUM,LOADED_CPU_COUNT,DB_UNIQUE_NAME,NCHAR_CHARACTERSET,DB_BLOCK_SIZE,LOG_ARCHIVE_CONFIG,DBID,LOG_MODE,DATABASE_ROLE,FORCE_LOGGING,FLASHBACK_ON,OPEN_MODE,PROTECTION_MODE,RAM_SIZE_GB,OS,UNDO_RETENTION,INSTANCE_NAME,MAX_USED_CPU_COUNT,SGA_MAX_SIZE,CPU_DETAIL_NAME,VERSION,HOST_DOMAIN,ARCH_DAILY_GB,HOST_CPU_COUNT,TARGET_TYPE' from dual;

select 
APP_ID||',"'||HOSTNAME||'","'||CNDB_NAME||'","'||NLS_CHARACTERSET||'","'||SGA_GB||'","'||DB_SIZE_GB||'","'||RAC_NODES_NUM||'","'||LOADED_CPU_COUNT||'","'||DB_UNIQUE_NAME||'","'||NCHAR_CHARACTERSET||'","'||DB_BLOCK_SIZE||'","'||LOG_ARCHIVE_CONFIG||'","'||DBID||'","'||LOG_MODE||'","'||DATABASE_ROLE||'","'||FORCE_LOGGING||'","'||FLASHBACK_ON||'","'||OPEN_MODE||'","'||PROTECTION_MODE||'","'||RAM_SIZE_GB||'","'||OS||'","'||UNDO_RETENTION||'","'||INSTANCE_NAME||'","'||MAX_USED_CPU_COUNT||'","'||SGA_MAX_SIZE||'","'||CPU_DETAIL_NAME||'","'||VERSION||'","'|| HOST_DOMAIN||'","'||ARCH_DAILY_GB||'","'||HOST_CPU_COUNT||'","'||TARGET_TYPE||'"'  as data
from (
SELECT
    APP_ID,HOSTNAME,CNDB_NAME,NLS_CHARACTERSET,SGA_GB,DB_SIZE_GB,RAC_NODES_NUM,
    LOADED_CPU_COUNT,DB_UNIQUE_NAME,NCHAR_CHARACTERSET,DB_BLOCK_SIZE,LOG_ARCHIVE_CONFIG,DBID,LOG_MODE,DATABASE_ROLE,
    FORCE_LOGGING,FLASHBACK_ON,OPEN_MODE,PROTECTION_MODE,RAM_SIZE_GB,OS,UNDO_RETENTION,INSTANCE_NAME,
    MAX_USED_CPU_COUNT,SGA_MAX_SIZE,CPU_DETAIL_NAME,VERSION,HOST_DOMAIN,ARCH_DAILY_GB,HOST_CPU_COUNT,TARGET_TYPE
FROM EXTRACT_OEM_DATA);
		
spool off;

DROP TABLE EXTRACT_OEM_DATA;

exit;
END