-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 08, 2022 at 11:04 PM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 8.0.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pts_db`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `rpt_cashier` ()  NO SQL
BEGIN
	SELECT c.id,c.name,c.pharmacy_price,c.Room_price,c.Surgery_Price,c.Test_Price,c.dateofrecieve,c.total
,concat
('<a href="actions/edit.php?table=cashier&form_name=sys_forms/cashier.php&id=',c.id,'" class="btn btn-success sys_update_link"><i class="fas fa-edit"></i></a>') as "edit",concat
 
 
 ('<a href="actions/delete.php?table=test&id='
 ,c.id,'"></a>') FROM  cashier c ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rpt_doctor` ()  NO SQL
BEGIN
	SELECT d.Doctor_ID,d.DR_Name,d.Department,d.Email,d.Time_in,d.Time_out
    ,d.Days_of_work
,concat
('<a href="actions/edit.php?table=doctor&form_name=sys_forms/doctor.php&id=',d.Doctor_ID,'" class="btn btn-success sys_update_link"><i class="fas fa-edit"></i></a>') as "edit" FROM  doctor d;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rpt_lab` ()  NO SQL
BEGIN
	SELECT t.Test_Type,t.Result,t.Test_Price
,concat
('<a href="actions/edit.php?table=test&form_name=sys_forms/lab.php&id=',t.PID,'" class="btn btn-success sys_update_link"><i class="fas fa-edit"></i></a>') as "edit" FROM  test t ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rpt_nurse` ()  NO SQL
BEGIN
	SELECT n.id,n.Name,n.Shift_in,n.Shift_out,n.Type,n.Description
,concat
('<a href="actions/edit.php?table=nurse&form_name=sys_forms/nurse.php&id=',n.id,'" class="btn btn-success sys_update_link"><i class="fas fa-edit"></i></a>') as "edit" FROM  nurse n;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rpt_patient` ()  NO SQL
BEGIN
	SELECT pa.id,pa.name,pa.age,pa.gender,pa.tell,pa.date_of_Admin,pa.department,pa.visit_no,pa.Amount
,concat
('<a href="actions/edit.php?table=patients&form_name=sys_forms/patient.php&id=',pa.id,'" class="btn btn-success sys_update_link"><i class="fas fa-edit"></i></a>') as "edit" FROM  patients pa ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rpt_pharmacy` ()  NO SQL
BEGIN
	SELECT p.ID,p.Treatement_Name,p.Qty,p.Type,p.Price,p.Description
,concat
('<a href="actions/edit.php?table=pharmacy&form_name=sys_forms/pharmacy.php&id=',p.ID,'" class="btn btn-success sys_update_link"><i class="fas fa-edit"></i></a>') as "edit" FROM  pharmacy p ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rpt_rooms` ()  NO SQL
BEGIN
	SELECT r.id,r.room_type,r.price,r.daysofstay 
,concat
('<a href="actions/edit.php?table=rooms&form_name=sys_forms/room.php&id=',r.id,'" class="btn btn-success sys_update_link"><i class="fas fa-edit"></i></a>') as "edit" FROM  rooms r ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rpt_surgery` ()  NO SQL
BEGIN
	SELECT s.id,s.Surgery_Type,s.DR_Name,s.Sing_Person
,concat
('<a href="actions/edit.php?table=surgery&form_name=sys_forms/surgery.php&id=',s.id,'" class="btn btn-success sys_update_link"><i class="fas fa-edit"></i></a>') as "edit" FROM  surgery s ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rpt_user` ()  NO SQL
BEGIN
	SELECT u.id,u.fullname,u.type,u.username,u.password,u.userd_id 
,concat
('<a href="actions/edit.php?table=users&form_name=sys_forms/users.php&id=',u.id,'" class="btn btn-success sys_update_link"><i class="fas fa-edit"></i></a>') as "edit" FROM  users u ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cashier` (IN `p_name` VARCHAR(50), IN `p_pharmacy_price` INT, IN `p_room_price` INT, IN `p_surgery_price` INT, IN `p_test_price` INT, IN `p_date_of_recieve` VARCHAR(50), IN `p_total` INT, IN `p_id` INT)  NO SQL
BEGIN
IF EXISTS(SELECT * FROM cashier c WHERE c.id=p_id) THEN
	UPDATE cashier c SET 
    c.name=p_name,c.pharmacy_price=p_pharmacy_price,c.Room_price=p_room_price,
    c.Surgery_Price=p_surgery_price,c.Test_Price=p_test_price,c.dateofrecieve=p_date_of_recieve,
    c.total=p_total
    WHERE c.id=p_id;
    SELECT "success|Cashier Updated Successfully" msg; 

