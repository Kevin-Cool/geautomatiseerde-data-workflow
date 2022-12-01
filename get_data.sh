# Set the directorie
directorie="C:\Users\kevin\Documents\school\2022-2023\semester 1\3 Linux for Data Scientists\Proof-of-concept geautomatiseerde data workflow\rawdata"
# Get json from api 
curl -X GET https://data.stad.gent/api/records/1.0/search/?dataset=api-luftdateninfo -H "Accept: application/json" -o "$directorie"/"rawdata-$(date +%Y%m%d-%H%M%S).json"