#
# Cookbook Name:: postgresql
# Attributes:: default
#
# Author:: Phil Cohen <github@phlippers.net>
#
# Copyright 2012-2013, Phil Cohen
#

node.default["postgresql"]["version"]                         = "9.3"
node.default["postgresql"]["apt_distribution"]                = node["lsb"]["codename"]

node.default["postgresql"]["environment_variables"]           = {}
node.default["postgresql"]["pg_ctl_options"]                  = ""
node.default["postgresql"]["pg_hba"]                          = []
node.default["postgresql"]["pg_hba_defaults"]                 = true
node.default["postgresql"]["pg_ident"]                        = []
node.default["postgresql"]["start"]                           = "auto"  # auto, manual, disabled

node.default["postgresql"]["conf"]                            = {}
node.default["postgresql"]["initdb_options"]                  = "--locale=en_US.UTF-8"

#------------------------------------------------------------------------------
# POSTGIS
#------------------------------------------------------------------------------

node.default["postgis"]["version"]                            = "1.5"

#------------------------------------------------------------------------------
# FILE LOCATIONS
#------------------------------------------------------------------------------
node.default["postgresql"]["data_directory"]                  = "/var/lib/postgresql/#{node["postgresql"]["version"]}/main"
node.default["postgresql"]["hba_file"]                        = "/etc/postgresql/#{node["postgresql"]["version"]}/main/pg_hba.conf"
node.default["postgresql"]["ident_file"]                      = "/etc/postgresql/#{node["postgresql"]["version"]}/main/pg_ident.conf"
node.default["postgresql"]["external_pid_file"]               = "/var/run/postgresql/#{node["postgresql"]["version"]}-main.pid"


#------------------------------------------------------------------------------
# CONNECTIONS AND AUTHENTICATION
#------------------------------------------------------------------------------

# connection settings
node.default["postgresql"]["listen_addresses"]                = "localhost"
node.default["postgresql"]["port"]                            = 5432
node.default["postgresql"]["max_connections"]                 = 100
node.default["postgresql"]["superuser_reserved_connections"]  = 3
node.default["postgresql"]["unix_socket_group"]               = ""
node.default["postgresql"]["unix_socket_permissions"]         = "0777"
node.default["postgresql"]["bonjour"]                         = "off"
node.default["postgresql"]["bonjour_name"]                    = ""

if Gem::Version.new(node["postgresql"]["version"]) >= Gem::Version.new("9.3")
  node.default["postgresql"]["unix_socket_directories"]       = "/var/run/postgresql"
else
  node.default["postgresql"]["unix_socket_directory"]         = "/var/run/postgresql"
end

# security and authentication
node.default["postgresql"]["authentication_timeout"]          = "1min"
node.default["postgresql"]["ssl"]                             = true
node.default["postgresql"]["ssl_ciphers"]                     = "ALL:!ADH:!LOW:!EXP:!MD5:@STRENGTH"
node.default["postgresql"]["ssl_renegotiation_limit"]         = "512MB"
node.default["postgresql"]["ssl_ca_file"]                     = ""
node.default["postgresql"]["ssl_cert_file"]                   = "/etc/ssl/certs/ssl-cert-snakeoil.pem"
node.default["postgresql"]["ssl_crl_file"]                    = ""
node.default["postgresql"]["ssl_key_file"]                    = "/etc/ssl/private/ssl-cert-snakeoil.key"
node.default["postgresql"]["password_encryption"]             = "on"
node.default["postgresql"]["db_user_namespace"]               = "off"

# kerberos and gssapi
node.default["postgresql"]["db_user_namespace"]               = "off"
node.default["postgresql"]["krb_server_keyfile"]              = ""
node.default["postgresql"]["krb_srvname"]                     = "postgres"
node.default["postgresql"]["krb_caseins_users"]               = "off"

# tcp keepalives
node.default["postgresql"]["tcp_keepalives_idle"]             = 0
node.default["postgresql"]["tcp_keepalives_interval"]         = 0
node.default["postgresql"]["tcp_keepalives_count"]            = 0


#------------------------------------------------------------------------------
# RESOURCE USAGE (except WAL)
#------------------------------------------------------------------------------

# memory
node.default["postgresql"]["shared_buffers"]                  = "24MB"
node.default["postgresql"]["temp_buffers"]                    = "8MB"
node.default["postgresql"]["max_prepared_transactions"]       = 0
node.default["postgresql"]["work_mem"]                        = "1MB"
node.default["postgresql"]["maintenance_work_mem"]            = "16MB"
node.default["postgresql"]["max_stack_depth"]                 = "2MB"

