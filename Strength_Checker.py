# coding=utf-8
import string
import sys


def check_contains(user_input, letters):
    return any(char in letters for char in user_input)


def strength_checker(user_input):
    valid_pw = True

    # Checks if password is at least 8 characters long
    if len(user_input) < 8:
        valid_pw = False
        print ' - Password needs to be at least 8 characters in length. Consider lengthening for a more secure password'

    # Checks if password contains UPPERCASE
    if not check_contains(user_input, string.ascii_uppercase):
        valid_pw = False
        print ' - Password requires at least one UPPERCASE character. Consider adding one for a more secure password'

    # Checks if password contains lowercase
    if not check_contains(user_input, string.ascii_lowercase):
        valid_pw = False
        print ' - Password needs at least one lowercase character. Consider adding one for a more secure password'

    # Checks if password contains a number
    if not check_contains(user_input, string.digits):
        valid_pw = False
        print ' - Password is missing a number. Consider adding one for a more secure password'

    # Checks if password contains special character
    if not check_contains(user_input, string.punctuation):
        valid_pw = False
        print ' - Password is missing a special character such as ()!\"£$%^&*?@#. Consider adding one '
        print '  for a more secure password'

    # If User enters quit, program exits to Fetch Main Menu
    if user_input == 'quit':
        valid_pw = False
        sys.exit(1)

    return valid_pw


while True:
    print'Please enter your Windows password for testing.'
    print'Alternatively, enter \'quit\' to exit to the Fetch main menu'
    password = raw_input('----> ')
    if strength_checker(password):
        print ' - Your password meets all criteria and is considered strong'
        print ''
        break
