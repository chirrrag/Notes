> execute the script using "bash command"
- we can create our shell script as a command, means by entering linux command, we will be able to execute our script. we can do this with the help of adding our script to path(appending the path variable) and removing the   ".sh" extension form script
    - example
        Script:- chirag.sh
    >   echo $PATH
    >   export PATH = /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/miachel
        better way to append our path is using $PATH variable instead of entering the entire path like:
    >   export PATH=$PATH:/home/miachel
    > once this is done, we can run our script as a command in any directory or anywhere in our system like any of the other builtin or external command.

> which <command>
    to see the location of the command, we run this command.

    we need to give "x" bit to our file to make it executeable
    > chmod +x <scriptpath>

## variable
    value that can changed,
    variable always have dollar sign with it
    variable_mission="promotion"
    echo $promotion

    > variable only contains, alphanumeric or underscore values, and is casesensitive
    we can also get output status of a command in some in variable:-
    rocket_status=$(rocket-status $mission-name)
    echo "status of launch: $rocket_status"
    cp $file_name ${file_name}_bkp

## command line arguments
    > command line arguments, are called $0, $1
    $0 is command itself , rest $1,$2,... are Command line args which can be used as variables

## read input
> read <variable_name>
> read -p "Enter variable value" <variable_name>
    this will prompt when we execute our script.
    is script is required to run independently, than read variable should be used, but if script is required not to run independently, than Command line arguments should be used. we can also use both read input and command line arguments in our script

## arithmetic operations in shell
> expr 6 + 3
    operator and value must be scrictly separated by a space.
> expr 6 - 3
> expr 6 / 3
> expr 6 \* 3
    * is a reserve reject character in a shell
we can also do arithmetic operations with variables as well
> A=6
> B=3
> expr $A + $B

another way
> echo $(( A + B ))
> echo $(( A-B ))
> echo $((A/B))
> echo $(( A * B ))
    WITHIN the parantheses we no longer need $ symbol as prefix with variable, also we no longer need to separate the operator and variables with a space, for multiplication we no longer need * with "\" for multiplication.

> echo $(( ++A ))
> echo $(( --A ))
> echo $(( A-- ))
> echo $(( a++ ))

NOTE :- both expr and double parantheses gives decimal output, they donot support floating point numbers

to generate floating point result, we use a utility basic calculator in linux:- bc -l
> A=10
> B=3
> expr $A / $B          :- will give 3
> echo $((A/B))         :- will give 3
> echo $A / $B | bc -l  :- will give 3.333

---
price=$(( $1 * $2 ))
echo "The total price for items is ${price} dollars"
---

# Conditional Logic
> Syntax:-
    if << some condition>>
    then
        <statements>
    fi

example:-
---
rocket_status=$(<some_commands>)
if [ $rocket_status = "failed" ]
then
    rocket-debug $mission_name 
elif [ $rocket_status = "success" ]
then
    echo "this is successful"
else
    echo "this state is not failed or success"
fi   
---

##     Conditional Operators
# ____________________________________________________
# Example                 |      Description
# ----------------------------------------------------
1. [ "abc" = "abc" ]            if string1 is exactly equals to string2
2. [ "abc" != "abc" ]           if string1 is not equal to string2
3. [ 5 -eq 5 ]                  if number1 is equal to number2
4. [ 5 -ne 5 ]                  if number1 is not equal to number2
5. [ 6 -gt 5 ]                  if num1 is greater than num2
6. [ 5 -lt 6 ]                  if num1 is less than num2

# AND operator
> [ cond1 ] && [ cond2 ]
> [[ cond1 && cond2 ]]
> [[ A -gt 4 && A -lt 10 ]]

# OR OPERATOR
> [ cond1 ] || [ cond2 ]
> [[ cond1 || cond2 ]]
> [[ A -gt 4 || A -lt 10]]

# more operators
# ____________________________________________________
# Example                 |      Description
# ----------------------------------------------------
> [ -e FILE ]                    if a file exist
> [ -d FILE ]                    if file exist and is a directory
> [ -s FILE ]                    If a file exist and has a size greater than 0
> [ -x FILE ]                    if a file is executable
> [ -w FILE ]                    if the file is writable

