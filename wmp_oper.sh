# 为含有http关键字的行，增加html注释
# <!--  -->
for i in $(cat filename.txt)
do
	sed -i '/http:/s/^/<!-- /g' $i
	sed -i '/http:/s/$/ -->/g' $i
done


