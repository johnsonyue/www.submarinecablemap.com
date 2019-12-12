json2csv(){
# cc2cbl
ls ./public/api/v2/country/*.json | grep -v 'search.json' | xargs -n 1 cat | jq -r '.name as $name | .cables[] | "\($name)|\(.id)"' >cc2cbl.csv

# cc2lp
ls ./public/api/v2/country/*.json | grep -v 'search.json' | xargs -n 1 cat | jq -r '.name as $name | .landing_points[] | "\($name)|\(.id)"' >cc2lp.csv

# cable
ls ./public/api/v2/cable/*.json | grep -vE 'all.json|cable-geo.json' | xargs -n 1 cat | jq -r '"\(.id)|\(.name)|\(.owners)|\(.length)"' >cbl.csv

# landing points
ls ./public/api/v2/landing-point/*.json | grep -vE 'all.json|landing-point-geo.json' | xargs -n 1 cat | jq -r '"\(.id)|\(.name)|\(.city_id)|\(.latitude)|\(.longitude)|\(.type)"' >lp.csv

#cbl2lp
ls ./public/api/v2/cable/*.json | grep -vE 'all.json|cable-geo.json' | xargs -n 1 cat | jq -r '.id as $cable_id | .landing_points[] | "\($cable_id)|\(.id)"' >cbl2lp.csv

#lp2cbl
ls ./public/api/v2/landing-point/*.json | grep -vE 'all.json|landing-point-geo.json' | xargs -n 1 cat | jq -r '.id as $id | .cables[] | "\($id)|\(.cable_id)"' >lp2cbl.csv
}

json2csv
