#!/bin/bash
 
# Accept CreditCard as argument to script
card_number=$1
 
# function luhn_validate from rosettacode.org
function luhn_validate  # <numeric-string>
{
    num=$1
    shift 1
 
    len=${#num}
    is_odd=1
    sum=0
    for((t = len - 1; t >= 0; --t)) {
        digit=${num:$t:1}
 
        if [[ $is_odd -eq 1 ]]; then
            sum=$(( sum + $digit ))
        else
            sum=$(( $sum + ( $digit != 9 ? ( ( 2 * $digit ) % 9 ) : 9 ) ))
        fi
 
        is_odd=$(( ! $is_odd ))
    }
 
    # NOTE: returning exit status of 0 on success
    return $(( 0 != ( $sum % 10 ) ))
}
 
 

if luhn_validate "$card_number"; then
    echo "$card_number passes a Luhn check. Submitting to binlist for additional information..."
	IIN_BIN=${card_number:0:6} # Cut the first 6 characters for submission to binlist
	BINLIST_OUT=$(wget -qO- http://www.binlist.net/xml/$IIN_BIN) # get XML formatted output
	
	#Check for a zero length return from binlist
	if [ -z "$BINLIST_OUT" ]; then
		echo "No additional information is available."
		exit
	else
		printf "Card Brand: "; echo $BINLIST_OUT | xmllint --xpath "string(//Brand)" - ; echo ""
		printf "Country: "; echo $BINLIST_OUT | xmllint --xpath "string(//CountryName)" - ; echo ""
		printf "Issuing Bank: "; echo $BINLIST_OUT | xmllint --xpath "string(//Bank)" - ; echo ""
		printf "Card Type: "; echo $BINLIST_OUT | xmllint --xpath "string(//CardType)" - ; echo ""
	fi

else
    echo "$card_number failed the Luhn check."
fi

 