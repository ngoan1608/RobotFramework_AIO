texlive_packages=(
"multirow"
"booktabs"
"framed"
"fvextra"
"courier"
"efbox"
"grffile"
"pdfpages"
"tcolorbox"
"wasysym"
"wasy"
"fancyvrb"
"xcolor"
"etoolbox"
"upquote"
"lineno"
"eso-pic"
"lstaddons"
"pdflscape"
"infwarerr"
"pgf"
"environ"
"trimspaces"
"listings"
"pdfcol"
)
extra_packages=""
for package in ${texlive_packages[@]}; do
  extra_packages+="$package,"
done

choco install texlive --version=2022.20221202 --params "'/collections:pictures,latex'" --execution-timeout 5400

# cat C:/ProgramData/chocolatey/logs/chocolatey.log

tlmgr="C:/texlive/2022/bin/win32/tlmgr.bat"

# Update TeX Live package database
$tlmgr update --self --all

# Install each package in the list
for package in ${texlive_packages[@]}; do
  $tlmgr install "$package"
done

export texlive_packages
