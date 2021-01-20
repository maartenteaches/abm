clear all
cd "d:\mijn documenten\projecten\stata\abm\abm"

include current_version.do
do abm_bc.mata

mata:
bc = abm_bc()
bc.vnr("1.0.0")
bc.vnr()
end