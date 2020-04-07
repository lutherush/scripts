#!/usr/bin/env python

from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart


# create the message
msg = MIMEMultipart('alternative')
msg['Subject'] = "My subject"
msg['From'] = "foo@example.org"
msg['To'] = "bar@example.net"

# Text of the message
html = """<html>
          <body>
          This is <i>HTML</i>
          </body>
          </html>
"""
text="This is HTML"

# Create the two parts
plain = MIMEText(text, 'plain')
html = MIMEText(html, 'html')

# Let's add them
msg.attach(plain)
msg.attach(html)

print msg.as_string()
