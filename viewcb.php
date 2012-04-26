<?php
require("db.php");
if(isset($_GET['owner'])){
	$owner = $_GET['owner'];
}
if(isset($_GET['title'])){
	$title = $_GET['title'];
}

if(isset($_GET['user'])){
	$user = $_GET['user'];
}
$sql = "SELECT * FROM CorkBoards WHERE owner = '{$owner}' AND title = '{$title}'";
$con = mysql_connect("localhost",$db_name,$db_pass) or die(mysql_error());
mysql_select_db("cs4400_group53") or die(mysql_error());
$result1 = mysql_query($sql) or die(mysql_error());
$row1 = mysql_fetch_array($result1);

$sql2 = "SELECT * FROM Users WHERE email = '{$owner}'";
$result2 = mysql_query($sql2) or die(mysql_error());
$row2 = mysql_fetch_array($result2);

$sql3 = "SELECT * FROM Pushpins WHERE boardTitle = '{$row1['title']}' ORDER BY dateAndTime DESC";
$result3 = mysql_query($sql3) or die(mysql_error());
$row3 = mysql_fetch_array($result3);

$sql4 = "SELECT COUNT(*) FROM Watches WHERE boardOwner = '{$owner}' AND boardTitle = '{$title}'";
$result4 = mysql_query($sql4) or die(mysql_error());
$row4 = mysql_fetch_array($result4);
?>

<html>
	<head>
  <link rel="stylesheet" href="styles/style.css" />
    <title></title>
  </head>
  <body>
    <div id='glob_container'>
      <div id='header'>
        <h2>View CorkBoard</h2>
      </div>
      <div id='main_content'>
        <div id='top_info'>
			

  <h2 id='cb_title'><?php echo($row1['title']) ?></h2><h3 id='cb_owner' style='display:inline'> by <em><?php echo($row2['name']) ?>
	  </em>
  </h3>
  <?php if ($owner != $user){ ?>
  <button id='follow_btn'>Follow</button>
  <?php } ?>
		  <h4 id='cb_cat'></h4>
		  <p id='updated'>Last Updated <?php echo($row3['dateAndTime']) ?></p>
  <?php if ($owner == $user){ ?>
		  <button id='add_btn'>Add PushPin</button>
		  <?php } ?>
        </div>
        <div id='gallery'>
			<?php if ($row3){ ?>
			<a href='viewpp.php?dt=<?php echo($row3['dateAndTime']) ?>&owner=<?php echo($row3['owner']) ?>&user=<?php echo($user) ?>'><img src='<?php echo($row3['link']) ?>' style='margin:0px auto 0px auto;max-width:600px;display:block;'  class='thumb_pic' /></a>
		  <?php }
		  while ($row3 = mysql_fetch_array($result3)){ ?>
		  <a href='viewpp.php?'><img src='<?php echo($row3['link']) ?>' style='margin:0px auto 0px auto;max-width:600px;display:block;' class='thumb_pic' /></a>
		  <?php } ?>
        </div>
        <div id='bottom_info'>
          <img src='glass.gif' id='watch_icon' />
		  <p>This Corkboard has <strong><?php echo($row4[0]) ?></strong> watchers.</p>
  <?php if ($owner != $user){ ?>
		  <button id='watch_btn'>Watch</button>
		  <?php } ?>
        </div>
      </div>
    </div>
  </body>
</html>
