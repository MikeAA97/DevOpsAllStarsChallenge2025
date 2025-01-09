import boto3
import json
import urllib.request
import os


s3_client = boto3.client("s3")

NBA_API_KEY  = os.getenv("NBA_API_KEY")
NBA_ENDPOINT = os.getenv("NBA_ENDPOINT")
S3_BUCKET    = os.getenv("S3_BUCKET")

api_url = f"{NBA_ENDPOINT}?key={NBA_API_KEY}"
    
def fetch_nba_data():
    """Fetch NBA player data from sportsdata.io."""
    try:
        with urllib.request.urlopen(api_url) as response:
            data = json.loads(response.read().decode())
        print("Fetched NBA data successfully.")
        return data
    except Exception as e:
        print(f"Error fetching NBA data: {e}")
        return []

def convert_to_line_delimited_json(data):
    """Convert data to line-delimited JSON format."""
    print("Converting data to line-delimited JSON format...")
    return "\n".join([json.dumps(record) for record in data])

def upload_data_to_s3(data):
    """Upload NBA data to the S3 bucket."""
    try:
        # Convert data to line-delimited JSON
        line_delimited_data = convert_to_line_delimited_json(data)

        # Define S3 object key
        file_key = "raw-data/nba_player_data.jsonl"

        # Upload JSON data to S3
        s3_client.put_object(
            Bucket=S3_BUCKET,
            Key=file_key,
            Body=line_delimited_data
        )
        print(f"Uploaded data to S3: {file_key}")
    except Exception as e:
        print(f"Error uploading data to S3: {e}")




def lambda_handler(event, context):
    try:
        nba_data = fetch_nba_data()
        upload_data_to_s3(nba_data)
        return {"statusCode": 200, "body": "Data Fetched and Pushed to S3"}
    except Exception as e:
        print(f"Error Retrieving Data from API: {e}")
        return {"statusCode": 500, "body": "Error Retrieving Data"}
