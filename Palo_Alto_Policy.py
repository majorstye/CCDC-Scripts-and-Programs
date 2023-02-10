import requests
import xml.etree.ElementTree as ET

# Set the firewall's management IP address and API key
firewall_ip = 'X.X.X.X'
api_key = 'api_key'

# Define the headers for the API request
headers = {
    'Content-Type': 'application/xml',
    'Accept': 'application/xml',
    'Authorization': 'Key ' + api_key
}

# Define the URL for the API request
url = 'https://' + firewall_ip + '/api/'

# Define the XML payload for the API request to create a security rule
rule_xml = """
<rule>
  <name>Block Incoming Traffic</name>
  <source>
    <zone>untrust</zone>
  </source>
  <destination>
    <zone>trust</zone>
  </destination>
  <application>any</application>
  <action>deny</action>
  <log-setting>
    <log-enabled>yes</log-enabled>
  </log-setting>
</rule>
"""

# Send the API request to create the security rule
response = requests.post(url + 'policies/policy/1/rules', data=rule_xml, headers=headers)

# Parse the XML response
root = ET.fromstring(response.text)

# Check if the request was successful
if root.attrib['status'] == 'success':
    print('Security rule created successfully!')
else:
    print('Failed to create security rule. Error:', root[0].text)