> Use -z $1 to check for command line argument. whether CLA is given or not.
check script :- print-month



# for loop
for iter in <list of iterators>
do
    <set of commands>
done

example:-
for iter in mission1 mission2 mission3 mission4 
do
    <set of commands $iter>
done
example:-
for iter in 1 2 3 4 5 6
do
    echo "${iter}"
done
---
we can also specify the range usind sequence expression
for iter in 1 2 3 4 5 .... 100
do 
    <stataement>
done

we can use the above for loop in sequence expression
for iter in {0..100}
do
    <set of commands>
done
---
Programming for loop is also possible as we use in C language
for (( missoin = 0 ; mission <= 100; mission++ ))
do
    <set of commands>
done


example:- read multiple lines from a file and put it into for-loop
for mission in `cat file.txt`
do
    create-and-launch-rocket $mission
done
--- 
instead of using backtick(`) in for loop command for reading file, we should use $() as we can embedd multiple commands into it, example:-
for mission in $(cat file.txt)
do
    create-and-launch-rocket $mission
done
---
real life example of for loop

for file in $(ls)
do
    echo Line count of $file is $(cat $file | wc -l)
done

for package in $(cat install-package.txt)
do
    sudo apt-get install $package
done

for server in $(cat servers.txt)
do
    ssh $server "uptime"
done

---
for file in $(ls images)
do
        if [[ $file = *.jpeg ]]
                then
                new_name=$(echo $file| sed 's/jpeg/jpg/g')
                mv images/$file images/$new_name
        fi
done
---

## while loop
while <conditions>
do
    <set of staments>
done

--- 
# break and continue statemenet in a loop

break in a loop whwther it is a for or while loop, breaks the program out and exits the loop.
continue statement takes the execution back the beginign of the looop

while [ $rocket_status = "launching" ]
do
  sleep 2
  rocket_status=$(rocket-status $mission_name)
done
---
to_number=$1
number=0
while [ $number -lt $to_number ]i
do
  echo $(( number++ ))
done
---
while true
do
  echo "1. Add"
  echo "2. Subtract"
  echo "3. Multiply"
  echo "4. Divide"
  echo "5. Quit"

  read -p "Enter your choice: " choice

  if [ $choice -eq 1 ]
  then
        read -p "Enter Number1: " number1
        read -p "Enter Number2: " number2
        echo Answer=$(( $number1 + $number2 ))
  elif [ $choice -eq 2 ]
  then
        read -p "Enter Number1: " number1
        read -p "Enter Number2: " number2
        echo Answer=$(( $number1 - $number2 ))
  elif [ $choice -eq 3 ]
  then
        read -p "Enter Number1: " number1
        read -p "Enter Number2: " number2
        echo Answer=$(( $number1 * $number2 ))
  elif [ $choice -eq 4 ]
  then
        read -p "Enter Number1: " number1
        read -p "Enter Number2: " number2
        echo Answer=$(( $number1 / $number2 ))
  elif [ $choice -eq 5 ]
  then
    break
  fi

done
---

## case statements
while true
do
    echo "1. Shutdown"
    echo "2. Restart"
    echo "3. exit menu"
    read -p "Enter your choice: " choice


    case $choice in
        1) shutdown now
           ;;
        2) shutdown -r now
           ;;
        3) break
           ;;
        *) continue
           ;;
    esac
done
---
month_number=$1

if [ -z $month_number ]
then
  echo "No month number given. Please enter a month number as a command line argument."
  echo "eg: ./print-month-number 5"
  exit
fi

if [[ $month_number -lt 1 || $month_number -gt 12 ]]
then
  echo "Invalid month number given. Please enter a valid number - 1 to 12."
  exit
fi

case $month_number in
  1) echo "January" ;;
  2) echo "February" ;;
  3) echo "March" ;;
  4) echo "April" ;;
  5) echo "May" ;;
  6) echo "June" ;;
  7) echo "July" ;;
  8) echo "August" ;;
  9) echo "September" ;;
  10) echo "October" ;;
  11) echo "November" ;;
  12) echo "December" ;;
esac
---
while true
do
  echo "1. Add"
  echo "2. Subtract"
  echo "3. Multiply"
  echo "4. Divide"
  echo "5. Average"
  echo "6. Quit"

  read -p "Enter your choice: " choice

  case $choice in
    1)
        read -p "Enter Number1: " number1
        read -p "Enter Number2: " number2
        echo Answer=$(( $number1 + $number2 ))
        ;;
    2)
        read -p "Enter Number1: " number1
        read -p "Enter Number2: " number2
        echo Answer=$(( $number1 - $number2 ))
        ;;

    3)
        read -p "Enter Number1: " number1
        read -p "Enter Number2: " number2
        echo Answer=$(( $number1 * $number2 ))
        ;;
    4)
        read -p "Enter Number1: " number1
        read -p "Enter Number2: " number2
        echo Answer=$(( $number1 / $number2 ))
        ;;
    5)
        read -p "Enter Number1: " number1
        read -p "Enter Number2: " number2
        sum=$(( number1 + number2 ))
        echo Answer=$(echo "$sum / 2" | bc -l)
        ;;
    6)
        break
        ;;
  esac

done
---
color=$1
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`


          case $color in
                    red) echo "${red}this is red${reset}";;
                    green) echo "${green}this is green${reset}";;
                    *) echo "red and green are the only choices"
            esac
