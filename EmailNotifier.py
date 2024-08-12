import os
import smtplib
import xmltodict
import json
from jinja2 import Template
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.image import MIMEImage
import datetime
import pytz
import sys
import matplotlib.pyplot as plt
import numpy as np

current_dir = os.path.dirname(os.getcwd())
parent_dir = os.path.join(current_dir, 'Output')
sys.path.append(current_dir)

from Environment import environment

receiver_email_value = environment.receiver_email

htmlTemplate = '''<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test Statistics</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }

        h1 {
            color: #333;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            margin-bottom: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        .percentage {
            color: #4CAF50; /* Green color for percentage */
        }
    </style>
</head>
<body>
    <h1><a href = "http://43.205.131.117:8900/index.html" > Total Statistics </a></h1>
    <img src="cid:pie_chart" width="300" height="300">
    <img src="cid:histogram" width="300" height="300">
    <table border="1">
        <thead>
            <tr>
                <th>Total Stats</th>
                <th>Total</th>
                <th>Pass</th>
                <th>Fail</th>
                <th>Percentage %</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>{{ total["#text"] }}</td>
                <td>
                    {%- set pass_value = total["@pass"] | default(0) | int -%}
                    {%- set fail_value = total["@fail"] | default(0) | int -%}

                    {%- set total_value = pass_value + fail_value -%}

                    {{ total_value }}
                </td>
                <td>{{ total["@pass"] }}</td>
                <td>{{ total["@fail"] }}</td>
                <td class="percentage">
                    {%- set percentage = pass_value / total_value * 100 -%}
                    {{ percentage }}
                </td>
            </tr>
        </tbody>
    </table>
</body>
</html>
'''

def generate_html_table(data):
    template = Template(htmlTemplate)
    rendered_html = template.render(suites=data["statistics"]["suite"]["stat"],
                                    total=data["statistics"]["total"]["stat"])
    with open("../test_statistics.html", "w") as output_file:
        output_file.write(rendered_html)

def convert_xml_to_json(xml_string):
    xml_dict = xmltodict.parse(xml_string)
    json_string = json.dumps(xml_dict, indent=2)
    json_data = json.loads(json_string)
    return json_data

def generate_pie_chart(pass_value, fail_value):
    labels = 'Pass', 'Fail'
    sizes = [pass_value, fail_value]
    colors = ['#4CAF50', '#FF5733']
    explode = (0.1, 0)  # explode the 1st slice (Pass)

    plt.figure(figsize=(3, 3))  # Size of the pie chart
    plt.pie(sizes, explode=explode, labels=labels, colors=colors, autopct='%1.1f%%', shadow=True, startangle=140)
    plt.axis('equal')  # Equal aspect ratio ensures that pie is drawn as a circle.

    pie_chart_path = "../pie_chart.png"
    plt.savefig(pie_chart_path)
    plt.close()
    return pie_chart_path

def generate_histogram(pass_value, fail_value):
    categories = ['Pass', 'Fail']
    values = [pass_value, fail_value]

    plt.figure(figsize=(3, 3))  # Size of the histogram
    plt.bar(categories, values, color=['#4CAF50', '#FF5733'], edgecolor='k')
    plt.xlabel('Test Result')
    plt.ylabel('Count')
    plt.title('Test Statistics Histogram')

    histogram_path = "../histogram.png"
    plt.savefig(histogram_path)
    plt.close()
    return histogram_path

class EmailNotifier:
    ROBOT_LISTENER_API_VERSION = 2

    def __init__(self, output_file='output.xml'):
        self.output_file = output_file
        file_name = output_file

        with open(file_name, "r") as file:
            file_contents = file.read()
            data = convert_xml_to_json(file_contents)
            total_stats = data["robot"]["statistics"]["total"]["stat"]
            pass_value = int(total_stats["@pass"])
            fail_value = int(total_stats["@fail"])

            # Generate HTML, Pie Chart, and Histogram
            generate_html_table(data['robot'])
            pie_chart_path = generate_pie_chart(pass_value, fail_value)
            histogram_path = generate_histogram(pass_value, fail_value)

        send_email(pie_chart_path, histogram_path)

def send_email(pie_chart_path, histogram_path):
    date = get_date()
    sender_email = "salonirajput3105@gmail.com"
    receiver_email = receiver_email_value
    subject = "Automation Report " + date

    message = MIMEMultipart()
    message["From"] = sender_email
    message["To"] = ", ".join(receiver_email)
    message["Subject"] = subject

    # Attach the HTML file
    html_file_path = "../test_statistics.html"
    with open(html_file_path, "r") as html_file:
        html_content = html_file.read()
        html_part = MIMEText(html_content, "html")
        message.attach(html_part)

    # Attach the pie chart image
    with open(pie_chart_path, "rb") as img:
        img_part = MIMEImage(img.read(), name=os.path.basename(pie_chart_path))
        img_part.add_header('Content-ID', '<pie_chart>')
        message.attach(img_part)

    # Attach the histogram image
    with open(histogram_path, "rb") as img:
        img_part = MIMEImage(img.read(), name=os.path.basename(histogram_path))
        img_part.add_header('Content-ID', '<histogram>')
        message.attach(img_part)

    # Send the email
    smtp_server = "smtp.gmail.com"
    smtp_port = 587
    smtp_username = "salonirajput3105@gmail.com"
    smtp_password = "etvv uhyl yicq xstg"
    with smtplib.SMTP(smtp_server, smtp_port) as server:
        server.starttls()
        server.login(smtp_username, smtp_password)
        server.sendmail(sender_email, receiver_email, message.as_string())

def get_date():
    utc_datetime = datetime.datetime.now(tz=pytz.utc)
    ist_timezone = pytz.timezone('Asia/Kolkata')
    ist_datetime = utc_datetime.astimezone(ist_timezone)
    return ist_datetime.strftime('%d-%m-%Y %H:%M')

if __name__ == '__main__':
    notifier = EmailNotifier()
