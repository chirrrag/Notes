import sys
import hashlib

sha256 = hashlib.sha256()

# clusterId = b"np-t-sdfc-26119-dev-aws-ephemeral-6924796"
clusterId = b"np-t-sdfc-26119-dev-aws-ephemeral-6915691"

# clusterHash = clusterId.encode("utf-8").hexdigest()[:8]

sha256.update(clusterId)

clusterHash = sha256.hexdigest()[:8]

print(clusterHash)

assetId = "ephemeral-6924796-"+clusterHash