---

for i in {31..40}
do
        echo $i
donebob@caleston-lp10:~$ sh loop.sh
{31..40}
# bash shell will print numbers 31 to 40
# bourne shell(sh) will print {31..40}
# use #!/bin/bash for shebang   
> echo `seq 1 10`

# exit status
> if command runs successfully :- Exit Status = 0
> if a commands fails :- "Exit Staus > 0"(generally 1 as exit code)

exit status is stored in a builtin variable :- "$?"

To check exit code of a command, run "echo $?" just after the command
command not found :- exit status:- 127
permission denied :- 126
if something failes:- 25


---
# FUNCTIONS IN LINUX
function definition:-
function launch-rocket() {
    mission_name=$1
    <set of statements>
    return 1
}
calling function and passing mission_name arg also capturing return statement 
launch-rocket lunar-mission
LUNAR_STATUS_CODE=$?
NOTE:- $1, and $2 are funcitons parameters here not the commadn line arguments

function add(){
    echo $(( $1 + $2 ))
}
sum=$( add 3 5 ) 
---

function add() {
    return $(( $1 + $2 ))
}
add 3 5
sum=$?
---
function prepare-directory-structure(){
  mkdir apps
  cd apps
  mkdir app1 app2 app3
  touch app1/logs app2/logs app3/logs
}

prepare-directory-structure
---
function add(){
  sum=$(( $1 + $2 ))
  echo $sum
}

result=$(add 3 5)
echo "The result is $result"
--- #!/bin/bash
function read_numbers(){
  read -p "Enter Number1: " number1
  read -p "Enter Number2: " number2
}

while true
do
  echo "1. Add"
  echo "2. Subtract"
  echo "3. Multiply"
  echo "4. Divide"
  echo "5. Quit"

  read -p "Enter your choice: " choice

  case $choice in
    1)  read_numbers
        echo $(( $number1 + $number2 )) ;;
    2)
        read_numbers
        echo $(( $number1 - $number2 )) ;;

    3)
        read_numbers
        echo $(( $number1 * $number2 )) ;;

    4)
        read_numbers
        echo $(( $number1 / $number2 )) ;;

    5)  break
  esac

done
---
function launch_rocket(){
  mission_name=$1

  mkdir $mission_name

  rocket-add $mission_name

  rocket-start-power $mission_name
  rocket-internal-power $mission_name
  rocket-start-sequence $mission_name
  rocket-start-engine $mission_name
  rocket-lift-off $mission_name

  rocket_status=$(rocket-status $mission_name)

  echo "The status of launch is $rocket_status"

  if [ $rocket_status = "launching" ]
  then
    sleep 2
    rocket_status=$(rocket-status $mission_name)
  fi

  if [ $rocket_status = "failed" ]
  then
    rocket-debug
    exit 1
  fi
}
launch_rocket $1



Utiltiy for shell scripting
yum install shellcheck 