ELSE
	INSERT INTO `cashier`(`id`, `name`, `pharmacy_price`, `Room_price`, `Surgery_Price`, `Test_Price`,`dateofrecieve`,`total`) VALUES (NULL,p_name,p_pharmacy_price,p_room_price ,p_surgery_price,p_test_price,p_date_of_recieve,p_total);
    SELECT "success|cashier registered succesfully" msg;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_death` (IN `p_pid` INT, IN `p_pname` VARCHAR(50), IN `p_date_of_admin` VARCHAR(50), IN `p_date_of_death` VARCHAR(50), IN `p_reason` VARCHAR(100), IN `p_descriptions` VARCHAR(100), IN `p_id` INT)  NO SQL
BEGIN
IF EXISTS(SELECT * FROM death dt WHERE dt.id=p_id) THEN
	UPDATE death dt SET 
    dt.pid=p_pid,dt.pname=p_pname,dt.date_of_admin=p_date_of_admin,dt.date_of_death=p_date_of_death,dt.reason=p_reason,dt.descriptions=p_descriptions
    WHERE dt.id=p_id;
    SELECT "success|Death Updated Successfully" msg; 

ELSE
	INSERT INTO `death`(`id`, `pid`, `pname`, `date_of_admin`, `date_of_death`, `reason`,`descriptions`) VALUES (NULL,p_pid,p_pname,p_date_of_admin ,p_date_of_death,p_reason,p_descriptions);
    SELECT "success|Death registered succesfully" msg;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_doctor` (IN `p_doctorname` VARCHAR(50), IN `p_department` VARCHAR(50), IN `p_email` VARCHAR(50), IN `p_timein` VARCHAR(50), IN `p_timeout` VARCHAR(50), IN `p_daysofwork` VARCHAR(50), IN `p_id` INT)  NO SQL
BEGIN
IF EXISTS(SELECT * FROM doctor d WHERE d.Doctor_ID=p_id) THEN
	UPDATE doctor d SET d.DR_Name=p_doctorname,d.Department=p_department,d.Email=p_email
,d.Time_in=p_timein,d.Time_out=p_timeout,d.Days_of_work=p_daysofwork  WHERE d.Doctor_ID=p_id;
    SELECT "success|Doctor Updated Successfully" msg; 

ELSE
	INSERT INTO `doctor`(`Doctor_ID`, `DR_Name`, `Department`, `Email`, `Time_in`, `Time_out`, `Days_of_work`) VALUES (NULL,p_doctorname,p_department,p_email ,p_timein,p_timeout,p_daysofwork);
    SELECT "success|Doctor registered succesfully" msg;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_login` (IN `p_username` VARCHAR(50), IN `p_password` VARCHAR(50))  NO SQL
BEGIN
IF EXISTS(SELECT * FROM users u WHERE u.username=p_username AND u.password=p_password) THEN
	SELECT u.fullname,u.username,u.id,"success" msg FROM users u WHERE u.username=p_username AND u.password=p_password;
ELSE
	SELECT "Username or password is incorrect" msg;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_nurse` (IN `p_name` VARCHAR(50), IN `p_Shift_in` VARCHAR(50), IN `p_Shift_out` VARCHAR(50), IN `p_Type` VARCHAR(50), IN `p_Description` VARCHAR(50), IN `p_id` INT)  NO SQL
