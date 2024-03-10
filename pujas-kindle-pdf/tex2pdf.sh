#!/bin/bash
find ../pujas -name "*.tex" | grep -v old | grep -v MahaNyasah | grep -v rudra-prashnah | grep -v ekadashi.tex | while read fpath
do
fname=`basename $fpath`
echo "---------------------------------------------------------------"
echo "File path         : $fpath"
# jobname=`echo $fpath | sed 's/.tex//;s@../pujas/@@'`
jobname=${fname/.tex/}
echo "PDF target        : $jobname.pdf"
mkdir -p `dirname $jobname`
if [[ $fpath -nt $jobname.pdf ]] || [[ puja-kindle-template.tex -nt $jobname.pdf ]] || [[ shloka.sty -nt $jobname.pdf ]] 
then
echo Rebuilding $jobname.pdf... > /dev/stderr
echo Rebuilding $jobname.pdf...
cat puja-kindle-template.tex ../pujas/$fname | sed 's@pujas/@../pujas/@;s@kathas/@../kathas/@;s@purvanga@../purvanga@;s@../stotra@../../stotra@;s@../appendices@../../appendices@;s@../veda@../../veda@;s@../namavali@../../namavali@;$a\\\\end{document}' > $jobname-vidhanam.tex
latexmk -xelatex $jobname-vidhanam.tex -f
else
echo PDF up-to-date.
fi
done > tex2pdf.log
