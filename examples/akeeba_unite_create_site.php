<?php
echo "Hello, this is a script to create a Joomla site from a jpa \n";
echo "It requires three parameters: \n";
echo "Parameter 1: full site name, eg 'Hill Valley' \n";
echo "Parameter 2: system site name, lower case no spaces, eg 'hillvalley' \n";
echo "Parameter 3: db password \n";

$sitename = $argv[1];
$sysname = $argv[2];
$dbpass = $argv[3];

echo "full site name: " . $sitename. "\n";
echo "system site name: " . $sysname. "\n";

if (!$sitename OR !$sitename OR !$dbpass ) {
    echo "Sorry, you are missing a parameter \n";
    exit;
}

if ( !file_exists( "unite" ) ) {
    echo "Missing UNiTE \n";
    exit;
}

# TODO: add code to set up sub-domain
# TODO: add code to create db user and db

# read in the base
$base_xml = file_get_contents( "akeeba_unite_base.xml" );

$old_word = array(
    "MY_SYSNAME", 
    "MY_SITE_NAME",
    "MY_SITE_DIR",
    "MY_DB_USERNAME",
    "MY_DB_PASSWORD",
    "MY_DB_NAME",
    "MY_PREFIX",    
);
$new_word = array(
    $sysname, 
    $sitename,
    $sysname,
    $sysname, 
    $dbpass, 
    $sysname, 
    "j" . rand(100, 999), 
);

# write the new xml file to the outboox
$base_xml = str_replace($old_word, $new_word, $base_xml);

mkdir($sysname);
//copy("MY_JPA.jpa", $sysname . "/" . $sysname . ".jpa");

file_put_contents( "unite/inbox/" . $sysname . ".xml", $base_xml );

$unite_output_array = array();
exec("php unite/unite.php", $unite_output_array);
print_r($unite_output_array);


?>