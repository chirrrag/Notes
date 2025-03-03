import os

os.environ['DATABASE_URL'] ="abc"

cluster = os.getenv("DATABASE_URL")
print(cluster)