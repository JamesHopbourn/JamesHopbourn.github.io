# mysql_config_editor set --login-path=pro --host=127.0.0.1 --port=4406 -uroot -p

sed '2s/--// ; 17s/--// ; 48s/--// ; 53s/--//' 个人比赛计时.sql|mysql --login-path=pro running
sed '2s/--// ; 17s/--// ; 49s/--// ; 54s/--//' 个人比赛计时.sql|mysql --login-path=pro running
sed '2s/--// ; 17s/--// ; 50s/--// ; 55s/--//' 个人比赛计时.sql|mysql --login-path=pro running

mv $HOME/docker/mysql/data/running/*.json ../data/

cat ../data/man.json|jq length|sed 's|136|✅ man|'
cat ../data/woman.json|jq length|sed 's|68|✅ man|'
cat ../data/overall.json|jq length|sed 's|204|✅ overall|'
