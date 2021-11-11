echo "Computing temperature in celsius"
echo "Enter the temperature in Farenheit"
read far
const1=`echo 5/9 | bc`
const2=`expr $far - 32`
cel=`echo "$const1 * $const2" | bc`

echo "The temperature in celsius = $cel"
