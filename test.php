<!DOCTYPE html>
<html>
    <head>
        <title>PHP MySQL Stored Procedure Demo 1</title>
        <link rel="stylesheet" href="css/table.css" type="text/css" />
    </head>
    <body>
        <?php
        include './config/db_connection.php';


        $conn = OpenCon("root","");
        try {
            
            $sql = 'CALL GetCustomers()';
            // call the stored procedure
            $q = $conn->query($sql);
            $q->setFetchMode(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            die("Error occurred:" . $e->getMessage());
        }
        ?>
        <table>
            <tr>
                <th>Customer Name</th>
                
            </tr>
            <?php while ($r = $q->fetch()): ?>
                <tr>
                    <td><?php echo $r['first_name'] ?></td>
                    
                    </td>
                </tr>
            <?php endwhile; ?>
        </table>
    </body>
</html>