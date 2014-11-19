<?php
public function request($url, $isPOST, $params, $isJSON)
        {
            $plainData;
            
            //Initiate cURL.
            $ch = curl_init($url);
             
            //The JSON data.
            // $jsonData = array(
            //     'username' => 'MyUsername',
            //     'password' => 'MyPassword'
            // );
             
            if($isJSON){
                //Encode the array into JSON.
                $plainData = json_encode($params);    
            }
            else{
                $plainData = http_build_query($params);
            }
            
            //echo $plainData;
            if($isPOST){
                //Tell cURL that we want to send a POST request.
                curl_setopt($ch, CURLOPT_POST, 1);
                curl_setopt($ch, CURLOPT_POSTFIELDS, $plainData);
            }
            else{
                // curl_setopt($ch, CURLOPT_HTTPGET, 1);
                // echo "::get";
            }
             
            //Attach our encoded JSON string to the POST fields.
            
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
            
             
            //Set the content type to application/json
            //curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/json')); 
             
            //Execute the request
            return curl_exec($ch);
}
?>