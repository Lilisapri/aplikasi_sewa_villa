<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <link rel="stylesheet" href="path/to/your/styles.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script> <!-- Include Chart.js -->
</head>
<body>
    <h1 class="text-light">Selamat Datang di <?php echo $_settings->info('name') ?></h1>
    <hr>
    <div class="container">
        <?php 
            $files = array();
            $rooms = $conn->query("SELECT * FROM `room_list` ORDER BY rand() ");
            while($row = $rooms->fetch_assoc()){
                if(!is_dir(base_app.'uploads/room_'.$row['id']))
                    continue;
                $fopen = scandir(base_app.'uploads/room_'.$row['id']);
                foreach($fopen as $fname){
                    if(in_array($fname,array('.','..')))
                        continue;
                    $files[]= validate_image('uploads/room_'.$row['id'].'/'.$fname);
                }
            }
        ?>
        <div id="tourCarousel" class="carousel slide" data-ride="carousel" data-interval="3000">
            <div class="carousel-inner h-100">
                <?php foreach($files as $k => $img): ?>
                <div class="carousel-item h-100 <?php echo $k == 0 ? 'active' : '' ?>">
                    <img class="d-block w-100" src="<?php echo $img ?>" alt="" style="object-fit: cover; height: 100%;">
                </div>
                <?php endforeach; ?>
            </div>
            <div class="carousel-caption d-none d-md-block">
                <h5>Explore Our Rooms</h5>
                <p>Experience comfort and luxury.</p>
            </div>
            <a class="carousel-control-prev" href="#tourCarousel" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#tourCarousel" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>

        <?php 
            // New code to fetch inquiries
            $inquiries = $conn->query("SELECT DATE(date_created) as inquiry_date, COUNT(*) as count FROM inquiry GROUP BY inquiry_date ORDER BY inquiry_date");
            $inquiryData = [];
            while($row = $inquiries->fetch_assoc()){
                $inquiryData[] = $row;
            }
        ?>
        
        <div class="row">
            <div class="col-md-6">
                <canvas id="inquiryChart" style="background-color: white; height: 300px;"></canvas>
            </div>
            <div class="col-md-6">
                <canvas id="userChart" style="background-color: white; height: 300px;"></canvas>
            </div>
        </div>

        <script>
            const ctx = document.getElementById('inquiryChart').getContext('2d');
            const labels = <?php echo json_encode(array_column($inquiryData, 'inquiry_date')); ?>;
            const data = {
                labels: labels,
                datasets: [{
                    label: 'Number of Inquiries',
                    data: <?php echo json_encode(array_column($inquiryData, 'count')); ?>,
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 1,
                    fill: false // Disable filling under the line for a line chart
                }]
            };
            const inquiryChart = new Chart(ctx, {
                type: 'line', // Change to line chart
                data: data,
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        </script>

        <?php 
            // New code to fetch user data for bar chart
            $users = $conn->query("SELECT DATE(date_added) as user_date, COUNT(*) as count FROM users GROUP BY user_date ORDER BY user_date");
            $userData = [];
            while($row = $users->fetch_assoc()){
                $userData[] = $row;
            }
        ?>
        
        <script>
            const userCtx = document.getElementById('userChart').getContext('2d');
            const userLabels = <?php echo json_encode(array_column($userData, 'user_date')); ?>;
            const userDataSet = {
                labels: userLabels,
                datasets: [{
                    label: 'Number of Users',
                    data: <?php echo json_encode(array_column($userData, 'count')); ?>,
                    backgroundColor: 'rgba(153, 102, 255, 0.2)',
                    borderColor: 'rgba(153, 102, 255, 1)',
                    borderWidth: 1,
                    fill: true // Enable filling under the bar for a bar chart
                }]
            };
            const userChart = new Chart(userCtx, {
                type: 'bar', // Change to bar chart
                data: userDataSet,
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        </script>
    </div>
</body>
</html>