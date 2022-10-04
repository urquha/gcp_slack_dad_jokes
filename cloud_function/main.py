import httpx
import json
import os

def load_config():
    return {
        'url' : os.environ.get("SLACK_WEBHOOK_URL"),
    }

def main(data: dict, context: dict=None):
    config = load_config()
    httpx_client = httpx.Client()
    
    joke = json.loads(httpx_client.get('https://icanhazdadjoke.com/', headers={"Accept": "application/json"}).text)['joke']
    data = "{'text':'" + joke + "'}" 
    print(data)
    httpx_client.post(config['url'], headers={'Content-type': 'application/json'}, data=data)

if __name__ == "__main__":
    main({})