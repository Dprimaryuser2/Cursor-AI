import os
import xmltodict
import json
import requests
import datetime
import pytz

# Define folder paths
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
RUNNER_DIR = os.path.join(BASE_DIR, 'runner')
OUTPUT_DIR = os.path.join(BASE_DIR, 'output')

# Path to notifier.json and XML output file
NOTIFIER_CONFIG_FILE = os.path.join(RUNNER_DIR, 'notifier.json')
OUTPUT_XML_FILE = os.path.join(OUTPUT_DIR, 'output.xml')


def load_notifier_config():
    """
    Load the notifier configuration from a JSON file.
    """
    with open(NOTIFIER_CONFIG_FILE, 'r') as file:
        return json.load(file)


def convert_xml_to_json(xml_string):
    """
    Convert XML string to JSON.
    """
    xml_dict = xmltodict.parse(xml_string)
    json_string = json.dumps(xml_dict, indent=2)
    json_data = json.loads(json_string)
    return json_data


def get_date():
    """
    Get the current date in IST timezone.
    """
    utc_datetime = datetime.datetime.now(tz=pytz.utc)
    ist_timezone = pytz.timezone('Asia/Kolkata')
    ist_datetime = utc_datetime.astimezone(ist_timezone)
    return ist_datetime.strftime('%d-%m-%Y %H:%M')


def format_statistics(stats):
    """
    Format test statistics into a plain text message.
    """
    pass_value = stats.get('@pass', '0')
    fail_value = stats.get('@fail', '0')
    skip_value = stats.get('@skip', '0')

    message = (
        f"Test Report - {get_date()}\n"
        f"Total Tests: {int(pass_value) + int(fail_value) + int(skip_value)}\n"
        f"Passed: {pass_value}\n"
        f"Failed: {fail_value}\n"
        f"Skipped: {skip_value}\n"
    )

    return message


def send_stats_to_slack(message, slack_urls):
    """
    Send test statistics to all Slack channels using webhook URLs.
    """
    for url in slack_urls:
        payload = {'text': message}
        response = requests.post(url, json=payload)
        if response.status_code == 200:
            print(f"Statistics sent to Slack successfully")
        else:
            print(f"Failed to send statistics to Slack via {url}. Status code: {response.status_code}")


def process_output_file(slack_urls):
    """
    Process the XML file, compute statistics, and send them to Slack.
    """
    with open(OUTPUT_XML_FILE, "r") as file:
        file_contents = file.read()
        data = convert_xml_to_json(file_contents)
        total_stats = data.get("robot", {}).get("statistics", {}).get("total", {}).get("stat", {})
        stats_message = format_statistics(total_stats)
        send_stats_to_slack(stats_message, slack_urls)


if __name__ == '__main__':
    config = load_notifier_config()
    slack_urls = config.get('slack_url', [])

    if slack_urls:
        process_output_file(slack_urls)
    else:
        print("No Slack URLs found in the configuration file.")
