#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c"

# Match atomic_number, symbol or name
if [[ $1 ]]
then
  # If atomic_number
  if [[ $1 =~ ^[0-9]+$ ]]
  then
  ELEMENT_NUM=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number = $1")
    if [[ -n $ELEMENT_NUM ]]
    then
    echo $ELEMENT_NUM | while IFS=\| read ATOMIC_NUMBER NAME SYMBOL TYPE ATOMIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS
    do
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
    done
    fi
    if [[ -z $ELEMENT_NUM ]]
    then
    echo "I could not find that element in the database."
    fi
  fi 
  # If symbol
  if [[ ! $1 =~ ^[0-9]+$ ]]
  then
    ELEMENT_SYM=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol = '$1'")
    if [[ -n $ELEMENT_SYM ]]
    then
    echo $ELEMENT_SYM | while IFS=\| read ATOMIC_NUMBER NAME SYMBOL TYPE ATOMIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS
    do
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
    done
    fi
    # If name
    if [[ -z $ELEMENT_SYM ]]
    then
    ELEMENT_NAME=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE name = '$1'")
    if [[ -n $ELEMENT_NAME ]]
    then
    echo $ELEMENT_NAME | while IFS=\| read ATOMIC_NUMBER NAME SYMBOL TYPE ATOMIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS
    do
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
    done
    fi
    if [[ -z $ELEMENT_NAME ]]
    then
    echo "I could not find that element in the database."
    fi
    fi
  fi
else
echo "Please provide an element as an argument."
fi
