# mysql_config_editor set --login-path=pro --host=127.0.0.1 --port=4406 -uroot -p

sed '/JSON_ARRAYAGG/ s/--// ; /tag:man/ s/--//' 个人比赛计时.sql|mysql --login-path=pro running
sed '/JSON_ARRAYAGG/ s/--// ; /tag:woman/ s/--//' 个人比赛计时.sql|mysql --login-path=pro running
sed '/JSON_ARRAYAGG/ s/--// ; /tag:overall/ s/--//' 个人比赛计时.sql|mysql --login-path=pro running

mv $HOME/docker/mysql/data/running/*.json ../data/
sed -i '' 's|{||g ; s|}||g ; s|^\[|{| ; s|\]$|}|' ../data/*.json

cat ../data/man.json|jq length|sed '/136/ s/^/✅ man / ; /✅/! s/^/男子组：/ ; s/$/ 人/'
cat ../data/woman.json|jq length|sed '/68/ s/^/✅ woman / ; /✅/! s/^/女子组：/ ; s/$/ 人/'
cat ../data/overall.json|jq length|sed '/204/ s/^/✅ overall / ; /✅/! s/^/全体选手：/ ; s/$/ 人/'