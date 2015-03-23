from django.core.management import setup_environ
from obelix import settings
setup_environ(settings)

def run():
	print "Hello"
