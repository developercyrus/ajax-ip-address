## Notes
1. Recursively ajax call to external ip-geo services. If one is failed, then call another. 
2. There're 3 external services: feepgeoip.net, ipinfo.io, and nekudo.com
3. To simulate the serivce is malfuntioned, I replace the protocol from "http" to "malformed" 
4. The servlet Resource is to produce the json by parameter "goodat". The value is the index that the service will not be replaced. If "goodat=2", the first two services will be replaced as 
```
{
    "result": ["malformed://freegeoip.net/json/?callback=?", "malformed://ipinfo.io/?callback=?", "http://geoip.nekudo.com/api/?callback="]
}
```
## Expected Result
```
http://localhost:8001/index.jsp?goodat=0
```
|try count|url|result|value
|---------|---|------|-----
|0|http://freegeoip.net/json/?callback=?|success|HK

```
http://localhost:8001/index.jsp?goodat=1

```
|try count|url|result|value
|---------|---|------|-----
|0|malformed://freegeoip.net/json/?callback=?|fail|
|1|https://ipinfo.io/?callback=?|success|HK

```
http://localhost:8001/index.jsp?goodat=2
```
|try count|url|result|value
|---------|---|------|-----
|0|malformed://freegeoip.net/json/?callback=?|fail|
|1|malformed://ipinfo.io/?callback=?|fail|
|2|http://geoip.nekudo.com/api/?callback=|success|HK
