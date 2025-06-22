<?php
/**
 * Created by PhpStorm.
 * User: Rich
 * Date: 11/4/14
 * Time: 12:00 AM
 */
function findSign($_birthdate) {     //looks up asian zodiac sign in Element Tree using birth date
    global $signLookup;
    $_birthyear = date('Y',$_birthdate);    //get the year from the birth date
    $_yearnode = $signLookup->xpath("year/FromYear[.=$_birthyear]/parent::*"); //Find Record for that year
    $_prevYearnode = $signLookup->xpath("year/FromYear[.=$_birthyear-1]/parent::*"); //Find Record for prev. year
    $_fromday = ($_yearnode[0]->FromDay)+1-1;                       //get day of chinese new year
    $_chnewyear = mktime(null,null,null,2,$_fromday,$_birthyear);   //create date for Chinese New year
    if ($_birthdate >= $_chnewyear) {
        $_animal = $_yearnode[0]->Sign;
    } else {
        $_animal = $_prevYearnode[0]->Sign;
    }
    return $_animal;
}

function displayTraits($_animal) {                                  //output Traits based on the sign
    global $traitLookup;
                                                                    //Get record for sign passed to it
    $_signNode = $traitLookup->xpath("sign/Animal[. ="."'".$_animal."'"."]/parent::*");
                                                                    // blasted Regex can't live with it,
                                                                    // can't live without it!
    $_keyword = $_signNode[0]->Keyword;
    $_detail = $_signNode[0]->Attributes;
    $_compatible = $_signNode[0]->MostCompatible;
    $_incompatible = $_signNode[0]->LeastCompatible;
    print "\nYour Asian zodiac sign is: " . $_animal. "<br>";
    print "The " . $_animal . " sign's major trait is " ?>  <b> <?php echo $_keyword ;?> </b>

    <div style="width: 66%">
        <p><?php echo $_detail . "<br>" ?></p>
        <p>
            <?php
            echo "People born under the sign of the ".$_animal. " are most compatible with the signs " . $_compatible;
            echo ", and are least compatible with the ". $_incompatible . " Sign.<br>"
            ?>
        </p>
    </div>
<?php
}
// Main Program
                                                                    //Get input from form
$BirthDate=mktime(null,null,null,$_POST['BirthMonth'],$_POST['BirthDay'],$_POST['BirthYear']);
echo "you input: " . date("m-d-Y",$BirthDate) ."<br><br>";
                                                                    //Read XML Files into Element Trees
$signLookup=simplexml_load_file("AnimalSigns.xml") or die("Error: Cannot Create object");
$traitLookup=simplexml_load_file("AsianZodiac.xml") or die("Error: Cannot Create object");

$Animal = findSign($BirthDate)."";                                  //findSign function returns animal name

displayTraits($Animal);                                             //displayTraits function outputs results
?>