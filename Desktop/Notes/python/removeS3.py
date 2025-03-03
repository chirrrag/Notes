import boto3
from botocore.exceptions import NoCredentialsError, PartialCredentialsError

def delete_bucket_content(bucket_name):
    try:
        s3 = boto3.resource('s3')
        bucket = s3.Bucket(bucket_name)
        
        # Check if the bucket contains the object with "fb744dbd" in its name
        for obj in bucket.objects.all():
            if 'fb744dbd' in obj.key:
                print(f"Bucket {bucket_name} contains object {obj.key}")
                
                # Remove versioning if enabled
                bucket_versioning = s3.BucketVersioning(bucket_name)
                if bucket_versioning.status == 'Enabled':
                    print(f"Disabling versioning for bucket {bucket_name}")
                    bucket_versioning.suspend()
                
                # Delete all object versions and delete markers
                for version in bucket.object_versions.all():
                    print(f"Deleting version {version.id} of object {version.object_key}")
                    version.delete()
                
                # Delete all objects in the bucket
                for obj in bucket.objects.all():
                    print(f"Deleting object {obj.key}")
                    obj.delete()
                
                # Delete the bucket
                print(f"Deleting bucket {bucket_name}")
                bucket.delete()
                print(f"Bucket {bucket_name} deleted successfully")
                
                return
        
        print(f"No objects found in bucket {bucket_name} with name containing 'fb744dbd'")
        
    except NoCredentialsError:
        print("Credentials not available")
    except PartialCredentialsError:
        print("Incomplete credentials provided")
    except Exception as e:
        print(f"An error occurred: {e}")

# Example usage
bucket_name = 'your-bucket-name'
delete_bucket_content(bucket_name)
