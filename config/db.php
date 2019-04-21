<?php
/**
 * Database Configuration
 *
 * All of your system's database connection settings go in here. You can see a
 * list of the available settings in vendor/craftcms/cms/src/config/DbConfig.php.
 *
 * @see craft\config\DbConfig
 */

return array(
  '*' => array(
    'server' => 'localhost',
    'database' => 'craft',
    'tablePrefix' => 'craft',
  ),

  'localhost' => array(
    'user' => 'root',
    'password' => 'Library2019',
  ),

  // Use IP of your droplet and MySQL credentials of a user you created
  '68.183.194.197' => array(
    'user' => 'craftcms',
    'password' => 'Library2019',
  )
);
