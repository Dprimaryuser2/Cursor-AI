import os
import requests
import base64
from datetime import datetime

# Bitbucket configuration
BITBUCKET_USER = 'your_bitbucket_username'
BITBUCKET_APP_PASSWORD = 'your_bitbucket_app_password'
REPO_OWNER = 'your_bitbucket_workspace'
REPO_NAME = 'your_repository_name'
BRANCH_NAME = 'main'  # or your specific branch

# Function to create or update a file in the Bitbucket repository
def upload_to_bitbucket(file_path, repo_path):
    url = f'https://api.bitbucket.org/2.0/repositories/{REPO_OWNER}/{REPO_NAME}/src/{BRANCH_NAME}/{repo_path}'
    with open(file_path, 'rb') as file:
        content = base64.b64encode(file.read()).decode()
    
    data = {
        'message': f'Upload {os.path.basename(file_path)}',
        'content'3: content
    }
    
    response = requests.put(url, data=data, auth=(BITBUCKET_USER, BITBUCKET_APP_PASSWORD))
    if response.status_code == 201:
        print(f'Successfully uploaded {file_path} to {repo_path}')
    else:
        print(f'Failed to upload {file_path}: {response.content}')

# Main function to upload the report folder
def upload_report_folder(folder_path):
    today_date = datetime.now().strftime('%Y-%m-%d')
    repo_folder = f'reports/{today_date}/'
    
    for root, _, files in os.walk(folder_path):
        for file in files:
            file_path = os.path.join(root, file)
            repo_path = os.path.join(repo_folder, file)
            upload_to_bitbucket(file_path, repo_path)

if __name__ == '__main__':
    # Specify the path to your local reports folder
    local_report_folder = 'reports'
    upload_report_folder(local_report_folder)
