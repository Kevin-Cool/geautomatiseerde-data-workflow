# Set location
directorie="C:\Users\kevin\Documents\school\2022-2023\semester 1\3 Linux for Data Scientists\Proof-of-concept geautomatiseerde data workflow\rawdata"
# Get all files | remive dublicates | keep only usefull info and convert to csv
jq -s 'map(.records[]) ' rawdata/* | jq -s '.[] | unique' | jq -r '["value_type","value","timestamp","is_indoor","x","y"] , (.[] | [.fields.value_type, .fields.value, .fields.timestamp, .fields.is_indoor, .fields.location[0], .fields.location[1] ]) | @csv' > cleandata/cleandata.csv