BEGIN
IF EXISTS(SELECT * FROM nurse n WHERE n.id=p_id) THEN
	UPDATE nurse n SET 
    n.Name=p_name,n.Shift_in=p_Shift_in,n.Shift_out=p_Shift_out,n.Type=p_Type,n.Description=p_Description
    WHERE n.id=p_id;
    SELECT "success|Nurse Updated Successfully" msg; 

ELSE
	INSERT INTO `nurse`(`id`, `Name`, `Shift_in`, `Shift_out`, `Type`, `Description`) VALUES (NULL,p_name,p_Shift_in,p_Shift_out ,p_Type,p_Description);
    SELECT "success|Nurse registered succesfully" msg;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_patients` (IN `p_name` VARCHAR(50), IN `p_age` VARCHAR(50), IN `p_gender` VARCHAR(50), IN `p_tell` VARCHAR(50), IN `p_date_of_Admin` VARCHAR(50), IN `p_department` VARCHAR(50), IN `p_visit_no` INT, IN `p_amount` INT, IN `p_id` INT)  NO SQL
BEGIN
IF EXISTS(SELECT * FROM patients pt WHERE pt.id=p_id) THEN
	UPDATE patients pt SET 
    pt.name=p_name,pt.age=p_age,pt.gender=p_gender,pt.tell=p_tell,
    pt.date_of_Admin=p_date_of_Admin,pt.department=p_department,pt.visit_no=p_visit_no,
    pt.Amount=p_amount
    WHERE pt.id=p_id;
    SELECT "success|Patient Updated Successfully" msg; 

ELSE
	INSERT INTO `patients`(`id`, `Name`, `age`, `gender`, `tell`, `date_of_Admin`,`department`,`visit_no`,`Amount`) VALUES (NULL,p_name,p_age,p_gender ,p_tell,p_date_of_Admin,p_department,p_visit_no,p_amount);
    SELECT "success|Patient registered succesfully" msg;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pharmacy` (IN `p_treatment_name` VARCHAR(50), IN `p_quantity` INT, IN `p_type` VARCHAR(50), IN `p_price` INT, IN `p_description` VARCHAR(50), IN `p_id` INT)  NO SQL
BEGIN
IF EXISTS(SELECT * FROM pharmacy pc WHERE pc.ID=p_id) THEN
	UPDATE pharmacy pc SET 
    pc.Treatement_Name=p_treatment_name,pc.Qty=p_quantity,pc.Type=p_type,pc.Price=p_price,
    pc.Description=p_description  WHERE pc.ID=p_id;
    SELECT "success|Pharmacy Updated Successfully" msg; 

ELSE
	INSERT INTO `pharmacy`(`id`, `Treatement_Name`, `Qty`, `Type`, `Price`, `Description`) VALUES (NULL,p_treatment_name,p_quantity,p_type ,p_price,p_description);
    SELECT "success|Pharmacy registered succesfully" msg;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_rooms` (IN `p_room_type` VARCHAR(50), IN `p_price` INT, IN `p_daysofstay` VARCHAR(50), IN `p_id` INT)  NO SQL
BEGIN
IF EXISTS(SELECT * FROM rooms rm WHERE rm.id=p_id) THEN
	UPDATE rooms rm SET 
    rm.room_type=p_room_type,rm.price=p_price,rm.daysofstay=p_daysofstay
    WHERE rm.id=p_id;
    SELECT "success|Room Updated Successfully" msg; 

ELSE
	INSERT INTO `rooms`(`id`, `room_type`, `price`, `daysofstay`) VALUES (NULL,p_room_type,p_price,p_daysofstay);
    SELECT "success|Room registered succesfully" msg;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_surgery` (IN `p_Surgery_Type` VARCHAR(50), IN `p_DR_Name` VARCHAR(50), IN `p_Sing_Person` VARCHAR(50), IN `p_id` INT)  NO SQL
BEGIN
IF EXISTS(SELECT * FROM surgery sr WHERE sr.id=p_id) THEN
	UPDATE surgery sr SET 
    sr.Surgery_Type=p_Surgery_Type,sr.DR_Name=p_DR_Name,sr.Sing_Person=p_Sing_Person
    WHERE sr.id=p_id;
    SELECT "success|Surgery Updated Successfully" msg; 

