*** Settings ***
Resource            ../resources/keywords.robot
Suite Setup          Setup Browser
Suite Teardown       End suite



*** Test Cases ***

In_the_swim_demo
    [tags]              playing
	Appstate       	    Frontpage
	HoverText      	    Chemicals
	ClickText      	    Pool Algaecides
	ClickText           In The Swim Pool Algaecide
	# Verify that quantity for item Y1004 is 1.. Use item nro as anchor
	VerifyInputValue    QTY:            1       anchor=Y1004
	# Buy 35 and add to cart:
	TypeText            QTY:            35      anchor=Y1004
	ClickText           ADD TO CART             anchor=Y1004
	# Some basic verifications:
	VerifyTexts         Description: 2 x 1/2 gallons, $39.99, 35, $1,399.65, View Cart (35)
	# Get Subtotal to variable.. We only want text after * : -chars
	${SUBTOTAL}         GetText         Estimated SUBTOTAL      between=* :???
	# and check that it's expected:
	ShouldBeEqual       $1,399.65       ${SUBTOTAL}
	ClickText           View Cart
	# Table elements can be handle as is if we want to be specific
	# Pick table instance using some text that are inside of it
	UseTable            Description
	# Verify things from table..  r?xxx/c? = row that contains given text, cell 2
	VerifyTable         r?Y1004/c2      In The Swim Pool Algaecide*
	VerifyTable         r?Y1004/c3      Y1004
	VerifyTable         r?Y1004/c4      $39.99
	# If input element, use VerifyInputValue instead of table
	VerifyInputValue    r?Y1004/c5      35
	VerifyTable         r?Y1004/c6      $1,399.65
	# Get tell text to variable..:
	${TOTAL}            GetCellText     r?Y1004/c6
	# ..Let's compare saved total to subtotal we saved earlier:
	ShouldBeEqual       ${TOTAL}        ${SUBTOTAL}
	# Checkout, give invalid email and try to proceed:
	ClickText           CHECK OUT
	ClickText           GUEST CHECKOUT
	TypeText            First Name      Qentir
	TypeText            Last Name       Robot
	TypeText            Email           foobar@testing
	# Switch checkbox to off
	ClickCheckbox       I agree         off
	# Verify it's off
	VerifyCheckboxValue  I agree        off
	ClickText           CONTINUE
	# Verify that validation works and error message exists
	VerifyText          Please fill the valid Email


