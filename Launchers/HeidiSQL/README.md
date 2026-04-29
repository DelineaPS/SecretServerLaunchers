# HeidiSQL — MySQL/MariaDB launcher

[HeidiSQL](https://www.heidisql.com/) is an open-source client supporting MariaDB / MySQL, Microsoft SQL, PostgreSQL, and SQLite. The example below targets MySQL; adapt the `-l` driver argument for other databases per the [HeidiSQL command-line reference](https://www.heidisql.com/help.php#commandline).

## Launcher

> [!IMPORTANT]
> Untick **Wrap custom parameters with quotation marks**. The arguments below are unquoted by design.

| Launcher field | Value |
|---|---|
| Launcher Type | Process |
| Wrap custom parameters with quotation marks | No |
| Process Name | `C:\Program Files\HeidiSQL\heidisql.exe` |
| Process Arguments | `-n 0 -h $Server -l libmysql.dll -u $USERNAME -p $PASSWORD` |

`-n 0` selects the network type (0 = MySQL/MariaDB TCP/IP). Change to match your database — see the HeidiSQL docs.

## Template

Tested with the out-of-the-box **MySQL** template. Add a custom `Server` Text field if not already present.
