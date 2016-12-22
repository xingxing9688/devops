mysql 5.6 备份的时候提示报错
mysqldump: Error 2020: Got packet bigger than 'max_allowed_packet' bytes when dumping table `plugindata` at row: 1

在my.cnf 中添加
The default max_allowed_packet size is 25M, and you can adjust it for good within your my.cnf by setting the variable in a section for mysqldump:

[mysqldump]
max_allowed_packet = 500M