# kernel resource usage
node.default["postgresql"]["max_files_per_process"]           = 1000
node.default["postgresql"]["shared_preload_libraries"]        = ""

# cost-based vacuum delay
node.default["postgresql"]["vacuum_cost_delay"]               = "0ms"
node.default["postgresql"]["vacuum_cost_page_hit"]            = 1
node.default["postgresql"]["vacuum_cost_page_miss"]           = 10
node.default["postgresql"]["vacuum_cost_page_dirty"]          = 20
node.default["postgresql"]["vacuum_cost_limit"]               = 200

# background writer
node.default["postgresql"]["bgwriter_delay"]                  = "200ms"
node.default["postgresql"]["bgwriter_lru_maxpages"]           = 100
node.default["postgresql"]["bgwriter_lru_multiplier"]         = 2.0

# asynchronous behavior
node.default["postgresql"]["effective_io_concurrency"]        = 1


#------------------------------------------------------------------------------
# WRITE AHEAD LOG
#------------------------------------------------------------------------------

# settings
node.default["postgresql"]["wal_level"]                       = "minimal"
node.default["postgresql"]["fsync"]                           = "on"
node.default["postgresql"]["synchronous_commit"]              = "on"
node.default["postgresql"]["wal_sync_method"]                 = "fsync"
node.default["postgresql"]["full_page_writes"]                = "on"
node.default["postgresql"]["wal_buffers"]                     = -1
node.default["postgresql"]["wal_writer_delay"]                = "200ms"
node.default["postgresql"]["commit_delay"]                    = 0
node.default["postgresql"]["commit_siblings"]                 = 5

# checkpoints
node.default["postgresql"]["checkpoint_segments"]             = 3
node.default["postgresql"]["checkpoint_timeout"]              = "5min"
node.default["postgresql"]["checkpoint_completion_target"]    = 0.5
node.default["postgresql"]["checkpoint_warning"]              = "30s"

# archiving
node.default["postgresql"]["archive_mode"]                    = "off"
node.default["postgresql"]["archive_command"]                 = ""
node.default["postgresql"]["archive_timeout"]                 = 0


#------------------------------------------------------------------------------
# REPLICATION
#------------------------------------------------------------------------------

# master server
node.default["postgresql"]["max_wal_senders"]                 = 0
node.default["postgresql"]["wal_sender_delay"]                = "1s"
node.default["postgresql"]["wal_keep_segments"]               = 0
node.default["postgresql"]["vacuum_defer_cleanup_age"]        = 0
node.default["postgresql"]["replication_timeout"]             = "60s"
node.default["postgresql"]["synchronous_standby_names"]       = ""

# standby servers
node.default["postgresql"]["hot_standby"]                     = "off"
node.default["postgresql"]["max_standby_archive_delay"]       = "30s"
node.default["postgresql"]["max_standby_streaming_delay"]     = "30s"
node.default["postgresql"]["wal_receiver_status_interval"]    = "10s"
node.default["postgresql"]["hot_standby_feedback"]            = "off"


#------------------------------------------------------------------------------
# QUERY TUNING
#------------------------------------------------------------------------------

# planner method configuration
node.default["postgresql"]["enable_bitmapscan"]               = "on"
node.default["postgresql"]["enable_hashagg"]                  = "on"
node.default["postgresql"]["enable_hashjoin"]                 = "on"
node.default["postgresql"]["enable_indexscan"]                = "on"
node.default["postgresql"]["enable_material"]                 = "on"
node.default["postgresql"]["enable_mergejoin"]                = "on"
node.default["postgresql"]["enable_nestloop"]                 = "on"
node.default["postgresql"]["enable_seqscan"]                  = "on"
node.default["postgresql"]["enable_sort"]                     = "on"
node.default["postgresql"]["enable_tidscan"]                  = "on"

# planner cost constants
node.default["postgresql"]["seq_page_cost"]                   = 1.0
node.default["postgresql"]["random_page_cost"]                = 4.0
node.default["postgresql"]["cpu_tuple_cost"]                  = 0.01
node.default["postgresql"]["cpu_index_tuple_cost"]            = 0.005
node.default["postgresql"]["cpu_operator_cost"]               = 0.0025
node.default["postgresql"]["effective_cache_size"]            = "128MB"

