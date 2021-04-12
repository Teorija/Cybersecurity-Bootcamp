#!/bin/bash

if [ "$3" = "blackjack" ]	
then
	grep "$1" $2_Dealer_schedule | awk '{print $1,$2,$3,$4}'
fi
if [ "$3" = "roulette" ]
then
       	grep "$1" $2_Dealer_schedule | awk '{print $1,$2,$5,$6}'
fi
if [ "$3" = "texas holdem" ]
then
        grep "$1" $2_Dealer_schedule | awk '{print $1,$2,$7,$8}'
fi

