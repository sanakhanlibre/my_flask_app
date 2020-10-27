import os
from flask import Flask
import socket

app = Flask(__name__)

@app.route('/')
def hello():
	html = "<h3>Hello {name}!</h3>" \
           "<b>Hostname:</b> {hostname}<br/>"
	return html.format(name=os.getenv("NAME", "world"), hostname=socket.gethostname())