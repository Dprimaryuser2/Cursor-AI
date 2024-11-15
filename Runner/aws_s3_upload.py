import boto3
import os
import zipfile
from datetime import datetime
from botocore.exceptions import NoCredentialsError

# Define folder paths
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUTPUT_DIR = os.path.join(BASE_DIR, 'output')
ZIP_FILE_NAME = 'report.zip'

def create_zip_from_folder(folder_path, zip_file_path):
    """
    Creates a zip file from the specified folder.
    """
    with zipfile.ZipFile(zip_file_path, 'w', zipfile.ZIP_DEFLATED) as zipf:
        for root, dirs, files in os.walk(folder_path):
            for file in files:
                local_file_path = os.path.join(root, file)
                # Write file to the zip file with relative path
                zipf.write(local_file_path, os.path.relpath(local_file_path, folder_path))

def upload_file_to_s3(file_path, bucket_name, s3_key):
    """
    Uploads a file to an S3 bucket.
    """
    s3 = boto3.client('s3')

    try:
        s3.upload_file(file_path, bucket_name, s3_key)
        print(f"Successfully uploaded: {file_path} to s3://{bucket_name}/{s3_key}")
    except FileNotFoundError:
        print(f"The file {file_path} was not found")
    except NoCredentialsError:
        print("Credentials not available")
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == '__main__':
    # Create zip file from the folder
    zip_file_path = os.path.join(BASE_DIR, ZIP_FILE_NAME)
    create_zip_from_folder(OUTPUT_DIR, zip_file_path)

    # Define S3 bucket and date-wise folder
    bucket_name = 'zwingwebpos'  # Replace with your S3 bucket name
    now = datetime.now()
    date_folder = now.strftime('%Y/%m/%d')
    s3_key = os.path.join(date_folder, ZIP_FILE_NAME)

    # Upload the zip file to S3
    upload_file_to_s3(zip_file_path, bucket_name, s3_key)

    # Optionally, remove the local zip file after upload
    if os.path.exists(zip_file_path):
        os.remove(zip_file_path)
        print(f"Local zip file {zip_file_path} removed.")
