<pre>
<?php
include("login.php");
include("dbFunc.php");
if($_GET['y'] == 1)
{
	clearUsers();
}
else
{
	print "Trying to erase my database I see. Well you suck.";
}
?>
</pre>

