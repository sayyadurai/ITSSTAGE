*** Settings ***
Resource            ../resources/keywords.robot
Suite Setup          Setup Browser
Suite Teardown       End suite



*** Test Cases ***

ITS_HomePage
    [tags]              playing
    	Run Keyword For		'int i=1;i<200;i++'
	Appstate       	    Frontpage
	LogScreenshot
	HoverText      	    Chemicals
	ClickText      	    Pool Algaecides
ITS_PLPPage
	LogScreenshot
	ClickText           In The Swim Pool Algaecide
ITS_PDPPage	
	# Verify that quantity for item Y1004 is 1.. Use item nro as anchor
	VerifyInputValue    QTY:            1       anchor=Y1004
	# Buy 10 and add to cart:
	TypeText            QTY:            10      anchor=Y1004
	LogScreenshot
	ClickText           ADD TO CART             anchor=Y1004
ITS_YourShoppingCartPopub	
	LogScreenshot
	# Some basic verifications:
	VerifyTexts         Description: 2 x 1/2 gallons, $39.99, 10, $399.90, View Cart (10)
	# Get Subtotal to variable.. We only want text after * : -chars
	${SUBTOTAL}         GetText         Estimated SUBTOTAL      between=* :???
	# and check that it's expected:
	ShouldBeEqual       $399.90       ${SUBTOTAL}
	ClickText           View Cart
	# Table elements can be handle as is if we want to be specific
	# Pick table instance using some text that are inside of it
ITS_ShoppingCartPage	
	LogScreenshot
	UseTable            Description
	# Verify things from table..  r?xxx/c? = row that contains given text, cell 2
	VerifyTable         r?Y1004/c2      In The Swim Pool Algaecide*
	VerifyTable         r?Y1004/c3      Y1004
	VerifyTable         r?Y1004/c4      $39.99
	# If input element, use VerifyInputValue instead of table
	VerifyInputValue    r?Y1004/c5      10
	VerifyTable         r?Y1004/c6      $399.90
	# Get tell text to variable..:
	${TOTAL}            GetCellText     r?Y1004/c6
	# ..Let's compare saved total to subtotal we saved earlier:
	ShouldBeEqual       ${TOTAL}        ${SUBTOTAL}
	# Checkout, give invalid email and try to proceed:
	ClickText           CHECK OUT
ITS_SecureCheckoutPage
	LogScreenshot
	TypeText           j_username   maaritest1@gmail.com
  TypeText           password     maari@1
  ClickText          LOGIN AND CHECKOUT
