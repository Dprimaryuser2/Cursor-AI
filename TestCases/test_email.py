# import email
# import imaplib
#
# def search_and_fetch_email(server, port, email_address, password, subject):
#     try:
#         # Connect to the email server
#         mail = imaplib.IMAP4_SSL(server, port)
#         print(f"Connecting to {server}:{port}")
#
#         mail.login(email_address, password)
#         print(f"Logged in as {email_address}")
#
#         mail.select('inbox')
#         print("Selected inbox")
#
#         # Search for emails with the specified subject
#         result, data = mail.search(None, f'(SUBJECT "{subject}")')
#         if result != "OK":
#             print(f"Search failed: {result}")
#             return None
#         email_ids = data[0].split()
#         print(f"Email IDs found: {email_ids}")
#
#         # Fetch the latest email and extract the body
#         if email_ids:
#             latest_email_id = email_ids[-1]
#             result, data = mail.fetch(latest_email_id, '(RFC822)')
#             if result != "OK":
#                 print(f"Fetch failed: {result}")
#                 return None
#             raw_email = data[0][1].decode('utf-8')  # Decode bytes to string
#             print(f"Raw email: {raw_email[:100]}...")  # Print a snippet of the raw email for debugging
#
#             email_message = email.message_from_string(raw_email)  # Use message_from_string to parse email content
#
#             # Extract the email body
#             email_body = ""
#             if email_message.is_multipart():
#                 for part in email_message.walk():
#                     if part.get_content_type() == "text/plain":
#                         email_body += part.get_payload(decode=True).decode()
#             else:
#                 email_body = email_message.get_payload(decode=True).decode()
#
#             print(f"Email body: {email_body[:100]}...")  # Print a snippet of the email body for debugging
#             return email_body
#
#         # If no email with the specified subject is found
#         print("No emails found with the specified subject")
#         return None
#     except imaplib.IMAP4.error as e:
#         print(f"IMAP error: {e}")
#         return None
#
# body = search_and_fetch_email("imap.gmail.com", "993", "dprimaryuser@gmail.com", "aqwb qaoi bkwd jqbb", "Your i9_store_p1 Invoice Receipt | ITsp102240176 | 10-07-2024")
#
# print(body)
import email
import imaplib
import email
import imaplib


def search_and_fetch_email(server, port, email_address, password, subject):
    try:
        # Connect to the email server
        mail = imaplib.IMAP4_SSL(server, port)
        print(f"Connecting to {server}:{port}")

        mail.login(email_address, password)
        print(f"Logged in as {email_address}")

        mail.select('inbox')
        print("Selected inbox")

        # Search for emails with the specified subject
        result, data = mail.search(None, f'(SUBJECT "{subject}")')
        if result != "OK":
            print(f"Search failed: {result}")
            return None, False  # Return False to indicate no email found
        email_ids = data[0].split()
        print(f"Email IDs found: {email_ids}")

        # Fetch the latest email and extract the body
        if email_ids:
            latest_email_id = email_ids[-1]
            result, data = mail.fetch(latest_email_id, '(RFC822)')
            if result != "OK":
                print(f"Fetch failed: {result}")
                return None, False  # Return False to indicate fetch failure
            raw_email = data[0][1]  # Get the raw email content

            # Parse the raw email into a message object
            email_message = email.message_from_bytes(raw_email)

            # Initialize variables to accumulate email body and attachments
            email_body = ""
            attachments_found = False

            # Function to recursively extract text from email parts and find attachments
            def extract_text_and_attachments(email_part):
                nonlocal email_body, attachments_found
                content_type = email_part.get_content_type()

                if content_type == "text/plain":
                    # Extract plain text body
                    email_body += email_part.get_payload(decode=True).decode()
                elif content_type == "text/html":
                    # Handle HTML content if needed
                    pass
                elif "image" in content_type:
                    # Skip image parts
                    pass
                elif content_type == "multipart/mixed":
                    # Handle mixed content (attachments)
                    attachments_found = True  # Set flag to True if any attachments found
                    for part in email_part.get_payload():
                        if part.get_content_maintype() == 'multipart':
                            # Recursively handle nested multipart
                            extract_text_and_attachments(part)
                        elif part.get_content_maintype() == 'application' and part.get('Content-Disposition'):
                            # This part is an attachment
                            pass  # You can further process attachments if needed
                        else:
                            # Handle other content types
                            extract_text_and_attachments(part)
                elif email_part.is_multipart():
                    # Recursively handle other multipart types
                    for part in email_part.get_payload():
                        extract_text_and_attachments(part)

            # Call the function with the root email message
            extract_text_and_attachments(email_message)

            # Print debug info
            print(f"Email body: {email_body[:100]}...")  # Print a snippet of the email body for debugging
            print(f"Attachments found: {attachments_found}")

            return email_body.strip(), attachments_found  # Return email body and attachments found flag

        # If no email with the specified subject is found
        print("No emails found with the specified subject")
        return None, False
    except imaplib.IMAP4.error as e:
        print(f"IMAP error: {e}")
        return None, False


# Usage example
body, has_attachments = search_and_fetch_email("imap.gmail.com", "993", "dprimaryuser@gmail.com", "aqwb qaoi bkwd jqbb",
                                               "Your i9_store_p1 Invoice Receipt | ITsp102240176 | 10-07-2024")

print("Email body:")
print(body)

if has_attachments:
    print("\nEmail contains attachments.")
else:
    print("\nNo attachments found in the email.")