ELSE
	INSERT INTO `surgery`(`id`, `Surgery_Type`, `DR_Name`, `Sing_Person`) VALUES (NULL,p_Surgery_Type,p_DR_Name,p_Sing_Person);
    SELECT "success|Surgery registered succesfully" msg;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_test` (IN `p_test_type` VARCHAR(50), IN `p_result` VARCHAR(50), IN `p_test_price` INT, IN `p_id` INT)  NO SQL
BEGIN
IF EXISTS(SELECT * FROM test t WHERE t.PID=p_id) THEN
	UPDATE test t SET 
    t.Test_Type=p_test_type,t.Result=p_result,t.Test_Price=p_test_price
    WHERE t.PID=p_id;
    SELECT "success|test Updated Successfully" msg; 

ELSE
	INSERT INTO `test`(`PID`, `Test_Type`,`Result`, `Test_Price`) VALUES (NULL,p_test_type,p_result,p_test_price);
    SELECT "success|test registered succesfully" msg;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_users` (IN `p_fullname` VARCHAR(50), IN `p_type` VARCHAR(50), IN `p_name` VARCHAR(50), IN `p_password` VARCHAR(50), IN `p_userid` INT, IN `p_id` INT)  NO SQL
BEGIN
IF EXISTS(SELECT * FROM users u WHERE u.id=p_id) THEN
	UPDATE users u SET 
    u.fullname=p_fullname,u.type=p_type,u.username=p_name,u.password=p_password,u.userd_id=p_userid
    WHERE u.id=p_id;
    SELECT "success|User Updated Successfully" msg; 

ELSE
	INSERT INTO `users`(`id`, `fullname`,`type`, `username`, `password`, `userd_id`) VALUES (NULL,p_fullname,p_type,p_name,p_password,p_userid);
    SELECT "success|User registered succesfully" msg;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_visit` (IN `p_patient_id` INT, IN `p_Visit_no` INT, IN `p_Amount` INT, IN `p_Doctor_id` INT, IN `p_Dateofsubmit` VARCHAR(50), IN `p_Department` VARCHAR(50), IN `p_id` INT)  NO SQL
BEGIN
IF EXISTS(SELECT * FROM visit v WHERE v.id=p_id) THEN
	UPDATE visit v SET 
    v.patient_id=p_patient_id,v.Visit_no=p_Visit_no,v.Amount=p_Amount,
    v.Doctor_id=p_Doctor_id,v.Dateofsubmit=p_Dateofsubmit,v.Department=p_Department
    WHERE v.id=p_id;
    SELECT "success|Visit Updated Successfully" msg; 

ELSE
	INSERT INTO `visit`(`id`, `patient_id`,`Visit_no`, `Amount`,`Doctor_id`,`Dateofsubmit`,`Department`) VALUES (NULL,p_patient_id,p_Visit_no,p_Amount,p_Doctor_id,p_Dateofsubmit,p_Department);
    SELECT "success|Visit registered succesfully" msg;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_form` (IN `p_table` VARCHAR(50), IN `p_id` INT)  NO SQL
BEGIN
if p_table ="doctor" THEN
select
d.Doctor_ID"id",
d.DR_Name"doctorname",d.Department"department",
d.Email"email",d.Time_in"timein",d.Time_out"timeout",d.Days_of_work"daysofwork"
  from doctor d WHERE d.Doctor_ID=p_id;
  
  ELSEIF p_table ="nurse" THEN
select
n.id"id",
n.Name"nursename",n.Shift_in"nurseshiftin",
n.Shift_out"nurseshiftout",n.Type"nursetype",n.Description"nursedescription"
  from nurse n WHERE n.id=p_id;
  
ELSEIF p_table ="test" THEN
select
t.PID"id",t.Test_Type"testtype",t.Result"result",
t.Test_Price"testprice"
  from test t WHERE t.PID=p_id;
  
  
  
	ELSEIF p_table ="pharmacy" THEN
