# mysql_config_editor set --login-path=pro --host=127.0.0.1 --port=4406 -uroot -p

sed '48s/--// ; 53s/--//' 个人比赛计时.sql|mysql --login-path=pro running
sed '49s/--// ; 54s/--//' 个人比赛计时.sql|mysql --login-path=pro running
sed '50s/--// ; 55s/--//' 个人比赛计时.sql|mysql --login-path=pro running

mv $HOME/docker/mysql/data/running/*.json ../data/

cat ../data/man.json|jq length|xargs echo '136 =='
cat ../data/woman.json|jq length|xargs echo '68 =='
cat ../data/overall.json|jq length|xargs echo '204 =='
