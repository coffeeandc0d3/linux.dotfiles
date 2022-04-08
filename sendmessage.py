#!/usr/bin/env python
'''A script that sends the contents of a file in a plain-text email.'''

# Imports
import smtplib
import sys

# Important constants.
FROM_ADDR = '@'
FROM_PASS = ''
FROM_NAME = ''
TO_ADDR = '@'
TO_NAME = 'Recipient: '
SUBJECT = '[Subject]'
SMTP_HOST = 'smtp.gmail.com'
SMTP_PORT = '465'

def main():
    message_file = sys.argv[1]
    body = construct_message_body(message_file)

    print("Sending message: " + body)

    # SMTPlib stuff.
    sender = FROM_ADDR
    receivers = [TO_ADDR]

    smtp_obj = smtplib.SMTP_SSL(SMTP_HOST, SMTP_PORT)
    smtp_obj.login(FROM_ADDR, FROM_PASS)
    smtp_obj.sendmail(sender, receivers, body)

    print("Message sent")

def construct_message_body(input_file):
    '''This function constructs the body of the message'''
    from_line = 'From: ' + FROM_NAME + ' <' + FROM_ADDR + '>'
    to_line = 'To: ' + TO_NAME + ' <' + TO_ADDR + '>'
    subject_line = 'Subject: ' + SUBJECT

    body = '\n'.join([from_line, to_line, subject_line, '\n'])

    with open(input_file, 'r') as f:
        body += f.read()
    
    body += '\n'

    return body

if __name__ == '__main__':
    main()
