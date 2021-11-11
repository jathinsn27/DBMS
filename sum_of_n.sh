echo "Enter the value of n"
read n
i=0
while [ $i -le $n ]
do
	sum=`expr $sum + $i`
	i=`expr $i + 1`
done

echo "sum of n numbers = $sum" 
