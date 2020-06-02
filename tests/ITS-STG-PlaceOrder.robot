*** Settings ***
Resource            ../resources/keywords.robot
Suite Setup          Setup Browser
Suite Teardown       End suite



*** Test Cases ***

ITS_HomePage
    [tags]              playing
	Appstate       	    Frontpage
	HoverText      	    Chemicals
	ClickText      	    Pool Algaecides
ITS_PLPPage
	ClickText           In The Swim Pool Algaecide
ITS_PDPPage	
	# Verify that quantity for item Y1004 is 1.. Use item nro as anchor
	VerifyInputValue    QTY:            1       anchor=Y1004
	# Buy 10 and add to cart:
	TypeText            QTY:            10      anchor=Y1004
	ClickText           ADD TO CART             anchor=Y1004
ITS_YourShoppingCartPopub	
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
	ClickText           GUEST CHECKOUT
ITS_ShippingAddressPage	
	TypeText            First Name      ITS
	TypeText            Last Name       TEST
	TypeText            Email           qentineltest01@mail.com
	# Switch checkbox to off
	ClickCheckbox       I agree         off
	# Verify it's off
	VerifyCheckboxValue  I agree        off
	# Verify Country Dropdown
	#VerifySelectedOption		r1Country/c?		United States
	TypeText	Address	2352 Test Street
	TypeText            City           New York
	DROPDOWN            shippingAddress_state          California
	TypeText           Zip/Postal Code  55632
	ClickCheckbox	Also My Billing Address	on
	TypeText         Telephone        1234567890
	ClickText           CONTINUE
ITS_PaymentDetailsSection
	VerifyText	Payment Details
	DROPDOWN        Choose Card Type	Visa
	TypeText	Card Number	4263982640269299
	TypeText	Name On Card	TestCard
	TypeText	CVV/Security Code	123
	DROPDOWN	Month			06-Jun
	DROPDOWN	Year			2021
	ClickText	REVIEW ORDER
ITS_ReviewOrderPage
	VerifyTexts	ITEMS IN ORDER
	UseTable            Description
	VerifyTable         r?Y1004/c2      In The Swim Pool Algaecide*
	VerifyTable         r?Y1004/c3      $39.99
	VerifyTable         r?Y1004/c4      10
	VerifyInputValue    r?Y1004/c5      $399.90
	VerifyTable        r?Y1004/c6       $399.90
	# Get tell text to variable..:
	${TOTAL}            GetCellText     r?Y1004/c5
	# Get OrderTotal to variable.
	${ORDERTOTAL}         GetText         Your Order Total      between=???
	# and check that it's expected:
	ShouldBeEqual       $442.73       ${ORDERTOTAL}
	ClickText	PLACE ORDER
	VerifyTexts	Your Order is Processing
ITS_ThankyouPage
	VerifyTexts	Thank you for your order!
	${ORDERID}	GetText		Your Order ID is	between=???
	
	