# genetic query optimizer
node.default["postgresql"]["geqo"]                            = "on"
node.default["postgresql"]["geqo_threshold"]                  = 12
node.default["postgresql"]["geqo_effort"]                     = 5
node.default["postgresql"]["geqo_pool_size"]                  = 0
node.default["postgresql"]["geqo_generations"]                = 0
node.default["postgresql"]["geqo_selection_bias"]             = 2.0
node.default["postgresql"]["geqo_seed"]                       = 0.0

# other planner options
node.default["postgresql"]["default_statistics_target"]       = 100
node.default["postgresql"]["constraint_exclusion"]            = "partition"
node.default["postgresql"]["cursor_tuple_fraction"]           = 0.1
node.default["postgresql"]["from_collapse_limit"]             = 8
node.default["postgresql"]["join_collapse_limit"]             = 8


#------------------------------------------------------------------------------
# ERROR REPORTING AND LOGGING
#------------------------------------------------------------------------------

# where to log
node.default["postgresql"]["log_destination"]                 = "stderr"
node.default["postgresql"]["logging_collector"]               = "off"
node.default["postgresql"]["log_directory"]                   = "pg_log"
node.default["postgresql"]["log_filename"]                    = "postgresql-%Y-%m-%d_%H%M%S.log"
node.default["postgresql"]["log_file_mode"]                   = 0600
node.default["postgresql"]["log_truncate_on_rotation"]        = "off"
node.default["postgresql"]["log_rotation_age"]                = "1d"
node.default["postgresql"]["log_rotation_size"]               = "10MB"

# These are relevant when logging to syslog:
node.default["postgresql"]["syslog_facility"]                 = "LOCAL0"
node.default["postgresql"]["syslog_ident"]                    = "postgres"
node.default["postgresql"]["silent_mode"]                     = "off"

# when to log
node.default["postgresql"]["client_min_messages"]             = "notice"
node.default["postgresql"]["log_min_messages"]                = "warning"
node.default["postgresql"]["log_min_error_statement"]         = "error"
node.default["postgresql"]["log_min_duration_statement"]      = -1

# what to log
node.default["postgresql"]["debug_print_parse"]               = "off"
node.default["postgresql"]["debug_print_rewritten"]           = "off"
node.default["postgresql"]["debug_print_plan"]                = "off"
node.default["postgresql"]["debug_pretty_print"]              = "on"
node.default["postgresql"]["log_checkpoints"]                 = "off"
node.default["postgresql"]["log_connections"]                 = "off"
node.default["postgresql"]["log_disconnections"]              = "off"
node.default["postgresql"]["log_duration"]                    = "off"
node.default["postgresql"]["log_error_verbosity"]             = "default"
node.default["postgresql"]["log_hostname"]                    = "off"
node.default["postgresql"]["log_line_prefix"]                 = "%t "
node.default["postgresql"]["log_lock_waits"]                  = "off"
node.default["postgresql"]["log_statement"]                   = "none"
node.default["postgresql"]["log_temp_files"]                  = -1
node.default["postgresql"]["log_timezone"]                    = "(defaults to server environment setting)"


#------------------------------------------------------------------------------
# RUNTIME STATISTICS
#------------------------------------------------------------------------------

# query/index statistics collector
node.default["postgresql"]["track_activities"]                = "on"
node.default["postgresql"]["track_counts"]                    = "on"
node.default["postgresql"]["track_functions"]                 = "none"
node.default["postgresql"]["track_activity_query_size"]       = 1024
node.default["postgresql"]["update_process_title"]            = "on"
node.default["postgresql"]["stats_temp_directory"]            = 'pg_stat_tmp'

# statistics monitoring
node.default["postgresql"]["log_parser_stats"]                = "off"
node.default["postgresql"]["log_planner_stats"]               = "off"
node.default["postgresql"]["log_executor_stats"]              = "off"
node.default["postgresql"]["log_statement_stats"]             = "off"


#------------------------------------------------------------------------------
# AUTOVACUUM PARAMETERS
#------------------------------------------------------------------------------

node.default["postgresql"]["autovacuum"]                      = "on"
node.default["postgresql"]["log_autovacuum_min_duration"]     = -1
node.default["postgresql"]["autovacuum_max_workers"]          = 3
node.default["postgresql"]["autovacuum_naptime"]              = "1min"
node.default["postgresql"]["autovacuum_vacuum_threshold"]     = 50
node.default["postgresql"]["autovacuum_analyze_threshold"]    = 50
node.default["postgresql"]["autovacuum_vacuum_scale_factor"]  = 0.2
node.default["postgresql"]["autovacuum_analyze_scale_factor"] = 0.1
node.default["postgresql"]["autovacuum_freeze_max_age"]       = 200000000
node.default["postgresql"]["autovacuum_vacuum_cost_delay"]    = "20ms"
node.default["postgresql"]["autovacuum_vacuum_cost_limit"]    = -1


