<?php
//db.php define $db_name and $db_pass which are needed to connect to the db
require("db.php");
/*
//check for post information
 */
$uname = $_POST['uname'];
$pin = $_POST['pin'];


$sql = "SELECT * FROM `Users` WHERE `email` = '{$uname}' AND `pin` = '{$pin}'";
//create the connection
$con = mysql_connect("localhost", $db_name, $db_pass) or die(mysql_error());
//selecet our database
mysql_select_db("cs4400_group53") or die(mysql_error());
//query for username
$result = mysql_query($sql) or die(mysql_error());
if (mysql_num_rows($result) == 1){
  //means we have a result
?>
<html>
  <head>
  <link rel="stylesheet" href="styles/style.css" />
    <title></title>
  </head>
  <body>
    <div id='glob_container'>
      <div id='header'>
        <h1>home page</h1>
      </div>
      <div id='main_content'>
        <h2>Recent CorkBoard Updates</h2>
        <a href='pop_tags.html'><button name='pop_tags' value='Popular Tags'>Popular Tags</button></a>
        <div id='board_list'>
          <?php
  $sql4 = "SELECT `CorkBoards`.owner, title, dateAndTime FROM `CorkBoards` INNER JOIN Pushpins WHERE `password` IS NOT NULL ORDER BY `Pushpins`.dateAndTime DESC LIMIT 0, 4";
  $result4 = mysql_query($sql4);
  while ($row = mysql_fetch_array($result4)){
	  $sql5 = "SELECT * FROM Users WHERE email='{$row['owner']}'";
	  $result5 = mysql_query($sql5);
	  $res5 = mysql_fetch_array($result5);

  ?>
  <a href='viewcb.php?owner=<?php echo($row['owner']) ?>&title=<?php echo($row['title']) ?>&user=<?php echo($uname) ?>'>
          <div class='b_node'>
            <h4><?php echo($row['title']) ?></h4>
			<p>Updated by <em><?php echo($res5['name']) ?></em> on <em><?php echo($row['dateAndTime']) ?></em> at <em>1:49 PM</em></p>
          </div>
        </a>
            <?php } ?>
        </div>
        <h2>My CorkBoards</h2><a href='add_board.php'><button name='add_board' value='Add CorkBoard'>Add CorkBoard</button></a>
        <div id='my_boards'>
<?php
  $sql = "SELECT * FROM `CorkBoards` WHERE `owner` = '{$uname}'";
  $result = mysql_query($sql) or die(mysql_error());

  while ($row = mysql_fetch_array($result)){
    $sql2 = "SELECT COUNT(*) FROM `Pushpins` WHERE `owner` = '{$uname}' AND `boardTitle`='{$row['title']}'";
    $num = 0;
    if ($result2 = mysql_query($sql2)){
      $res = mysql_fetch_array($result2);
      $num = $res[0];
    }
?>
<a href='viewcb.php?owner=<?php echo($uname) ?>&title=<?php echo($row['title']) ?>&user=<?php echo($uname) ?>'>
          <div class='my_board'>
            <h4><?php echo($row['title']); ?></h4>
            <?php
    if ($row['password']){
    ?>
    <h4 class='private'>(private)</h4>
            <?php } ?>
            <p>with <?php echo("$num") ?> PushPins</p>
          </div>
          </a>
<?php } ?>
        </div>
        <div id='search_box'>
			<form method='get' action='search.php'>
            <input type='text' placeholder='Search description, tags and Corkboard category' name='q' /><input type='submit' value='Search' />
          </form>
        </div>
      </div>
    </div>
  </body>
</html>
<?php
} else { ?>
<html>
  <head>
  <link rel="stylesheet" href="styles/style.css" />
    <title>login page</title>
  </head>
  <body>
    <div id='glob_container'>
      <div id='header'>
        <h1>Login</h1>
        <p style='color:red'><strong>Username or Password incorrect!</strong></p>
        <form action='home.php' method='post'>
          <table width="273" height="111" border="0" align="center">
            <tr>
              <td width="87">E-mail:</td>
              <td width="176"><input name='uname' type='text' id='uname_box' /></td>
            </tr>
            <tr>
              <td>Pin:</td>
              <td><input name='pin' type='password' id='pin_box' /></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td><input name='sub' type='submit' value='submit' id=='sub_btn' /></td>
            </tr>
          </table>
        </form>
        <p>&nbsp;</p>
      </div>
      <div id='login_box'>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
      </div>
    </div>
  </body>
</html>
<?php
}
?>
