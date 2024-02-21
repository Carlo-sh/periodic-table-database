#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z $1 ]]; then
  echo Please provide an element as an argument.
else
  if [[ $1 =~ ^[0-9]+$ ]]; then
    ELEMENT=$($PSQL "SELECT * FROM elements FULL JOIN properties USING(atomic_number) WHERE atomic_number = $1")

    if [[ -z $ELEMENT ]]; then
      echo I could not find that element in the database.
    else
      echo $ELEMENT | while read ATOMIC_NUM BAR SYMBOL BAR NAME BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE_ID
      do
        echo "The element with atomic number $ATOMIC_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      done
    fi

  else
    ELEMENT=$($PSQL "SELECT * FROM elements FULL JOIN properties USING(atomic_number) WHERE symbol = '$1' OR name = '$1'")

    if [[ -z $ELEMENT ]]; then
      echo I could not find that element in the database.
    else
      echo $ELEMENT | while read ATOMIC_NUM BAR SYMBOL BAR NAME BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE_ID
      do
        echo "The element with atomic number $ATOMIC_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      done
    fi
  fi
fi
