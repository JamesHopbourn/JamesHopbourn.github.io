# mysql_config_editor set --login-path=pro --host=127.0.0.1 --port=4406 -uroot -p

sed '2s/--// ; 17s/--// ; 50s/--// ; 55s/--//' 个人比赛计时.sql|mysql --login-path=pro running
sed '2s/--// ; 17s/--// ; 51s/--// ; 56s/--//' 个人比赛计时.sql|mysql --login-path=pro running
sed '2s/--// ; 17s/--// ; 52s/--// ; 57s/--//' 个人比赛计时.sql|mysql --login-path=pro running

mv $HOME/docker/mysql/data/running/*.json ../data/

cat ../data/man.json|jq length|sed '/136/ s/^/✅ man /'
cat ../data/woman.json|jq length|sed '/68/ s/^/✅ woman /'
cat ../data/overall.json|jq length|sed '/204/ s/^/✅ overall /'
