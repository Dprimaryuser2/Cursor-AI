import os
import xml.etree.ElementTree as ET
import smtplib
import zipfile
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
import json
from email.mime.base import MIMEBase
from email import encoders


def load_email_config(config_file='Runner/notifier.json'):
    """
    Load email configuration from a JSON file.
    """
    with open(config_file, 'r') as file:
        config = json.load(file)
    return config['email']


# Define main suites
main_suites = {"Billing", "Order", "Exchange", "Return", "Promo"}


def extract_suite_statistics(xml_file_path):
    """
    Extract suite-wise statistics from the XML file.
    """
    tree = ET.parse(xml_file_path)
    root = tree.getroot()

    suite_stats = []

    for suite in root.findall('.//suite/stat'):
        name = suite.get('name')
        total_tests = int(suite.get('pass', '0')) + int(suite.get('fail', '0')) + int(suite.get('skip', '0'))
        passed = int(suite.get('pass', '0'))
        failed = int(suite.get('fail', '0'))
        skipped = int(suite.get('skip', '0'))

        suite_stats.append({
            'name': name,
            'total_tests': total_tests,
            'passed': passed,
            'failed': failed,
            'skipped': skipped
        })

    return suite_stats


def create_html_summary(suite_summaries):
    """
    Create an HTML summary with suite-wise details and a combined percentage bar.
    """
    html_content = """
    <html>
        <body style="font-family: Arial, sans-serif;">
            <h2 style="color: #4CAF50;">Automation Test Report Summary</h2>
            <table border="1" cellpadding="10" cellspacing="0" style="border-collapse: collapse; width: 80%; border: 2px solid #ddd;">
                <tr style="background-color: #f2f2f2;">
                    <th style="text-align: left; color: #333; border-bottom: 2px solid #ddd;">Suite Name</th>
                    <th style="text-align: left; color: #333; border-bottom: 2px solid #ddd;">Total Tests</th>
                    <th style="text-align: left; color: #333; border-bottom: 2px solid #ddd;">Passed</th>
                    <th style="text-align: left; color: #333; border-bottom: 2px solid #ddd;">Failed</th>
                    <th style="text-align: left; color: #333; border-bottom: 2px solid #ddd;">Skipped</th>
                    <th style="text-align: left; color: #333; border-bottom: 2px solid #ddd;">Pass/Fail Rate</th>
                </tr>
    """

    # Add a row to separate main suites from other suites
    suite_rows = []
    for summary in suite_summaries:
        total_tests = summary['total_tests']
        passed = summary['passed']
        failed = summary['failed']

        # Calculate percentages
        if total_tests > 0:
            pass_percentage = (passed / total_tests) * 100
            fail_percentage = (failed / total_tests) * 100
        else:
            pass_percentage = 0
            fail_percentage = 0

        # Create a combined percentage bar
        bar_width = 100
        pass_width = pass_percentage
        fail_width = fail_percentage

        # Ensure percentages do not exceed 100%
        if pass_width + fail_width > bar_width:
            fail_width = bar_width - pass_width

        combined_bar = f'''
        <div style="width: {bar_width}%; height: 20px; background-color: #e2e3e5; border: 1px solid #ddd; display: flex;">
            <div style="width: {pass_width}%; background-color: #28a745; color: #fff; text-align: center; line-height: 20px;">{passed} ({pass_percentage:.1f}%)</div>
            <div style="width: {fail_width}%; background-color: #dc3545; color: #fff; text-align: center; line-height: 20px;">{failed} ({fail_percentage:.1f}%)</div>
        </div>
        '''

        # Collect rows for main suites and other suites
        if summary['name'] in main_suites:
            suite_rows.append(f"""
            <tr>
                <td colspan="6" style="font-weight: bold; text-align: center; border-top: 2px solid #4CAF50; border-bottom: 2px solid #ddd; background-color: #e9f5e9;">
                    <strong>Main Suite: {summary['name']}</strong>
                </td>
            </tr>
            """)
        suite_rows.append(f"""
        <tr>
            <td>{summary['name']}</td>
            <td>{summary['total_tests']}</td>
            <td style="color: #28a745;">{summary['passed']}</td>
            <td style="color: #dc3545;">{summary['failed']}</td>
            <td>{summary['skipped']}</td>
            <td>{combined_bar}</td>
        </tr>
        """)

    # Add rows to the table
    html_content += "".join(suite_rows)

    html_content += """
            </table>
            <p style="color: #555;">For more details, please refer to the full report.</p>
        </body>
    </html>
    """
    return html_content


def send_email(html_content, email_config, zip_path='attachments.zip'):
    """
    Send the HTML summary via email.
    """
    msg = MIMEMultipart("alternative")
    msg["Subject"] = "Automation Test Report Summary"
    msg["From"] = email_config['sender_email']
    msg["To"] = ", ".join(email_config['receiver_emails'])

    # Attach the HTML content
    msg.attach(MIMEText(html_content, "html"))

    with open(zip_path, 'rb') as zip_file:
        part = MIMEBase('application', 'zip')
        part.set_payload(zip_file.read())
        encoders.encode_base64(part)
        part.add_header('Content-Disposition', f'attachment; filename="{os.path.basename(zip_path)}"')
        msg.attach(part)
    # Send the email
    with smtplib.SMTP(email_config['smtp_server'], email_config['smtp_port']) as server:
        server.starttls()
        server.login(email_config['smtp_username'], email_config['smtp_password'])
        server.sendmail(email_config['sender_email'], email_config['receiver_emails'], msg.as_string())


def compress_files(file_paths, zip_path='attachments.zip'):
    """
    Compress the given files into a zip archive.
    """
    with zipfile.ZipFile(zip_path, 'w') as zipf:
        for file_path in file_paths:
            zipf.write(file_path, os.path.basename(file_path))
    return zip_path


if __name__ == "__main__":
    # Load Email Data
    email_config = load_email_config()

    # Specify the path to the output.xml
    xml_path = os.path.join(r"", "output.xml")

    # Extract suite-wise summary statistics
    suite_summaries = extract_suite_statistics(xml_path)

    # Debug: Print extracted suite summaries
    print("Extracted Suite Summaries:")
    print(suite_summaries)

    # Create the HTML summary with suite-wise details
    html_summary = create_html_summary(suite_summaries)

    # attachment files
    attachment_files = [
        'log.html',
        "report.html",  # Add more file paths as needed
    ]

    # Send the summary via email
    zip_file_path = compress_files(attachment_files)
    send_email(html_summary,email_config, zip_path=zip_file_path)