<?php

list($host, $port) = explode(':', getenv('DB_HOST'));
if (@mysqli_connect($host, getenv('DB_USER'), getenv('DB_PASSWORD'), getenv('DB_NAME'), $port)) {
    exit(0);
}
exit(1);
