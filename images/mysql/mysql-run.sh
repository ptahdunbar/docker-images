#!/bin/bash
set -e

# Script to workaround docker-machine/boot2docker OSX host volume issues: https://github.com/docker-library/mysql/issues/99

mysql=( mysql --protocol=socket -uroot )

echo '* Working around permission errors locally by making sure that "mysql" uses the same uid and gid as the host volume'
TARGET_UID=$(stat -c "%u" /var/lib/mysql)
echo '-- Setting mysql user to use uid '$TARGET_UID
usermod -o -u $TARGET_UID mysql || true
TARGET_GID=$(stat -c "%g" /var/lib/mysql)
echo '-- Setting mysql group to use gid '$TARGET_GID
groupmod -o -g $TARGET_GID mysql || true
echo
echo '* Starting MySQL'
chown -R mysql:root /var/run/mysqld/

for f in ./data/dumps/*.sql; do
    echo "$0: importing dump file $f";
    pv "$f" | "${mysql[@]}" -f
done

/entrypoint.sh mysqld --user=mysql --console
