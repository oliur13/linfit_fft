fpn = ["posm02" "posm04" "posm06"  "posm08"  "posm10"  "posp02"  "posp04"  "posp06"  "posp08"]
basedir='../../../../rnahome/tmbshare/public_html/sims/601/WT/'
%%basedir='~tmbshare/public_html/sims/601/WT/'

figure 
hold on
dataid = 0
for i = fpn
    dataid = dataid+1;
    fp=strcat(basedir +  i + '/hps.hd5')

pmid = strlength(i)-2;
if(extract(i,pmid) == "p")
    pm = -1
else
    pm=1
end
shift = str2num(extractAfter(i,4))
xmin = 15 +pm*shift
xmax = xmin + 146

plot(mean(h5read(fp,'/inter').Roll(xmin:xmax,1:100:100000),2))

end
legend(fpn)
hold off

