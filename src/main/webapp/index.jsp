<!DOCTYPE html>
<html>
    <head>
        <meta charset="US-ASCII">
        <title>Login Page</title>
        <script src="https://www.google.com/recaptcha/api.js"></script>
        <script src="http://apps.bdimg.com/libs/jquery/1.9.1/jquery.js"></script>
        <script>        
            var summary = "<table border='1'><tr><td>try count</td><td>url</td><td>result</td><td>value</td></tr>"; 
            var urls = "";
            
            $(document).ready(function() {
            	 
            	 $.ajax({                    
                     url: 'resource?goodat=<%=request.getParameter("goodat")%>',                                      
                     type: 'GET',                     
                     dataType: 'json',                    
                     success: function (data) {
                         urls = data.result;
                         go(urls[0], 0, urls.length);         
                     },                    
                     timeout: 1000
                 })
                
            });
            
            function go(url, tryCount, retryLimit) {
            	summary = summary + "<tr><td>" + tryCount + "</td><td>" + url + "</td>";
            	
                $.ajax({                    
                    url: url,   
                    tryCount: tryCount,
                    retryLimit: retryLimit,
                    retryTimeout: 1000,                     
                    type: 'GET',
                    dataType: 'json',                    
                    success: function (data) {
                        
                        switch (this.tryCount) {
                            case 0:
                                country = data.country_code;                                
                                break;
                            case 1:
                                country = data.country;                                
                                break;
                            case 2:
                                country = data.country.code;                               
                                break;                         
                        }
                        summary = summary + "<td>success</td><td>" + country + "</td></tr></table>";
                        $("#summary").html(summary);
                    },
                    error: function() {   
                    	summary = summary + "<td>fail</td><td></td></tr>";            
                        this.tryCount++;
                        if (this.tryCount < this.retryLimit) {
                            go(urls[this.tryCount], this.tryCount, this.retryLimit);                            
                            return;
                        }            
                        return;
                   
                    },
                    timeout: 1000
                })
            }                      
        </script>
    </head>
    <body>
        <div id="summary"></div>
    </body>
</html>