#------------------------------------------------------------------------------
# CLIENT CONNECTION DEFAULTS
#------------------------------------------------------------------------------

# statement behavior
node.default["postgresql"]["search_path"]                     = '"$user",public'
node.default["postgresql"]["default_tablespace"]              = ""
node.default["postgresql"]["temp_tablespaces"]                = ""
node.default["postgresql"]["check_function_bodies"]           = "on"
node.default["postgresql"]["default_transaction_isolation"]   = "read committed"
node.default["postgresql"]["default_transaction_read_only"]   = "off"
node.default["postgresql"]["default_transaction_deferrable"]  = "off"
node.default["postgresql"]["session_replication_role"]        = "origin"
node.default["postgresql"]["statement_timeout"]               = 0
node.default["postgresql"]["vacuum_freeze_min_age"]           = 50000000
node.default["postgresql"]["vacuum_freeze_table_age"]         = 150000000
node.default["postgresql"]["bytea_output"]                    = "hex"
node.default["postgresql"]["xmlbinary"]                       = "base64"
node.default["postgresql"]["xmloption"]                       = "content"

# locale and formatting
node.default["postgresql"]["datestyle"]                       = "iso, mdy"
node.default["postgresql"]["intervalstyle"]                   = "postgres"
node.default["postgresql"]["timezone"]                        = "(defaults to server environment setting)"
node.default["postgresql"]["timezone_abbreviations"]          = "Default"
node.default["postgresql"]["extra_float_digits"]              = 0
node.default["postgresql"]["client_encoding"]                 = "sql_ascii"

# These settings are initialized by initdb, but they can be changed.
node.default["postgresql"]["lc_messages"]                     = "en_US.UTF-8"
node.default["postgresql"]["lc_monetary"]                     = "en_US.UTF-8"
node.default["postgresql"]["lc_numeric"]                      = "en_US.UTF-8"
node.default["postgresql"]["lc_time"]                         = "en_US.UTF-8"

# default configuration for text search
node.default["postgresql"]["default_text_search_config"]      = "pg_catalog.english"

# other defaults
node.default["postgresql"]["dynamic_library_path"]            = "$libdir"
node.default["postgresql"]["local_preload_libraries"]         = ""


#------------------------------------------------------------------------------
# LOCK MANAGEMENT
#------------------------------------------------------------------------------

node.default["postgresql"]["deadlock_timeout"]                = "1s"
node.default["postgresql"]["max_locks_per_transaction"]       = 64
node.default["postgresql"]["max_pred_locks_per_transaction"]  = 64


#------------------------------------------------------------------------------
# VERSION/PLATFORM COMPATIBILITY
#------------------------------------------------------------------------------

# previous postgresql versions
node.default["postgresql"]["array_nulls"]                     = "on"
node.default["postgresql"]["backslash_quote"]                 = "safe_encoding"
node.default["postgresql"]["default_with_oids"]               = "off"
node.default["postgresql"]["escape_string_warning"]           = "on"
node.default["postgresql"]["lo_compat_privileges"]            = "off"
node.default["postgresql"]["quote_all_identifiers"]           = "off"
node.default["postgresql"]["sql_inheritance"]                 = "on"
node.default["postgresql"]["standard_conforming_strings"]     = "on"
node.default["postgresql"]["synchronize_seqscans"]            = "on"

# other platforms and clients
node.default["postgresql"]["transform_null_equals"]           = "off"


#------------------------------------------------------------------------------
# ERROR HANDLING
#------------------------------------------------------------------------------

node.default["postgresql"]["exit_on_error"]                   = "off"
node.default["postgresql"]["restart_after_crash"]             = "on"


#------------------------------------------------------------------------------
# USERS AND DATABASES
#------------------------------------------------------------------------------

node.default["postgresql"]["users"]                           = []
node.default["postgresql"]["databases"]                       = []


#------------------------------------------------------------------------------
# CUSTOMIZED OPTIONS
#------------------------------------------------------------------------------

node.default["postgresql"]["custom_variable_classes"]         = ""
