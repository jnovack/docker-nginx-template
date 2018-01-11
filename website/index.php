<?php
    header('Content-Type: application/json');
    echo json_encode($_ENV, JSON_PRETTY_PRINT);
?>