select
ph.ID"id",ph.Treatement_Name"Treatment Name",ph.Qty"Quantity",
ph.Type"Type",ph.Price"Price",ph.Description"Description"
  from pharmacy ph WHERE ph.ID=p_id;
  
  ELSEIF p_table ="patients" THEN
select
p.id"id",p.name"Patient_Name",p.age"Patient_Age",
p.gender"Patient_Gender",p.tell"Tell",p.date_of_Admin"Date_Of_Admin"
,p.department"Department",p.visit_no"Visit_NO",p.Amount"Amount"
  from patients p WHERE p.id=p_id;
  
  ELSEIF p_table ="surgery" THEN
select
s.id"id",s.Surgery_Type"Surgery_Type",s.DR_Name"Doctor_Name",s.Sing_Person"Sign_Patient"
  from surgery s WHERE s.id=p_id;
  
    ELSEIF p_table ="rooms" THEN
select
rm.id"id",rm.room_type"Room_Type",rm.price"Price",rm.daysofstay"Days_Of_Stay"
  from rooms rm WHERE rm.id=p_id;
  
      ELSEIF p_table ="cashier" THEN
select
c.id"id",c.name"Patient_Name ",c.pharmacy_price"Pharmacy_Price",c.Room_price"Room_Price"
,c.Surgery_Price"Surgery_Price",c.Test_Price"Test_Price"
,c.dateofrecieve"Date_Of_Recieve",c.total"Total"
  from cashier c WHERE c.id=p_id;
  
   ELSEIF p_table ="users" THEN
select
u.id"id",u.fullname"User_Full_Name",u.type"User_Type",u.username" User_Name"
,u.password"User_Password",u.userd_id"user_id"

  from users u WHERE u.id=p_id;
  
 END IF;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `Visit_no` (`_from` DATE, `_to` DATE) RETURNS DATE BEGIN
SET @visit = 1;

SELECT v.visit_no + 1 INTO @visit FROM patient v ORDER BY visit_no DESC LIMIT 1;


RETURN @visit;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `cashier`
--

CREATE TABLE `cashier` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `pharmacy_price` int(11) DEFAULT NULL,
  `Room_price` int(11) DEFAULT NULL,
  `Surgery_Price` int(11) DEFAULT NULL,
  `Test_Price` int(11) DEFAULT NULL,
  `dateofrecieve` varchar(50) DEFAULT NULL,
  `total` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cashier`
--

INSERT INTO `cashier` (`id`, `name`, `pharmacy_price`, `Room_price`, `Surgery_Price`, `Test_Price`, `dateofrecieve`, `total`) VALUES
(1, 'aa', 0, 0, 0, 0, '2022-03-26', 22),
(2, 'zal', 22, 2222, 22, 22, '2022-03-31', 2222);

-- --------------------------------------------------------

--
-- Table structure for table `death`
--

CREATE TABLE `death` (
  `id` int(11) NOT NULL,
  `pid` int(11) DEFAULT NULL,
  `pname` varchar(50) DEFAULT NULL,
  `date_of_admin` varchar(50) DEFAULT NULL,
  `date_of_death` varchar(50) DEFAULT NULL,
  `reason` varchar(100) DEFAULT NULL,
  `descriptions` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `doctor`
--

CREATE TABLE `doctor` (
  `Doctor_ID` int(11) NOT NULL,
  `DR_Name` varchar(50) DEFAULT NULL,
  `Department` varchar(50) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Time_in` varchar(50) DEFAULT NULL,
  `Time_out` varchar(50) DEFAULT NULL,
  `Days_of_work` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `doctor`
--

INSERT INTO `doctor` (`Doctor_ID`, `DR_Name`, `Department`, `Email`, `Time_in`, `Time_out`, `Days_of_work`) VALUES
(1, 'zakariye abdi salan', 'qaliinka indhaha', 'zahra2001warda@gmail.com', '23', '21', '5'),
(2, 'Dr.mohamed abdi salan', 'qaliinka wadnaha', 'mohamed@gmail.com', '6:00', '12:00', '5'),
(3, 'jamilo xassan mohamed', 'labafaha', 'zahra2001warda@gmail.com', '8:30', '11:00', '2'),
(4, 'fadumo xassan mohamed', 'ilkaha', 'fad@gmail.com', '8:30', '11:00', '2');

