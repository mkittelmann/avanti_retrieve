# Avanti retrieve
Generates XML workflow file for conv.pl to download all records within an identifier range. 

###### Version
1.0

###### Usage
Parameters:
(mandatory)
identifier_pattern [permitted valued: 'cnp', 'cni', 'cnc', 'cnl', 'caf']
range_from
range_to
(optional)
connection_profile [permitted values: 'auth' or 'ct_test', default: 'auth']

example:
ruby avanti_retrieve.rb cni 12345 12346

###### Dependencies
Requires Ruby >= 1.9.3 

no dependencies

###### License
GNU GPLv3 http://www.gnu.org/licenses/agpl-3.0.txt