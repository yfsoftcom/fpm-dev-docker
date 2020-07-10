#! /bin/sh
cur_date="`date +%Y_%m_%d_%H_%M`"

DB_NAME=${arg1:="fpm_open_iot"}

if [ ! -d "backup/mysql" ]; then
  mkdir -p backup/mysql
fi

BAK_DATA_SQL=backup/mysql/d_$cur_date.sql
BAK_TABLE_SQL=backup/mysql/t_$cur_date.sql

BAK_SQL=backup/mysql/latest.sql

echo "${BAK_DATA_SQL}"
echo "${BAK_TABLE_SQL}"

mysqldump -uroot -p741235896 -d --compact --add-drop-table $DB_NAME > $BAK_TABLE_SQL

# 删除包含 Warning 的行
sed -i '/Warning:/'d $BAK_TABLE_SQL
# 删除包含 *!40101 的行, 备份时的注释
sed -i '/*!40101/'d $BAK_TABLE_SQL

mysqldump -uroot -p741235896 -t --compact $DB_NAME > $BAK_DATA_SQL

# 删除包含 *!40101 的行, 备份时的注释
sed -i '/Warning:/'d $BAK_DATA_SQL

# 输出到一个最新版本的 sql 脚本中

# 设置字符编码，解决还原后出现乱码的问题
echo "set character set utf8;" > $BAK_SQL

cat $BAK_TABLE_SQL >> $BAK_SQL

cat $BAK_DATA_SQL >> $BAK_SQL

tar -zcvf backup/$cur_date.sql.tar.gz backup/mysql/*$cur_date.sql $BAK_SQL

# --no-create-info,  -t  只导出数据，而不添加CREATE TABLE 语句。

# --no-data, -d   不导出任何数据，只导出数据库表结构。
