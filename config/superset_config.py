#---------------------------------------------------------
# Superset specific config
#---------------------------------------------------------
import os

ROW_LIMIT = 1000

POSTGRES_HOST = os.environ.get("POSTGRES_HOST", "192.168.246.223")
POSTGRES_PORT = os.environ.get("POSTGRES_PORT", "5432")
POSTGRES_USER = os.environ.get("POSTGRES_USER", 'extendederp_user')
POSTGRES_PASSWORD = os.environ.get("POSTGRES_PASSWORD", 'changeMe!23')

# SQLALCHEMY_DATABASE_URI = f'postgresql+psycopg2://{POSTGRES_USER}:{POSTGRES_PASSWORD}@{POSTGRES_HOST}:{POSTGRES_PORT}/superset_primary'

MAPBOX_API_KEY = os.environ.get("MAPBOX_API_KEY", 'pk.eyJ1Ijoiamhhcm1vbjk2IiwiYSI6ImNramdkZmJ1bDQ5czUyc3BrNWx1ZDVncXAifQ.LsxGR1aFaqw4h3tgVnmedA')

WEBDRIVER_BASEURL="http://0.0.0.0:8080/"
