echo "To compute number of even and odd numbers"
echo "Enter value of n"
read n
i=2
while [ $i -le $n ]
do
	sum=`expr $sum + $i`
	i=`expr $i + 2`
done
echo "sum of even numbers = $sum"

i=1
sum=0
while [ $i -le $n ]
do
	sum=`expr $sum + $i`
	i=`expr $i + 2`
done
echo "sum of odd numbers = $sum"
