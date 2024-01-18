# -*- coding: utf-8 -*-
"""
Created on Wed Dec 20 12:18:22 2023

@author: Harshana
"""

import smtplib
import getpass



def sendmail(mail,otp):
    HOST = "smtp-mail.outlook.com"
    PORT = 587
    
    FROM_EMAIL = "harshanabasheer@outlook.com"
    TO_EMAIL = mail
    PASSWORD = "Achi123@"
    
    SUBJECT = "OTP Verification"
    BODY ="your One time password is "+str( otp)
    
    message = f"Subject: {SUBJECT}\n\n{BODY}"
    
    smtp = smtplib.SMTP(HOST, PORT)
    
    status_code, response = smtp.ehlo()
    print(f"[*] Echoing the server: {status_code} {response}")
    
    status_code, response = smtp.starttls()
    print(f"[*] Starting TLS connection: {status_code} {response}")
    
    status_code, response = smtp.login(FROM_EMAIL, PASSWORD)
    print(f"[*] Logging in: {status_code} {response}")
    
    smtp.sendmail(FROM_EMAIL, TO_EMAIL, message)
    smtp.quit()
    