-- --------------------------------------------------------

--
-- Table structure for table `nurse`
--

CREATE TABLE `nurse` (
  `id` int(11) NOT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Shift_in` varchar(50) DEFAULT NULL,
  `Shift_out` varchar(50) DEFAULT NULL,
  `Type` varchar(50) DEFAULT NULL,
  `Description` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `nurse`
--

INSERT INTO `nurse` (`id`, `Name`, `Shift_in`, `Shift_out`, `Type`, `Description`) VALUES
(1, 'zahra', '776', '44', 'subax', 'rsjjkshdgydgyhxz'),
(2, 'zass', '454', '4545', 'zajsjdhsj', 'jdhsjdsjhdash'),
(3, 'zahra', '776', '44', 'subax', 'rsjjkshdgydgyhxz');

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `PID` int(11) NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Age` varchar(100) DEFAULT NULL,
  `Gender` varchar(100) DEFAULT NULL,
  `Tell` varchar(100) NOT NULL,
  `Date_of_Admin` varchar(100) DEFAULT NULL,
  `Department` varchar(100) DEFAULT NULL,
  `Visit_no` varchar(100) NOT NULL,
  `Amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

CREATE TABLE `patients` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `age` varchar(50) DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `tell` varchar(50) DEFAULT NULL,
  `date_of_Admin` varchar(50) DEFAULT NULL,
  `department` varchar(50) DEFAULT NULL,
  `visit_no` int(11) DEFAULT NULL,
  `Amount` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `patients`
--

INSERT INTO `patients` (`id`, `name`, `age`, `gender`, `tell`, `date_of_Admin`, `department`, `visit_no`, `Amount`) VALUES
(1, 'aa', '2', 'female', '2121288', '2022-03-17', 'yu', 1, 1),
(2, 'skjs', '33', 'female', '8746', '2022-03-04', 'asssa', 2, 11),
(3, 'skjs', '33', 'female', '39845758', '2022-03-09', 'ttt', 2, 100);

-- --------------------------------------------------------

--
-- Table structure for table `pharmacy`
--

CREATE TABLE `pharmacy` (
  `ID` int(11) NOT NULL,
  `Treatement_Name` varchar(50) DEFAULT NULL,
  `Qty` int(11) DEFAULT NULL,
  `Type` varchar(50) DEFAULT NULL,
  `Price` int(11) DEFAULT NULL,
  `Description` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pharmacy`
--

INSERT INTO `pharmacy` (`ID`, `Treatement_Name`, `Qty`, `Type`, `Price`, `Description`) VALUES
(1, 'dooo', 2, 'indian', 3134, 'qswjdhcd'),
(2, 'hadashdg', 0, 'sdjhsj', 0, 'skdhsj'),
(3, 'hadashdg', 3, 'sdjhsj', 23, 'skdhsj');

-- --------------------------------------------------------

--
-- Table structure for table `progress_note`
--

CREATE TABLE `progress_note` (
  `PID` int(11) DEFAULT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Age` varchar(100) DEFAULT NULL,
  `Registred_Nurse` varchar(100) DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `Diagnosis` varchar(100) DEFAULT NULL,
  `progress_note` varchar(100) DEFAULT NULL,
  `Descriptions` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `id` int(11) NOT NULL,
  `room_type` varchar(50) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `daysofstay` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`id`, `room_type`, `price`, `daysofstay`) VALUES
(1, 'aa', 0, 'as'),
(2, 'aa', 0, 'as'),
(3, 'aa', 55, 'as');

-- --------------------------------------------------------

--
-- Table structure for table `surgery`
--

CREATE TABLE `surgery` (
  `id` int(11) NOT NULL,
  `Surgery_Type` varchar(50) DEFAULT NULL,
  `DR_Name` varchar(50) DEFAULT NULL,
  `Sing_Person` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `surgery`
--

INSERT INTO `surgery` (`id`, `Surgery_Type`, `DR_Name`, `Sing_Person`) VALUES
(1, 'sanss', 'snabsvb', 'ajhsgahsg'),
(2, 'sanss', 'hfg', 'hgf');

-- --------------------------------------------------------

--
-- Table structure for table `test`
--

CREATE TABLE `test` (
  `PID` int(11) NOT NULL,
  `Test_Type` varchar(50) DEFAULT NULL,
  `Result` varchar(50) DEFAULT NULL,
  `Test_Price` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `test`
--

INSERT INTO `test` (`PID`, `Test_Type`, `Result`, `Test_Price`) VALUES
(1, 'kaadi', 'positive', 23),
(2, 'dheecaan', 'positive', 23),
(3, 'ghj', 'g', 0),
(4, 'ghj', 'g', 5678);

-- --------------------------------------------------------

--
-- Table structure for table `treatment`
--

CREATE TABLE `treatment` (
  `PID` int(11) DEFAULT NULL,
  `Days_of_stay` varchar(100) DEFAULT NULL,
  `Start_date` date DEFAULT NULL,
  `Drugs` varchar(100) DEFAULT NULL,
  `Hours` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `fullname` varchar(100) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `userd_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `fullname`, `type`, `username`, `password`, `userd_id`) VALUES
(1, 'zahra abdirahman yasin', '1', 'admin', 'admin', 1),
(2, 'zahra abdi', '2', 'zahra', 'zahra', 2),
(3, 'zahra ali', '2', 'zahra', '12345', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_type`
--

CREATE TABLE `user_type` (
  `id` int(11) NOT NULL,
  `usertype` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_type`
--

INSERT INTO `user_type` (`id`, `usertype`) VALUES
(1, 'admin'),
(2, 'lab'),
(3, 'doctor\r\n'),
(4, 'pharmacy'),
(5, 'nurse');

-- --------------------------------------------------------

--
-- Table structure for table `visit`
--

CREATE TABLE `visit` (
  `id` int(11) NOT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `Visit_no` int(11) DEFAULT NULL,
  `Amount` int(11) DEFAULT NULL,
  `Doctor_id` int(11) DEFAULT NULL,
  `Dateofsubmit` varchar(50) DEFAULT NULL,
  `Department` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cashier`
--
ALTER TABLE `cashier`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `death`
--
ALTER TABLE `death`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `doctor`
--
ALTER TABLE `doctor`
  ADD PRIMARY KEY (`Doctor_ID`);

--
-- Indexes for table `nurse`
--
ALTER TABLE `nurse`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`PID`);

--
-- Indexes for table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pharmacy`
--
ALTER TABLE `pharmacy`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `progress_note`
--
ALTER TABLE `progress_note`
  ADD KEY `PID_fkk` (`PID`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `surgery`
--
ALTER TABLE `surgery`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `test`
--
ALTER TABLE `test`
  ADD PRIMARY KEY (`PID`);

--
-- Indexes for table `treatment`
--
ALTER TABLE `treatment`
  ADD KEY `PID_fk_treat` (`PID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_type`
--
ALTER TABLE `user_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `visit`
--
ALTER TABLE `visit`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cashier`
--
ALTER TABLE `cashier`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `doctor`
--
ALTER TABLE `doctor`
  MODIFY `Doctor_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `nurse`
--
ALTER TABLE `nurse`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `patients`
--
ALTER TABLE `patients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `pharmacy`
--
ALTER TABLE `pharmacy`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `surgery`
--
ALTER TABLE `surgery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `test`
--
ALTER TABLE `test`
  MODIFY `PID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user_type`
--
ALTER TABLE `user_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `visit`
--
ALTER TABLE `visit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `progress_note`
--
ALTER TABLE `progress_note`
  ADD CONSTRAINT `PID_fkk` FOREIGN KEY (`PID`) REFERENCES `patient` (`PID`);

--
-- Constraints for table `treatment`
--
ALTER TABLE `treatment`
  ADD CONSTRAINT `PID_fk_treat` FOREIGN KEY (`PID`) REFERENCES `patient` (`PID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
