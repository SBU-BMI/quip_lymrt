curl -X GET "http://quip-findapi:3000/?limit=1000000&db=quip&find=\{\"provenance.analysis.execution_id\":\
    \"humanmark\",\"provenance.image.case_id\":\"TCGA-MV-A51V-01Z-00-DX1\",\"properties.annotations.username\":\"joseph.balsamo@stonybrook.edu\"\}" \
    | awk -F'\\{\\"_id\\":' '{for(i=2;i<=NF;++i){print "\"_id\":"$i}}' \
    | awk -f raw_data_formating.awk | sort -k 5 -n

curl -X GET "http://quip-findapi:3000/?limit=1000000&db=quip&find=\{'provenance.analysis.execution_id':'humanmark','provenance.image.case_id':'TCGA-MV-A51V-01Z-00-DX1','properties.annotations.username':'joseph.balsamo@stonybrook.edu'\}" \
    | awk -F'\\{\\"_id\\":' '{for(i=2;i<=NF;++i){print "\"_id\":"$i}}' \
    | awk -f raw_data_formating.awk | sort -k 5 -n