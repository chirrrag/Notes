from hashlib import sha256

clusterId = "np-t-sdfc-26119-dev-aws-ephemeral-6924796"

clusterHash = clusterId.encode("utf-8").hexdigest()[:8]

print(clusterHash)

assetId = "ephemeral-6924796-"+clusterHash