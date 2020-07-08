from ec2_metadata import ec2_metadata
import json

metadata = {}
choice = ""

def choose():
    choice = input('print all keys?')
    return choice

metadata["region"] = ec2_metadata.region
metadata["account_id"] = ec2_metadata.account_id
metadata["ami_id"] = ec2_metadata.ami_id
metadata["availability_zone"] = ec2_metadata.availability_zone
metadata["ami_launch_index"] = ec2_metadata.ami_launch_index
metadata["ami_manifest_path"] = ec2_metadata.ami_manifest_path
metadata["iam_info"] = ec2_metadata.iam_info
metadata["instance_action"] = ec2_metadata.instance_action
metadata["instance_id"] = ec2_metadata.instance_id
metadata["instance_identity_document"] = ec2_metadata.instance_identity_document
metadata["instance_profile_arn"] = ec2_metadata.instance_profile_arn
metadata["instance_profile_id"] = ec2_metadata.instance_profile_id
metadata["instance_type"] = ec2_metadata.instance_type
metadata["kernel_id"] = ec2_metadata.kernel_id
metadata["mac"] = ec2_metadata.mac

choice = choose()
print(choice)

if choice.lower() == "y":
    print(json.dumps(metadata))

elif choice.lower() == "n":
    choose_key = input("key to print?")

    print(metadata[choose_key])
else:
    choose()
