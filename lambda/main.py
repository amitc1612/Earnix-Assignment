from datetime import datetime
import json

def lambda_handler(event, context):
    now = datetime.now()
    current_time = now.strftime("%H:%M:%S")
    return {
        'statusCode': 200,
        'body': json.dumps(current_time)
    }
