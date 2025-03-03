python_output=$(python3 - << 'EOF'
import hashlib
import os
os.environ['CLUSTER_NAME'] ="eph-232323"
os.environ['AWS_CLUSTER_ID'] ="np-t-sdfc-26119-dev-aws-ephemeral-6915691"

sha256 = hashlib.sha256()
# clusterName = CLUSTER_NAME
clusterName = os.getenv("CLUSTER_NAME")

# print("empty")
# print(clusterName)
# clusterId = ${AWS_CLUSTER_ID}

clusterId = os.getenv("AWS_CLUSTER_ID")

# print(clusterId)
if clusterId is None:
    raise ValueError("AWS_CLUSTER_ID environment variable is not set")
if clusterName is None:
    raise ValueError("CLUSTER_NAME environment variable is not set")

sha256.update(clusterId.encode('utf-8'))

clusterHash = sha256.hexdigest()[:8]

assetId = clusterName + "-" + clusterHash
print(assetId)
EOF
)
cluster_hash=$(echo "$python_output" | sed -n 1p)
asset_id=$(echo "$python_output" | sed -n 2p)
echo $cluster_hash
echo $asset_id